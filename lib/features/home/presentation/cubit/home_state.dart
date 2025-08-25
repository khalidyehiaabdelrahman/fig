import 'package:fig/features/home/domain/model/category_model.dart';

class HomeState {
  final bool isLoadingCategories;
  final bool isLoadingProducts;
  final String? categoriesError;
  final String? productsError;
  final List<CategoryModel> categories;
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final String? selectedCategoryId;
  final String? currentSortOption;

  const HomeState({
    this.isLoadingCategories = false,
    this.isLoadingProducts = false,
    this.categoriesError,
    this.productsError,
    this.categories = const [],
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.selectedCategoryId,
    this.currentSortOption,
  });

  HomeState copyWith({
    bool? isLoadingCategories,
    bool? isLoadingProducts,
    String? categoriesError,
    String? productsError,
    List<CategoryModel>? categories,
    List<ProductModel>? allProducts,
    List<ProductModel>? filteredProducts,
    String? selectedCategoryId,
    String? currentSortOption,
  }) {
    return HomeState(
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      categoriesError: categoriesError ?? this.categoriesError,
      productsError: productsError ?? this.productsError,
      categories: categories ?? this.categories,
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      currentSortOption: currentSortOption ?? this.currentSortOption,
    );
  }
}
