import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/home/data/category_data.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesLoading());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(CategoriesLoaded(allCategories));
  }
}
