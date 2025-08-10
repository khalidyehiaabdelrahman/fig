import 'package:fig/features/home/domain/category_model.dart';
import 'package:fig/features/home/presentation/cubit/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  // Simulate fetch
  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    await Future.delayed(Duration(seconds: 2)); // simulate loading

    try {
      final categories = [
        CategoryModel(
          id: '1',
          name: 'Blazers',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '2',
          name: 'Shirts',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '3',
          name: 'Pants',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '4',
          name: 'Blazers',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '5',
          name: 'Shirts',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '6',
          name: 'Pants',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '7',
          name: 'Blazers',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '8',
          name: 'Shirts',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '9',
          name: 'Pants',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
      ];
      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      emit(CategoriesError('فشل تحميل الأقسام'));
    }
  }

  void selectCategory(String categoryId) {
    if (state is CategoriesLoaded) {
      final current = state as CategoriesLoaded;
      emit(
        CategoriesLoaded(
          categories: current.categories,
          selectedCategoryId: categoryId,
        ),
      );
    }
  }
}
