// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blocecommerce/cubits/signup/signup_cubit.dart';
import 'package:flutter/material.dart';

import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';

  const SignupScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SignupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "SignUp",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _UserInput(
                  labelText: "Email",
                  onChanged: (value) {
                    context
                        .read<SignupCubit>()
                        .userChanged(state.user!.copyWith(email: value));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _UserInput(
                  labelText: "Full Name",
                  onChanged: (value) {
                    context
                        .read<SignupCubit>()
                        .userChanged(state.user!.copyWith(fullName: value));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _UserInput(
                  labelText: "Country",
                  onChanged: (value) {
                    context
                        .read<SignupCubit>()
                        .userChanged(state.user!.copyWith(country: value));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _UserInput(
                  labelText: "City",
                  onChanged: (value) {
                    context
                        .read<SignupCubit>()
                        .userChanged(state.user!.copyWith(city: value));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _UserInput(
                  labelText: "Address",
                  onChanged: (value) {
                    context
                        .read<SignupCubit>()
                        .userChanged(state.user!.copyWith(address: value));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _UserInput(
                  labelText: "Zip Code",
                  onChanged: (value) {
                    context
                        .read<SignupCubit>()
                        .userChanged(state.user!.copyWith(zipCode: value));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _PasswordInput(),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignupCubit>().signUpWithCredentials();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: const RoundedRectangleBorder(),
                    fixedSize: const Size(200, 40),
                  ),
                  child: Text(
                    "SignUp",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _UserInput extends StatelessWidget {
  final Function(String)? onChanged;
  final String labelText;
  const _UserInput({
    Key? key,
    this.onChanged,
    required this.labelText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: "Password"),
        );
      },
    );
  }
}
