import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/core/repositories/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _repository;

  FavoritesCubit(this._repository) : super(const FavoritesInitial()) {
    _loadFavorites();
  }

  void _loadFavorites() async {
    final favorites = await _repository.getFavorites();
    emit(FavoritesLoaded(favorites: favorites));
  }

  void toggleFavorite(ProductModel product) async {
    final exists = await _repository.isFavorite(product.id);

    if (exists) {
      await _repository.removeFromFavorites(product.id);
    } else {
      await _repository.addToFavorites(product);
    }

    final updatedFavorites = await _repository.getFavorites();
    emit(FavoritesLoaded(favorites: updatedFavorites));
  }

  bool isFavorite(ProductModel product) {
    return state.favorites.any((p) => p.id == product.id);
  }
}
