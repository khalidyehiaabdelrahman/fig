import 'package:fig/features/home/data/category_model.dart';
import 'package:fig/features/home/data/products_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/home/domain/category_model.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:uuid/uuid.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

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

  void selectCategory(String categoryId) {
    emit(state.copyWith(selectedCategoryId: categoryId));
    filterProductsByCategory(categoryId);
  }

  Future<void> fetchProducts() async {
    emit(state.copyWith(isLoadingProducts: true, productsError: null));
    await Future.delayed(const Duration(seconds: 2));

    try {
      emit(
        state.copyWith(
          isLoadingProducts: false,
          allProducts: allProducts,
          filteredProducts: allProducts,
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

  void sortProducts(String sortOption) {
    print('sorting with option: $sortOption');

    List<ProductModel> sorted = List.from(state.filteredProducts);
    print('قبل الترتيب: ${sorted.map((e) => e.price).toList()}');

    if (sortOption == 'Lowest Price') {
      sorted.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOption == 'Highest Price') {
      sorted.sort((a, b) => b.price.compareTo(a.price));
    } else {
      sorted = List.from(state.filteredProducts);
    }

    print('بعد الترتيب: ${sorted.map((e) => e.price).toList()}');

    emit(
      state.copyWith(filteredProducts: sorted, currentSortOption: sortOption),
    );
  }

  void toggleFavorite(ProductModel product) {
    final currentFavorites = List<ProductModel>.from(state.favorites);
    final exists = currentFavorites.any((p) => p.id == product.id);

    if (exists) {
      currentFavorites.removeWhere((p) => p.id == product.id);
    } else {
      currentFavorites.add(product);
    }

    emit(state.copyWith(favorites: currentFavorites));
  }

  bool isFavorite(ProductModel product) {
    return state.favorites.any((p) => p.id == product.id);
  }

  void addToCart(ProductModel product) {
    final currentCart = List<CartItem>.from(state.cart);
    final newItem = CartItem(
      id: Uuid().v4(), // معرف فريد لكل عنصر
      product: product,
      quantity: 1,
    );
    currentCart.add(newItem);
    emit(state.copyWith(cart: currentCart));
  }

  void removeFromCartById(String cartItemId) {
    final currentCart = List<CartItem>.from(state.cart);
    currentCart.removeWhere((item) => item.id == cartItemId);
    emit(state.copyWith(cart: currentCart));
  }

  void updateCartQuantity(String cartItemId, int quantity) {
    final currentCart =
        state.cart.map((item) {
          if (item.id == cartItemId) {
            return item.copyWith(quantity: quantity);
          }
          return item;
        }).toList();

    emit(state.copyWith(cart: currentCart));
  }
}
