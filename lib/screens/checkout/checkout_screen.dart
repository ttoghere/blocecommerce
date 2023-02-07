import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: const CustomNavBar(
        screen: CheckoutScreen.routeName,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Customer Information",
              style: Theme.of(context).textTheme.headline3,
            ),
            _buildTextFormField(
              controller: emailController,
              label: "Email",
              context: context,
            ),
            _buildTextFormField(
              controller: nameController,
              label: "Full Name",
              context: context,
            ),
            Text(
              "Delivery Information",
              style: Theme.of(context).textTheme.headline3,
            ),
            _buildTextFormField(
              controller: addressController,
              label: "Address",
              context: context,
            ),
            _buildTextFormField(
              controller: cityController,
              label: "City",
              context: context,
            ),
            _buildTextFormField(
              controller: countryController,
              label: "Country",
              context: context,
            ),
            _buildTextFormField(
              controller: zipCodeController,
              label: "Zip Code",
              context: context,
            ),
            Text(
              "Order Summary",
              style: Theme.of(context).textTheme.headline3,
            ),
            const OrderSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      {required TextEditingController controller,
      required BuildContext context,
      required String label}) {
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
              controller: controller,
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
