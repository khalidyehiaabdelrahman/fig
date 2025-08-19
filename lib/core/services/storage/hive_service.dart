import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:hive/hive.dart';

// لازم تسجل الـ adapters قبل استخدام Hive
// دي هتعملها في main.dart
// Hive.registerAdapter(ProductModelAdapter());
// Hive.registerAdapter(CategoryModelAdapter());
// Hive.registerAdapter(CartItemAdapter());

class HiveService {
  static const String productsBoxName = 'products_box';
  static const String favoritesBoxName = 'favorites_box';
  static const String cartBoxName = 'cart_box';

  // ✅ حفظ المنتجات
  Future<void> saveProducts(List<ProductModel> products) async {
    final box = await Hive.openBox<ProductModel>(productsBoxName);
    await box.clear();
    await box.addAll(products);
  }

  // ✅ جلب المنتجات
  Future<List<ProductModel>> getProducts() async {
    final box = await Hive.openBox<ProductModel>(productsBoxName);
    return box.values.toList();
  }

  // ✅ حفظ المفضلة
  Future<void> saveFavorites(List<ProductModel> favorites) async {
    final box = await Hive.openBox<ProductModel>(favoritesBoxName);
    await box.clear();
    await box.addAll(favorites);
  }

  // ✅ جلب المفضلة
  Future<List<ProductModel>> getFavorites() async {
    final box = await Hive.openBox<ProductModel>(favoritesBoxName);
    return box.values.toList();
  }

  // ✅ حفظ السلة
  Future<void> saveCart(List<CartItem> cart) async {
    final box = await Hive.openBox<CartItem>(cartBoxName);
    await box.clear();
    await box.addAll(cart);
  }

  // ✅ جلب السلة
  Future<List<CartItem>> getCart() async {
    final box = await Hive.openBox<CartItem>(cartBoxName);
    return box.values.toList();
  }
}
