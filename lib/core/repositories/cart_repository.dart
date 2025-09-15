import 'package:fig/features/home/domain/model/category_model.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(String id);
  Future<void> updateCartItem(String id, CartItem updatedItem);
  Future<void> clearCart();
}
