import 'package:fig/core/repositories/product_repository.dart';
import 'package:fig/core/services/storage/hive_service.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/product/data/products_data.dart' as data;
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepositoryImpl implements ProductRepository {
  final HiveService _hiveService;

  ProductRepositoryImpl(this._hiveService);

  @override
  Future<List<ProductModel>> getProducts() async {
    final box = await Hive.openBox<ProductModel>('products');
    if (box.isEmpty) {
      for (var p in data.allProducts) {
        box.add(p);
      }
    }
    return box.values.toList();
  }

  @override
  Future<void> saveProducts(List<ProductModel> products) async {
    await _hiveService.saveProducts(products);
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    final box = await Hive.openBox<ProductModel>('products');
    return box.values.where((p) => p.categoryId == categoryId).toList();
  }

  @override
  Future<void> sortProducts(String sortOption) async {
    final box = await Hive.openBox<ProductModel>('products');
    List<ProductModel> allProductsFromBox = box.values.toList();

    if (sortOption == 'Lowest Price') {
      allProductsFromBox.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOption == 'Highest Price') {
      allProductsFromBox.sort((a, b) => b.price.compareTo(a.price));
    }

    await box.clear();
    for (var p in allProductsFromBox) {
      box.add(p);
    }
  }

  @override
  Future<String?> getSortOption() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentSortOption');
  }

  @override
  Future<void> saveSortOption(String option) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentSortOption', option);
  }
}
