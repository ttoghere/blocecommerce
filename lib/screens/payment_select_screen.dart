import 'dart:developer';
import 'dart:io';

import 'package:blocecommerce/blocs/blocs.dart';
import 'package:blocecommerce/models/payment_method_model.dart';
import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

class PaymentSelectScreen extends StatelessWidget {
  static const String routeName = '/paymentselect';

  const PaymentSelectScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const PaymentSelectScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Payment Selection",
      ),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PaymentLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Platform.isIOS
                    ? RawApplePayButton(
                        style: ApplePayButtonStyle.black,
                        type: ApplePayButtonType.inStore,
                        onPressed: () {
                          context.read<PaymentBloc>().add(
                              const SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.applePay));
                          Navigator.of(context).pop();
                        },
                      )
                    : const SizedBox(
                        height: 20,
                      ),

                //Android Entegrasyonu ile düzenlenecektir
                Platform.isAndroid
                    ? RawGooglePayButton(
                        type: GooglePayButtonType.pay,
                        onPressed: () {
                          log("Google Pay Selected");
                        },
                      )
                    : const SizedBox(
                        height: 20,
                      ),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(SelectPaymentMethod(
                        paymentMethod: PaymentMethod.creditCard));
                    Navigator.of(context).pop();
                  },
                  child: const Text("Stripe"),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("There is not any payment methods"),
            );
          }
        },
      ),
    );
  }
}
