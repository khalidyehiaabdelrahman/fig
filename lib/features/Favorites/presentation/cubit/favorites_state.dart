import 'package:fig/features/home/domain/model/category_model.dart';

abstract class FavoritesState {
  final List<ProductModel> favorites;

  const FavoritesState({this.favorites = const []});
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial() : super(favorites: const []);
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({required List<ProductModel> favorites})
    : super(favorites: favorites);
}
