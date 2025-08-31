import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:hive/hive.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  late final Box<CartItem> cartBox;

  CartCubit() : super(const CartInitial()) {
    cartBox = Hive.box<CartItem>('cart');
    _loadCart();
  }

  void _loadCart() {
    final cartItems = cartBox.values.toList();
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

    await cartBox.add(newItem);

    final updatedCart = cartBox.values.toList();
    emit(CartLoaded(cart: updatedCart, total: _calculateTotal(updatedCart)));
  }

  void removeFromCart(String id) async {
    final key = cartBox.keys.firstWhere((k) => cartBox.get(k)!.id == id);
    await cartBox.delete(key);

    final updatedCart = cartBox.values.toList();
    emit(CartLoaded(cart: updatedCart, total: _calculateTotal(updatedCart)));
  }

  void updateQuantity(String id, int qty) async {
    final key = cartBox.keys.firstWhere((k) => cartBox.get(k)!.id == id);
    final item = cartBox.get(key)!;
    await cartBox.put(key, item.copyWith(quantity: qty));

    final updatedCart = cartBox.values.toList();
    emit(CartLoaded(cart: updatedCart, total: _calculateTotal(updatedCart)));
  }

  double _calculateTotal(List<CartItem> cart) {
    return cart.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }
}
