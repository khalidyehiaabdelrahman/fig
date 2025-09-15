import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/core/repositories/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit(this._repository) : super(const CartInitial()) {
    _loadCart();
  }

  void _loadCart() async {
    final cartItems = await _repository.getCartItems();
    emit(CartLoaded(cart: cartItems, total: _calculateTotal(cartItems)));
  }

  void addToCart(ProductModel product, {String? color, int? size}) async {
    final newItem = CartItem(
      id: const Uuid().v4(),
      product: product,
      quantity: 1,
      selectedColor: color,
      selectedSize: size,
    );

    await _repository.addToCart(newItem);

    final updatedCart = await _repository.getCartItems();
    emit(CartLoaded(cart: updatedCart, total: _calculateTotal(updatedCart)));
  }

  void removeFromCart(String id) async {
    await _repository.removeFromCart(id);

    final updatedCart = await _repository.getCartItems();
    emit(CartLoaded(cart: updatedCart, total: _calculateTotal(updatedCart)));
  }

  void updateQuantity(String id, int qty) async {
    final cartItems = await _repository.getCartItems();
    final item = cartItems.firstWhere((item) => item.id == id);
    final updatedItem = item.copyWith(quantity: qty);

    await _repository.updateCartItem(id, updatedItem);

    final updatedCart = await _repository.getCartItems();
    emit(CartLoaded(cart: updatedCart, total: _calculateTotal(updatedCart)));
  }

  double _calculateTotal(List<CartItem> cart) {
    return cart.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }
}
