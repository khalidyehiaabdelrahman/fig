import 'package:fig/features/home/domain/category_model.dart';

class HomeState {
  final bool isLoadingCategories;
  final bool isLoadingProducts;
  final String? categoriesError;
  final String? productsError;
  final List<CategoryModel> categories;
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final List<ProductModel> favorites;
  final String? selectedCategoryId;
  final String? currentSortOption;
  final List<CartItem> cart; // هنا استخدمنا List<CartItem>

  const HomeState({
    this.isLoadingCategories = false,
    this.isLoadingProducts = false,
    this.categoriesError,
    this.productsError,
    this.categories = const [],
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.favorites = const [],
    this.selectedCategoryId,
    this.currentSortOption,
    this.cart = const [],
  });

  HomeState copyWith({
    bool? isLoadingCategories,
    bool? isLoadingProducts,
    String? categoriesError,
    String? productsError,
    List<CategoryModel>? categories,
    List<ProductModel>? allProducts,
    List<ProductModel>? filteredProducts,
    List<ProductModel>? favorites,
    String? selectedCategoryId,
    String? currentSortOption,
    List<CartItem>? cart,
  }) {
    return HomeState(
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      categoriesError: categoriesError ?? this.categoriesError,
      productsError: productsError ?? this.productsError,
      categories: categories ?? this.categories,
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      favorites: favorites ?? this.favorites,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      currentSortOption: currentSortOption ?? this.currentSortOption,
      cart: cart ?? this.cart,
    );
  }
}
