import 'package:fig/core/repositories/cart_repository.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:hive/hive.dart';

class CartRepositoryImpl implements CartRepository {
  late final Box<CartItem> _cartBox;

  CartRepositoryImpl() {
    _cartBox = Hive.box<CartItem>('cart');
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    return _cartBox.values.toList();
  }

  @override
  Future<void> addToCart(CartItem item) async {
    await _cartBox.add(item);
  }

  @override
  Future<void> removeFromCart(String id) async {
    final key = _cartBox.keys.firstWhere((k) => _cartBox.get(k)!.id == id);
    await _cartBox.delete(key);
  }

  @override
  Future<void> updateCartItem(String id, CartItem updatedItem) async {
    final key = _cartBox.keys.firstWhere((k) => _cartBox.get(k)!.id == id);
    await _cartBox.put(key, updatedItem);
  }

  @override
  Future<void> clearCart() async {
    await _cartBox.clear();
  }
}
