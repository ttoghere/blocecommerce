
import 'package:blocecommerce/blocs/blocs.dart';
import 'package:blocecommerce/repositories/repositories.dart';
import 'package:blocecommerce/screens/screens.dart';
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
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: _profileActions(context, state),
            );
          }
          if (state is ProfileUnauthenticated) {
            return const _Unauthenticated();
          } else {
            return const Center(
              child: Text("Something is wrong"),
            );
          }
        },
      ),
    );
  }

  Column _profileActions(BuildContext context, ProfileLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Customer Information",
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          context: context,
          label: "Email",
          initialValue: state.user.email,
          onChanged: (value) {
            context
                .read<ProfileBloc>()
                .add(UpdateProfile(state.user.copyWith(email: value)));
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          context: context,
          label: "Full Name",
          initialValue: state.user.fullName,
          onChanged: (value) {
            context
                .read<ProfileBloc>()
                .add(UpdateProfile(state.user.copyWith(fullName: value)));
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          context: context,
          label: "Address",
          initialValue: state.user.address,
          onChanged: (value) {
            context
                .read<ProfileBloc>()
                .add(UpdateProfile(state.user.copyWith(address: value)));
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          context: context,
          label: "City",
          initialValue: state.user.city,
          onChanged: (value) {
            context
                .read<ProfileBloc>()
                .add(UpdateProfile(state.user.copyWith(city: value)));
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          context: context,
          label: "Country",
          initialValue: state.user.country,
          onChanged: (value) {
            context
                .read<ProfileBloc>()
                .add(UpdateProfile(state.user.copyWith(country: value)));
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          context: context,
          label: "Zip Code",
          initialValue: state.user.zipCode,
          onChanged: (value) {
            context
                .read<ProfileBloc>()
                .add(UpdateProfile(state.user.copyWith(zipCode: value)));
          },
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthRepository>().signOut();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              shape: const RoundedRectangleBorder(),
              fixedSize: const Size(200, 40),
            ),
            child: const Text("Sign Out"),
          ),
        ),
      ],
    );
  }
}

class _Unauthenticated extends StatelessWidget {
  const _Unauthenticated({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
