// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blocecommerce/blocs/blocs.dart';
import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:blocecommerce/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CatalogScreen(category: category),
    );
  }

  final Category category;

  const CatalogScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBox(category:category),
            _CatalogProductList(category: category),
          ],
        ),
      ),
    );
  }
}

class _CatalogProductList extends StatelessWidget {
  const _CatalogProductList({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductLoaded) {
          final List<Product> categoryProducts = state.products
              .where((product) => product.category == category.name)
              .toList();
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.15),
            itemCount: categoryProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                  child: ProductCard.catalog(
                product: categoryProducts[index],
              ));
            },
          );
        } else {
          return const Center(
            child: Text("Something is wrong"),
          );
        }
      },
    );
  }
}
