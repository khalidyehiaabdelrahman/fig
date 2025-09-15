import 'package:get_it/get_it.dart';
import 'package:fig/core/services/storage/hive_service.dart';
import 'package:fig/core/services/preferences_service.dart';
import 'package:fig/core/repositories/product_repository.dart';
import 'package:fig/core/repositories/category_repository.dart';
import 'package:fig/core/repositories/cart_repository.dart';
import 'package:fig/core/repositories/favorites_repository.dart';
import 'package:fig/core/repositories/auth_repository.dart';
import 'package:fig/features/product/data/repositories/product_repository_impl.dart';
import 'package:fig/features/categories/data/repositories/category_repository_impl.dart';
import 'package:fig/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:fig/features/Favorites/data/repositories/favorites_repository_impl.dart';
import 'package:fig/features/profile/data/repositories/auth_repository_impl.dart';
import 'package:fig/features/product/presentation/cubit/products_cubit.dart';
import 'package:fig/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fig/features/Favorites/presentation/cubit/favorites_cubit.dart';
import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fig/features/main/presentation/cubit/main_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  
  getIt.registerLazySingleton<HiveService>(() => HiveService());
  getIt.registerLazySingleton<PreferencesService>(() => PreferencesService());

  
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(),
  );

  getIt.registerLazySingleton<CartRepository>(() => CartRepositoryImpl());

  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(),
  );

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  
  getIt.registerFactory<ProductsCubit>(
    () => ProductsCubit(getIt<ProductRepository>()),
  );

  getIt.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(getIt<CategoryRepository>()),
  );

  getIt.registerFactory<CartCubit>(() => CartCubit(getIt<CartRepository>()));

  getIt.registerFactory<FavoritesCubit>(
    () => FavoritesCubit(getIt<FavoritesRepository>()),
  );

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<PreferencesService>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt<AuthRepository>()),
  );
  getIt.registerFactory<MainCubit>(() => MainCubit());
}
