import 'package:fig/features/home/domain/model/category_model.dart';

abstract class CartState {
  final List<CartItem> cart;
  final double total;

  const CartState({this.cart = const [], this.total = 0});
}

class CartInitial extends CartState {
  const CartInitial() : super(cart: const [], total: 0);
}

class CartLoaded extends CartState {
  const CartLoaded({required List<CartItem> cart, required double total})
    : super(cart: cart, total: total);
}
