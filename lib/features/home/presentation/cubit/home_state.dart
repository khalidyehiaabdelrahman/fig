import 'package:fig/features/home/domain/category_model.dart';

class HomeState {
  final bool isLoading;
  final List<CategoryModel> categories;
  final String? selectedCategoryId;
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final String currentSortOption;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.categories = const [],
    this.selectedCategoryId,
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.currentSortOption = 'Recommended Sorting',
    this.errorMessage,
  });

  copyWith({
    bool? isLoading,
    List<CategoryModel>? categories,
    String? selectedCategoryId,
    List<ProductModel>? allProducts,
    List<ProductModel>? filteredProducts,
    String? currentSortOption,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      currentSortOption: currentSortOption ?? this.currentSortOption,
      errorMessage: errorMessage,
    );
  }
}
