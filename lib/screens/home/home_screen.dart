import 'package:blocecommerce/models/models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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

  List<Product> products = Product.products;

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
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.5,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                items: categories
                    .map((category) => HeroCarouselCard(category: category))
                    .toList(),
              ),
              const SectionTitle(title: 'RECOMMENDED'),
              //.where method is using for focused on points
              ProductCarousel(
                products:
                    products.where((product) => product.isRecommended).toList(),
              ),
              const SectionTitle(title: 'MOST POPULAR'),
              ProductCarousel(
                products:
                    products.where((product) => product.isPopular).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
