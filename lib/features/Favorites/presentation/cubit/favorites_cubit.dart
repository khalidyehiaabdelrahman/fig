import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  late final Box<ProductModel> favoritesBox;

  FavoritesCubit() : super(const FavoritesState()) {
    favoritesBox = Hive.box<ProductModel>('favorites');
    emit(FavoritesState(favorites: favoritesBox.values.toList()));
  }

  void toggleFavorite(ProductModel product) {
    final exists = state.favorites.any((p) => p.id == product.id);

    if (exists) {
      final key = favoritesBox.keys.firstWhere(
        (k) => favoritesBox.get(k)!.id == product.id,
      );
      favoritesBox.delete(key);
    } else {
      favoritesBox.add(product);
    }

    emit(state.copyWith(favorites: favoritesBox.values.toList()));
  }

  bool isFavorite(ProductModel product) {
    return favoritesBox.values.any((p) => p.id == product.id);
  }
}
