import 'package:blocecommerce/blocs/auth/auth_bloc.dart';
import 'package:blocecommerce/blocs/blocs.dart';
import 'package:blocecommerce/blocs/search/search_bloc.dart';
import 'package:blocecommerce/config/configs.dart';
import 'package:blocecommerce/cubits/login/login_cubit.dart';
import 'package:blocecommerce/cubits/signup/signup_cubit.dart';
import 'package:blocecommerce/firebase_options.dart';
import 'package:blocecommerce/models/product_model.dart';
import 'package:blocecommerce/repositories/auth/auth_repository.dart';
import 'package:blocecommerce/repositories/category/category_repository.dart';
import 'package:blocecommerce/repositories/checkout/checkout_repository.dart';
import 'package:blocecommerce/repositories/local_storage/local_storage_repository.dart';
import 'package:blocecommerce/repositories/product/product_repository.dart';
import 'package:blocecommerce/repositories/user/user_repository.dart';
import 'package:blocecommerce/screens/login_screen.dart';
import 'package:blocecommerce/screens/signup_screen.dart';
import 'package:blocecommerce/screens/home_screen.dart';
import 'package:blocecommerce/screens/profile_screen.dart';
import 'package:blocecommerce/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => CartBloc()
              ..add(
                LoadCart(),
              ),
          ),
          BlocProvider(
            create: (_) => PaymentBloc()
              ..add(
                LoadPaymentMethod(),
              ),
          ),
          BlocProvider(
            create: (context) => CheckoutBloc(
              authBloc: context.read<AuthBloc>(),
              paymentBloc: context.read<PaymentBloc>(),
              cartBloc: context.read<CartBloc>(),
              checkoutRepository: CheckoutRepository(),
            ),
          ),
          BlocProvider(
            create: (_) => CategoryBloc(
              categoryRepository: CategoryRepository(),
            )..add(
                LoadCategories(),
              ),
          ),
          BlocProvider(
            create: (_) => ProductBloc(
              productRepository: ProductRepository(),
            )..add(
                LoadProducts(),
              ),
          ),
          BlocProvider(
            create: (context) => SearchBloc(
              productBloc: context.read<ProductBloc>(),
            )..add(LoadSearch()),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => WishlistBloc(
              localStorageRepository: LocalStorageRepository(),
            )..add(
                StartWishlist(),
              ),
          ),
        ],
        child: MaterialApp(
          title: 'Zero To Unicorn',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: ProfileScreen.routeName,
        ),
      ),
    );
  }
}
