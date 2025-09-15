import 'package:fig/features/home/domain/model/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();
}
