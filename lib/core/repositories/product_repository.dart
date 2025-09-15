import 'package:fig/features/home/domain/model/category_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<void> saveProducts(List<ProductModel> products);
  Future<List<ProductModel>> getProductsByCategory(String categoryId);
  Future<void> sortProducts(String sortOption);
  Future<String?> getSortOption();
  Future<void> saveSortOption(String option);
}
