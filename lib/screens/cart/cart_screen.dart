import 'package:blocecommerce/blocs/blocs.dart';
import 'package:blocecommerce/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/widgets.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CartScreen(),
    );
  }

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Cart cart = const Cart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Cart'),
        bottomNavigationBar: const CustomNavBar(screen: CartScreen.routeName),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.cart.freeDeliveryString,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: const RoundedRectangleBorder(),
                            elevation: 0,
                          ),
                          child: Text(
                            'Add More Items',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                          itemCount: state.cart
                              .productQuantity(state.cart.products)
                              .keys
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return CartProductCard(
                              product: state.cart
                                  .productQuantity(state.cart.products)
                                  .keys
                                  .elementAt(index),
                              quantity: state.cart
                                  .productQuantity(state.cart.products)
                                  .values
                                  .elementAt(index),
                            );
                          }),
                    ),
                    const Divider(thickness: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SUBTOTAL',
                              style: Theme.of(context).textTheme.headline5),
                          Text('\$${state.cart.subtotalString}',
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('DELIVERY FEE',
                              style: Theme.of(context).textTheme.headline5),
                          Text(state.cart.deliveryFeeString,
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(50),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          width: MediaQuery.of(context).size.width - 10,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'TOTAL',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  state.cart.totalString,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Something Went Wrong",
                  style: Theme.of(context).textTheme.headline5,
                ),
              );
            }
          },
        ));
  }
}
