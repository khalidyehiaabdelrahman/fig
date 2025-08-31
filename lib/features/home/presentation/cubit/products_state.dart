import 'package:fig/features/home/domain/model/category_model.dart';

abstract class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  ProductsLoaded(this.products);
}

class ProductsFiltered extends ProductsState {
  final List<ProductModel> filteredProducts;
  ProductsFiltered(this.filteredProducts);
}

class ProductsError extends ProductsState {
  final String error;
  ProductsError(this.error);
}

class SortOptionChanged extends ProductsState {
  final String sortOption;
  SortOptionChanged(this.sortOption);
}
