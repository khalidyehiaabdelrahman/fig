import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:hive/hive.dart';







class HiveService {
  static const String productsBoxName = 'products_box';
  static const String favoritesBoxName = 'favorites_box';
  static const String cartBoxName = 'cart_box';

  
  Future<void> saveProducts(List<ProductModel> products) async {
    final box = await Hive.openBox<ProductModel>(productsBoxName);
    await box.clear();
    await box.addAll(products);
  }

  
  Future<List<ProductModel>> getProducts() async {
    final box = await Hive.openBox<ProductModel>(productsBoxName);
    return box.values.toList();
  }

  
  Future<void> saveFavorites(List<ProductModel> favorites) async {
    final box = await Hive.openBox<ProductModel>(favoritesBoxName);
    await box.clear();
    await box.addAll(favorites);
  }

  
  Future<List<ProductModel>> getFavorites() async {
    final box = await Hive.openBox<ProductModel>(favoritesBoxName);
    return box.values.toList();
  }

  
  Future<void> saveCart(List<CartItem> cart) async {
    final box = await Hive.openBox<CartItem>(cartBoxName);
    await box.clear();
    await box.addAll(cart);
  }

  
  Future<List<CartItem>> getCart() async {
    final box = await Hive.openBox<CartItem>(cartBoxName);
    return box.values.toList();
  }
}
