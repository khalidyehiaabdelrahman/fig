import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<CartItem> cart;
  final double total;

  const CartState({this.cart = const [], this.total = 0});

  CartState copyWith({List<CartItem>? cart, double? total}) {
    return CartState(cart: cart ?? this.cart, total: total ?? this.total);
  }

  @override
  List<Object?> get props => [cart, total];
}
