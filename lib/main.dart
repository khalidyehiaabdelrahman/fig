import 'package:fig/features/Favorites/presentation/cubit/favorites_cubit.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fig/features/home/domain/model/category_model_adapter.dart';
import 'package:fig/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:fig/features/product/presentation/cubit/products_cubit.dart';
import 'package:fig/features/main/presentation/cubit/main_cubit.dart';
import 'package:fig/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.deleteFromDisk();
  await initHive();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const FigApp(),
    ),
  );
}

class FigApp extends StatelessWidget {
  const FigApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => CategoriesCubit()..fetchCategories()),
        BlocProvider(create: (_) => ProductsCubit()..initProducts()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => FavoritesCubit()),
        BlocProvider(create: (_) => HomeCubit()..initHome()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'FIG App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.grey, useMaterial3: true),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
