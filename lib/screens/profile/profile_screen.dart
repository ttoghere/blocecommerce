import 'package:blocecommerce/blocs/auth/auth_bloc.dart';
import 'package:blocecommerce/blocs/profile/profile_bloc.dart';
import 'package:blocecommerce/repositories/auth/auth_repository.dart';
import 'package:blocecommerce/repositories/user/user_repository.dart';
import 'package:blocecommerce/screens/auth/login_screen.dart';
import 'package:blocecommerce/screens/auth/signup_screen.dart';
import 'package:blocecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (context) => ProfileBloc(
            authBloc: context.read<AuthBloc>(),
            userRepository: context.read<UserRepository>())
          ..add(
            LoadProfile(context.read<AuthBloc>().state.authUser),
          ),
        child: const ProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Profile",
      ),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthRepository>().signOut();
                },
                child: const Text("Sign Out"),
              ),
            );
          }
          if (state is ProfileUnauthenticated) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "You are not logged in",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: const RoundedRectangleBorder(),
                    fixedSize: const Size(200, 40),
                  ),
                  child: Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignupScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: const RoundedRectangleBorder(),
                    fixedSize: const Size(200, 40),
                  ),
                  child: Text(
                    "SignUp",
                    style: Theme.of(context).textTheme.headline4!,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Something is wrong"),
            );
          }
        },
      ),
    );
  }
}
