// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import 'package:blocecommerce/models/product_model.dart';

class ApplePay extends StatelessWidget {
  final String total;
  final List<Product> products;
  ApplePay({
    Key? key,
    required this.total,
    required this.products,
  }) : super(key: key);
  void onApplePayResult(paymentResult) {
    log(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentItem> _paymentItems = products
        .map((Product product) => PaymentItem(
            amount: product.price.toString(),
            type: PaymentItemType.item,
            status: PaymentItemStatus.final_price,
            label: product.name))
        .toList();
    _paymentItems.add(
      PaymentItem(
          amount: total,
          label: "Total",
          type: PaymentItemType.total,
          status: PaymentItemStatus.final_price),
    );
    return SizedBox(
      width: 350,
      child: ApplePayButton(
        paymentConfigurationAsset: "payment_profile_apple_pay.json",
        onPaymentResult: onApplePayResult,
        paymentItems: _paymentItems,
        style: ApplePayButtonStyle.white,
        type: ApplePayButtonType.inStore,
        margin: EdgeInsets.only(top: 10),
        loadingIndicator: CircularProgressIndicator(),
      ),
    );
  }
}
