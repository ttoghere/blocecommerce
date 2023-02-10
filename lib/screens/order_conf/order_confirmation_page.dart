import 'package:blocecommerce/models/product_model.dart';
import 'package:blocecommerce/widgets/order_sum_product_car.dart';
import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order';

  const OrderConfirmation({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OrderConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Order Confirmation",
      ),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                  left: 150,
                  top: 150,
                  child: SvgPicture.asset("assets/svgs/garlands.svg"),
                ),
                Positioned(
                  top: 250,
                  left: 90,
                  child: Text(
                    "Your Order is Completed!!",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Order Code: #123-123123",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Thank you for your purchasing",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Order Code: #123-123123",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const OrderSummary(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Order Details",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      OrderSummaryProductCard(
                        product: Product.products[0],
                        quantity: 5,
                      ),
                      OrderSummaryProductCard(
                        product: Product.products[0],
                        quantity: 5,
                      ),
                      OrderSummaryProductCard(
                        product: Product.products[0],
                        quantity: 5,
                      ),
                      OrderSummaryProductCard(
                        product: Product.products[0],
                        quantity: 5,
                      ),
                    ],
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
