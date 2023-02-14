import 'package:blocecommerce/blocs/blocs.dart';
import 'package:blocecommerce/models/models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = Category.categories;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Zero To Unicorn',
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: const CustomNavBar(screen: HomeScreen.routeName),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CategoryLoaded) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.5,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      items: state.categories
                          .map((category) =>
                              HeroCarouselCard(category: category))
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  }
                },
              ),
              const SectionTitle(title: 'RECOMMENDED'),
              //.where method is using for focused on points
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductLoaded) {
                    return ProductCarousel(
                      products: state.products
                          .where((product) => product.isRecommended)
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  }
                },
              ),
              const SectionTitle(title: 'MOST POPULAR'),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductLoaded) {
                    return ProductCarousel(
                      products: state.products
                          .where((product) => product.isPopular)
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
