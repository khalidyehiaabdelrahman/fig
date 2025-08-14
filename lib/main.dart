import 'package:fig/features/home/domain/model/category_model_adapter.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/profile/presentation/cubit/auth_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fig/features/Navigation/presentation/pages/main_screen.dart';
import 'package:fig/features/Navigation/presentation/pages/navigation_cubit.dart';
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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(
          create:
              (_) =>
                  HomeCubit()
                    ..fetchCategories()
                    ..fetchProducts(),
        ),
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
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
