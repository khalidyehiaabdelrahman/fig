import 'package:fig/features/home/domain/model/category_model.dart';

abstract class FavoritesRepository {
  Future<List<ProductModel>> getFavorites();
  Future<void> addToFavorites(ProductModel product);
  Future<void> removeFromFavorites(String productId);
  Future<bool> isFavorite(String productId);
}
