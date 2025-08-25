import 'package:fig/features/home/data/category_data.dart';
import 'package:fig/features/home/data/products_data.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    loadInitialData();
  }

  Future<void> fetchCategories() async {
    emit(state.copyWith(isLoadingCategories: true, categoriesError: null));
    await Future.delayed(const Duration(seconds: 2));

    try {
      emit(
        state.copyWith(isLoadingCategories: false, categories: allCategories),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingCategories: false,
          categoriesError: 'فشل تحميل الأقسام',
        ),
      );
    }
  }

  void selectCategory(String categoryId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCategoryId', categoryId);

    emit(state.copyWith(selectedCategoryId: categoryId));
    filterProductsByCategory(categoryId);
  }

  Future<void> fetchProducts() async {
    emit(state.copyWith(isLoadingProducts: true, productsError: null));
    await Future.delayed(const Duration(seconds: 2));

    try {
      List<ProductModel> products = allProducts;
      final prefs = await SharedPreferences.getInstance();
      String? savedSortOption = prefs.getString('currentSortOption');

      if (savedSortOption == 'Lowest Price') {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else if (savedSortOption == 'Highest Price') {
        products.sort((a, b) => b.price.compareTo(a.price));
      }

      emit(
        state.copyWith(
          isLoadingProducts: false,
          allProducts: allProducts,
          filteredProducts: products,
          currentSortOption: savedSortOption,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingProducts: false,
          productsError: "فشل تحميل المنتجات",
        ),
      );
    }
  }

  void filterProductsByCategory(String categoryId) {
    final filtered =
        state.allProducts.where((p) => p.categoryId == categoryId).toList();
    emit(state.copyWith(filteredProducts: filtered));
  }

  void showAllProducts() {
    emit(
      state.copyWith(
        filteredProducts: state.allProducts,
        selectedCategoryId: null,
      ),
    );
  }

  Future<void> sortProducts(String sortOption) async {
    List<ProductModel> sorted = List.from(state.allProducts);

    if (sortOption == 'Lowest Price') {
      sorted.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOption == 'Highest Price') {
      sorted.sort((a, b) => b.price.compareTo(a.price));
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentSortOption', sortOption);

    emit(
      state.copyWith(filteredProducts: sorted, currentSortOption: sortOption),
    );
  }

  Future<void> loadInitialData() async {
    final productsBox = Hive.box<ProductModel>('products');

    // كل المنتجات
    List<ProductModel> allProducts = productsBox.values.toList();

    // استرجاع الاعدادات السابقة
    final prefs = await SharedPreferences.getInstance();
    String? savedSortOption = prefs.getString('currentSortOption');
    String? savedCategoryId = prefs.getString('selectedCategoryId');

    // تصفية حسب الفئة لو موجودة
    List<ProductModel> filteredProducts =
        savedCategoryId == null
            ? List.from(allProducts)
            : allProducts
                .where((p) => p.categoryId == savedCategoryId)
                .toList();

    // ترتيب المنتجات
    if (savedSortOption == 'Lowest Price') {
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (savedSortOption == 'Highest Price') {
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    }

    // تحديث الـ state
    emit(
      state.copyWith(
        allProducts: allProducts,
        filteredProducts: filteredProducts,
        currentSortOption: savedSortOption,
        selectedCategoryId: savedCategoryId,
      ),
    );
  }
}
