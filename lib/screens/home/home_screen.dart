import 'package:blocecommerce/models/category_model.dart';
import 'package:blocecommerce/models/product_model.dart';
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
        body: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: categories
                  .map((category) => HeroCarouselCard(category: category))
                  .toList(),
            ),
            //Product Area
            const SectionTitle(title: "Recommended"),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: products
            //         .where((element) => element.isRecommended == true)
            //         .map((e) => Padding(
            //               padding: const EdgeInsets.only(right: 8.0),
            //               child: ProductCard(product: e),
            //             ))
            //         .toList(),
            //   ),
            // ),
            ProductCarousel(
                products: products
                    .where((element) => element.isRecommended == true)
                    .toList()),
            const SectionTitle(title: "Most Popular"),
            ProductCarousel(
                products: products
                    .where((element) => element.isPopular == true)
                    .toList()),
          ],
        ),
      ),
    );
  }
}
