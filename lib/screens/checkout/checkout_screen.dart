import 'package:blocecommerce/blocs/checkout/checkout_bloc.dart';
import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeName = '/checkout';

  const CheckoutScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CheckoutScreen(),
    );
  }

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: const CustomNavBar(
        screen: CheckoutScreen.routeName,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CUSTOMER INFORMATION',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    _buildTextFormField(
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(email: value));
                        },
                        context: context,
                        label: 'Email'),
                    _buildTextFormField(
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(fullName: value));
                        },
                        context: context,
                        label: 'Full Name'),
                    const SizedBox(height: 20),
                    Text(
                      'DELIVERY INFORMATION',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    _buildTextFormField(
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(address: value));
                        },
                        context: context,
                        label: 'Address'),
                    _buildTextFormField(
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(city: value));
                        },
                        context: context,
                        label: 'City'),
                    _buildTextFormField(
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(country: value));
                        },
                        context: context,
                        label: 'Country'),
                    _buildTextFormField(
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(zipCode: value));
                        },
                        context: context,
                        label: 'ZIP Code'),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Text(
                              'SELECT A PAYMENT METHOD',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'ORDER SUMMARY',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const OrderSummary()
                  ],
                ),
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required BuildContext context,
    required String label,
    required Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              decoration: InputDecoration(
                labelText: label,
                isDense: true,
                contentPadding: const EdgeInsets.only(left: 10, bottom: 5),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
