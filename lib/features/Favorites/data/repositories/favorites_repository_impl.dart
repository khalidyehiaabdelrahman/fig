import 'package:fig/core/repositories/favorites_repository.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:hive/hive.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  late final Box<ProductModel> _favoritesBox;

  FavoritesRepositoryImpl() {
    _favoritesBox = Hive.box<ProductModel>('favorites');
  }

  @override
  Future<List<ProductModel>> getFavorites() async {
    return _favoritesBox.values.toList();
  }

  @override
  Future<void> addToFavorites(ProductModel product) async {
    await _favoritesBox.add(product);
  }

  @override
  Future<void> removeFromFavorites(String productId) async {
    final key = _favoritesBox.keys.firstWhere(
      (k) => _favoritesBox.get(k)!.id == productId,
    );
    await _favoritesBox.delete(key);
  }

  @override
  Future<bool> isFavorite(String productId) async {
    return _favoritesBox.values.any((p) => p.id == productId);
  }
}
