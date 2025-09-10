import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/product/data/products_data.dart' as data;
import 'package:fig/features/product/presentation/cubit/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoading());
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

    final box = await Hive.openBox<ProductModel>('products');
    if (box.isEmpty) {
      
      for (var p in data.allProducts) {
        box.add(p);
      }
    }

    
    allProducts = box.values.toList();
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

    
    final box = await Hive.openBox<ProductModel>('products');
    List<ProductModel> allProductsFromBox = box.values.toList();

    
    if (sortOption == 'Lowest Price') {
      allProductsFromBox.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOption == 'Highest Price') {
      allProductsFromBox.sort((a, b) => b.price.compareTo(a.price));
    }

    
    await box.clear();
    for (var p in allProductsFromBox) {
      box.add(p);
    }

    
    allProducts = allProductsFromBox;

    
    displayedProducts.clear();
    currentPage = 1;
    hasMore = true;

    await loadMoreProducts();
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
