import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/product/presentation/cubit/products_state.dart';
import 'package:fig/core/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository _repository;

  ProductsCubit(this._repository) : super(ProductsLoading());
  String? currentSortOption;

  List<ProductModel> allProducts = [];
  List<ProductModel> displayedProducts = [];
  int currentPage = 1;
  final int itemsPerPage = 10;
  bool hasMore = true;
  bool isLoading = false;

  Future<void> initProducts() async {
    await fetchProducts();
    loadSortOption();
  }

  Future<void> fetchProducts() async {
    emit(ProductsLoading());
    await Future.delayed(const Duration(seconds: 2));

    allProducts = await _repository.getProducts();
    displayedProducts.clear();
    currentPage = 1;
    hasMore = true;

    await loadMoreProducts();
  }

  Future<void> loadMoreProducts() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    emit(ProductsLoadingMore(displayedProducts));

    await Future.delayed(const Duration(milliseconds: 500));

    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    if (startIndex >= allProducts.length) {
      hasMore = false;
      isLoading = false;
      emit(
        ProductsPaginationLoaded(
          products: displayedProducts,
          hasMore: false,
          isLoading: false,
          message: 'No more products',
        ),
      );
      return;
    }

    final newProducts = allProducts.sublist(
      startIndex,
      endIndex > allProducts.length ? allProducts.length : endIndex,
    );

    displayedProducts.addAll(newProducts);
    currentPage++;

    isLoading = false;
    emit(
      ProductsPaginationLoaded(
        products: displayedProducts,
        hasMore: hasMore,
        isLoading: false,
      ),
    );
  }

  void filterProductsByCategory(String categoryId) async {
    final filtered = await _repository.getProductsByCategory(categoryId);
    emit(ProductsFiltered(filtered));
  }

  void showAllProducts() async {
    final products = await _repository.getProducts();
    emit(ProductsLoaded(products));
  }

  Future<void> sortProducts(String sortOption) async {
    currentSortOption = sortOption;

    await _repository.sortProducts(sortOption);
    allProducts = await _repository.getProducts();

    displayedProducts.clear();
    currentPage = 1;
    hasMore = true;

    await loadMoreProducts();
  }

  Future<void> loadSortOption() async {
    final savedOption = await _repository.getSortOption();

    if (savedOption != null) {
      currentSortOption = savedOption;
      await sortProducts(savedOption);
    }
  }

  Future<void> changeSortOption(String option) async {
    await _repository.saveSortOption(option);
    await sortProducts(option);
  }

  void resetMessage() {
    if (state is ProductsPaginationLoaded) {
      final currentState = state as ProductsPaginationLoaded;
      emit(
        ProductsPaginationLoaded(
          products: currentState.products,
          hasMore: currentState.hasMore,
          isLoading: currentState.isLoading,
          message: null,
        ),
      );
    }
  }
}
