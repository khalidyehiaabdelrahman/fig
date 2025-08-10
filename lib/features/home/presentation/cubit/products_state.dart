import 'package:fig/features/home/domain/category_model.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;

  ProductsLoaded({required this.allProducts, required this.filteredProducts});
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
}
