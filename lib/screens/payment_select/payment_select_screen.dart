import 'dart:developer';
import 'dart:io';

import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
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
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          if (Platform.isIOS)
            RawApplePayButton(
              style: ApplePayButtonStyle.black,
              type: ApplePayButtonType.inStore,
              onPressed: () {
                log("Apple Pay Selected");
              },
            ),
          SizedBox(
            height: 20,
          ),
          if (Platform.isAndroid)
            RawGooglePayButton(
              type: GooglePayButtonType.pay,
              onPressed: () {
                log("Google Pay Selected");
              },
            )
        ],
      ),
    );
  }
}
