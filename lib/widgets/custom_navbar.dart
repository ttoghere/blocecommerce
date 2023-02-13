// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:blocecommerce/models/payment_method_model.dart';
import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocecommerce/blocs/blocs.dart';
import 'package:blocecommerce/models/models.dart';
import 'package:blocecommerce/screens/screens.dart';

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
        child: (screen == ProductScreen.routeName)
            ? AddToCartNav(product: product!)
            : (screen == CartScreen.routeName)
                ? const GoToCheckoutNav()
                : (screen == CheckoutScreen.routeName)
                    ? const OrderNowNav()
                    : const HomeNav(),
      ),
    );
  }
}

class AddToCartNav extends StatelessWidget {
  final Product product;
  const AddToCartNav({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
      ],
    );
  }
}

class GoToCheckoutNav extends StatelessWidget {
  const GoToCheckoutNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
      ],
    );
  }
}

class OrderNowNav extends StatelessWidget {
  const OrderNowNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CheckoutLoaded) {
              if (state.paymentMethod == PaymentMethod.creditCard) {
                return SizedBox(
                  child: Text(
                    "Pay With Credit Card",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white),
                  ),
                );
              }
              if (Platform.isIOS &&
                  state.paymentMethod == PaymentMethod.applePay) {
                return ApplePay(
                  products: state.products!,
                  total: state.total!,
                );
              } else {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, PaymentSelectScreen.routeName);
                    },
                    child: Text(
                      "Choose Payment",
                      style: Theme.of(context).textTheme.headline3,
                    ));
              }
            } else {
              return const Center(child: Text("Something is wrong"));
            }
          },
        ),
      ],
    );
  }
}

class HomeNav extends StatelessWidget {
  const HomeNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
      ],
    );
  }
}
