import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final List<ProductModel> favorites;

  const FavoritesState({this.favorites = const []});

  FavoritesState copyWith({List<ProductModel>? favorites}) {
    return FavoritesState(favorites: favorites ?? this.favorites);
  }

  @override
  List<Object?> get props => [favorites];
}
