import 'package:blocecommerce/blocs/blocs.dart';
import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  static const String routeName = '/wishlist';

  const WishlistScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const WishlistScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Wishlist'),
        bottomNavigationBar: const CustomNavBar(screen: routeName),
        body: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return Center(child: const CircularProgressIndicator());
            }
            if (state is WishlistLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: _wishlist(state),
              );
            }
            return const Text('Something went wrong!');
          },
        ));
  }

  GridView _wishlist(WishlistLoaded state) {
    return GridView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2.25,
                ),
                itemCount: state.wishlist.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                      child: ProductCard.wishlist(
                    product: state.wishlist.products[index],
                  ));
                },
              );
  }
}
