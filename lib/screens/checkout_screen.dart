// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blocecommerce/blocs/blocs.dart';
import 'package:blocecommerce/models/models.dart';
import 'package:blocecommerce/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocecommerce/widgets/widgets.dart';

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
              var user = state.user ?? User.empty;
              return _checkoutForm(context, state, user);
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }

  SingleChildScrollView _checkoutForm(
      BuildContext context, CheckoutLoaded state, User user) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CUSTOMER INFORMATION',
            style: Theme.of(context).textTheme.headline3,
          ),
          CustomTextFormField(
              onChanged: (value) {
                context.read<CheckoutBloc>().add(UpdateCheckout(
                    user: state.checkout.user!.copyWith(email: value)));
              },
              initialValue: user.email,
              context: context,
              label: 'Email'),
          CustomTextFormField(
              onChanged: (value) {
                context.read<CheckoutBloc>().add(UpdateCheckout(
                    user: state.checkout.user!.copyWith(fullName: value)));
              },
              initialValue: user.fullName,
              context: context,
              label: 'Full Name'),
          const SizedBox(height: 20),
          Text(
            'DELIVERY INFORMATION',
            style: Theme.of(context).textTheme.headline3,
          ),
          CustomTextFormField(
              onChanged: (value) {
                context.read<CheckoutBloc>().add(UpdateCheckout(
                    user: state.checkout.user!.copyWith(address: value)));
              },
              context: context,
              initialValue: user.address,
              label: 'Address'),
          CustomTextFormField(
              onChanged: (value) {
                context.read<CheckoutBloc>().add(UpdateCheckout(
                    user: state.checkout.user!.copyWith(city: value)));
              },
              context: context,
              initialValue: user.city,
              label: 'City'),
          CustomTextFormField(
              onChanged: (value) {
                context.read<CheckoutBloc>().add(UpdateCheckout(
                    user: state.checkout.user!.copyWith(country: value)));
              },
              context: context,
              initialValue: user.country,
              label: 'Country'),
          CustomTextFormField(
              onChanged: (value) {
                context.read<CheckoutBloc>().add(UpdateCheckout(
                    user: state.checkout.user!.copyWith(zipCode: value)));
              },
              context: context,
              initialValue: user.zipCode,
              label: 'ZIP Code'),
          const SizedBox(height: 20),
          Text(
            'ORDER SUMMARY',
            style: Theme.of(context).textTheme.headline3,
          ),
          const OrderSummary()
        ],
      ),
    );
  }
}
