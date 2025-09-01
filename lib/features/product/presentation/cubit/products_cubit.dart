import 'package:fig/features/home/data/products_data.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/product/presentation/cubit/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoading());
  String? currentSortOption;

  Future<void> initProducts() async {
    await fetchProducts();
    loadSortOption();
  }

  Future<void> fetchProducts() async {
    emit(ProductsLoading());
    await Future.delayed(const Duration(seconds: 1));

    final box = await Hive.openBox<ProductModel>('products');
    if (box.isEmpty) {
      for (var p in allProducts) {
        box.add(p);
      }
    }

    emit(ProductsLoaded(box.values.toList()));
  }

  void filterProductsByCategory(String categoryId) async {
    final box = await Hive.openBox<ProductModel>('products');
    final filtered =
        box.values.where((p) => p.categoryId == categoryId).toList();
    emit(ProductsFiltered(filtered));
  }

  void showAllProducts() async {
    final box = await Hive.openBox<ProductModel>('products');
    emit(ProductsLoaded(box.values.toList()));
  }

  Future<void> sortProducts(String sortOption) async {
    currentSortOption = sortOption;

    if (state is ProductsLoaded) {
      final products = List<ProductModel>.from(
        (state as ProductsLoaded).products,
      );

      if (sortOption == 'Lowest Price') {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortOption == 'Highest Price') {
        products.sort((a, b) => b.price.compareTo(a.price));
      }

      emit(ProductsLoaded(products));
    } else if (state is ProductsFiltered) {
      final products = List<ProductModel>.from(
        (state as ProductsFiltered).filteredProducts,
      );

      if (sortOption == 'Lowest Price') {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortOption == 'Highest Price') {
        products.sort((a, b) => b.price.compareTo(a.price));
      }

      emit(ProductsFiltered(products));
    }
  }

  Future<void> loadSortOption() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOption = prefs.getString('currentSortOption');

    if (savedOption != null) {
      currentSortOption = savedOption;
      await sortProducts(savedOption);
    }
  }

  Future<void> changeSortOption(String option) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentSortOption', option);

    await sortProducts(option);
  }
}
