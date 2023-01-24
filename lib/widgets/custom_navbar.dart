import 'package:blocecommerce/screens/screens.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

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

  //Navbar Dynamically changes with this widget method
  List<Widget>? _selectNavBar(context, screen) {
    switch (screen) {
      case HomeScreen.routeName:
        return _buildNavBar(context);
      case CatalogScreen.routeName:
        return _buildNavBar(context);
      case WishlistScreen.routeName:
        return _buildNavBar(context);
      case ProductScreen.routeName:
        return _buildAddToCartNavBar(context, product);
      case CartScreen.routeName:
        return _buildGoToCheckoutNavBar(context);
      default:
        _buildNavBar(context);
    }
  }

  List<Widget> _buildNavBar(context) {
    return [
      IconButton(
        icon: const Icon(Icons.home, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, HomeScreen.routeName);
        },
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, CartScreen.routeName);
        },
      ),
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ))
    ];
  }

  List<Widget> _buildAddToCartNavBar(context, product) {
    return [
      IconButton(
        icon: const Icon(Icons.share, color: Colors.white),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.favorite, color: Colors.white),
        onPressed: () {
          const snackBar = SnackBar(content: Text('Added to your Wishlist!'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, CartScreen.routeName);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: const RoundedRectangleBorder(),
        ),
        child: Text(
          'ADD TO CART',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    ];
  }

  List<Widget> _buildGoToCheckoutNavBar(context) {
    return [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, CartScreen.routeName);
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
}
