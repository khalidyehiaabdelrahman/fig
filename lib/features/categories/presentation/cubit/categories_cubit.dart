import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/core/repositories/category_repository.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoryRepository _repository;

  CategoriesCubit(this._repository) : super(CategoriesLoading());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    final categories = await _repository.getCategories();
    emit(CategoriesLoaded(categories));
  }
}
