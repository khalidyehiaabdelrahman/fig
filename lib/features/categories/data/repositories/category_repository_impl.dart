import 'package:fig/core/repositories/category_repository.dart';
import 'package:fig/features/home/data/category_data.dart';
import 'package:fig/features/home/domain/model/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    return allCategories;
  }
}
