import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:hive/hive.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  late final Box<CartItem> cartBox;

  CartCubit() : super(const CartState()) {
    cartBox = Hive.box<CartItem>('cart');
    loadCart();
  }

  /// تحميل الكارت من Hive عند بدء التطبيق
  Future<void> loadCart() async {
    emit(
      state.copyWith(
        cart: cartBox.values.toList(),
        total: _calculateTotal(cartBox.values.toList()),
      ),
    );
  }

  /// إضافة عنصر للكارت وحفظه في Hive
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
    emit(
      state.copyWith(cart: updatedCart, total: _calculateTotal(updatedCart)),
    );
  }

  /// إزالة عنصر من الكارت وحذفه من Hive
  void removeFromCart(String id) async {
    final key = cartBox.keys.firstWhere((k) => cartBox.get(k)!.id == id);
    await cartBox.delete(key);

    final updatedCart = cartBox.values.toList();
    emit(
      state.copyWith(cart: updatedCart, total: _calculateTotal(updatedCart)),
    );
  }

  /// تعديل كمية عنصر في الكارت وحفظه في Hive
  void updateQuantity(String id, int qty) async {
    final key = cartBox.keys.firstWhere((k) => cartBox.get(k)!.id == id);
    final item = cartBox.get(key)!;
    await cartBox.put(key, item.copyWith(quantity: qty));

    final updatedCart = cartBox.values.toList();
    emit(
      state.copyWith(cart: updatedCart, total: _calculateTotal(updatedCart)),
    );
  }

  /// حساب الإجمالي
  double _calculateTotal(List<CartItem> cart) {
    return cart.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }
}
