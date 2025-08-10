import 'package:fig/features/home/domain/category_model.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryModel> categories;
  final String? selectedCategoryId;

  CategoriesLoaded({required this.categories, this.selectedCategoryId});
}

class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError(this.message);
}
