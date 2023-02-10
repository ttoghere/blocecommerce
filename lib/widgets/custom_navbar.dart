import 'package:blocecommerce/blocs/blocs.dart';
import 'package:blocecommerce/models/models.dart';
import 'package:blocecommerce/screens/order_conf/order_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'apple_pay.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;

  const CustomNavBar({
    Key? key,
    required this.screen,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _selectNavBar(context, screen)!,
        ),
      ),
    );
  }

  //Switch Case Statement is a useful changer in app
  //it changes the options with parameters
  List<Widget>? _selectNavBar(context, screen) {
    switch (screen) {
      case '/':
        return _buildNavBar(context);
      case '/catalog':
        return _buildNavBar(context);
      case '/wishlist':
        return _buildNavBar(context);
      case '/product':
        return _buildAddToCartNavBar(context, product);
      case '/cart':
        return _buildGoToCheckoutNavBar(context);
      case '/checkout':
        return _buildOrderNowNavBar(context);
      case "/order":
        return _buildNavBar(context);
      case "/paymentselect":
        return _buildNavBar(context);
      default:
        _buildNavBar(context);
    }
  }

  List<Widget> _buildNavBar(context) {
    return [
      IconButton(
        icon: const Icon(Icons.home, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
      ),
      IconButton(
        icon: const Icon(Icons.person, color: Colors.white),
        onPressed: () {},
      )
    ];
  }

  List<Widget> _buildAddToCartNavBar(context, product) {
    return [
      IconButton(
        icon: const Icon(Icons.share, color: Colors.white),
        onPressed: () {},
      ),
      BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          return IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              context.read<WishlistBloc>().add(AddProductToWishlist(product));
              SnackBar snackBar =
                  const SnackBar(content: Text('Added to your Wishlist!'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          );
        },
      ),
      BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
              context.read<CartBloc>().add(AddProduct(product));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: const RoundedRectangleBorder(),
            ),
            child: Text(
              'ADD TO CART',
              style: Theme.of(context).textTheme.headline3,
            ),
          );
        },
      ),
    ];
  }

  List<Widget> _buildGoToCheckoutNavBar(context) {
    return [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/checkout');
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: const RoundedRectangleBorder(),
        ),
        child: Text(
          'GO TO CHECKOUT',
          style: Theme.of(context).textTheme.headline3,
        ),
      )
    ];
  }

  List<Widget> _buildOrderNowNavBar(context) {
    return [
      BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CheckoutLoaded) {
            return ApplePay(
              products: state.products!,
              total: state.total!,
            );
            // return ElevatedButton(
            //   onPressed: () {
            //     context
            //         .read<CheckoutBloc>()
            //         .add(ConfirmCheckout(checkout: state.checkout));
            //     Navigator.of(context).pushNamed(OrderConfirmation.routeName);
            //   },
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.white,
            //     shape: const RoundedRectangleBorder(),
            //   ),
            //   child: Text(
            //     'Order Now',
            //     style: Theme.of(context).textTheme.headline3,
            //   ),
            // );
          } else {
            return const Center(child: Text("Something is wrong"));
          }
        },
      )
    ];
  }
}
