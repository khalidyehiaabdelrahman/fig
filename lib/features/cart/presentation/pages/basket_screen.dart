import 'package:fig/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fig/features/cart/presentation/cubit/cart_state.dart';
import 'package:fig/features/main/presentation/cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CartLoaded) {
          final cart = state.cart;
          final grandTotal = state.total;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              title: Text('My Shopping Cart (${cart.length} Products)'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    context.read<MainCubit>().changeTab(0);
                  },
                ),
              ],
            ),
            body:
                cart.isEmpty
                    ? const Center(child: Text('Your cart is empty'))
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.grey.shade200,
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            'Get extra 5% off at cart on app! Only for credit card payments!',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: cart.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) {
                              final cartItem = cart[index];
                              final product = cartItem.product;
                              final qty = cartItem.quantity;

                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      height: 120,
                                      child: Image.asset(
                                        product.imageUrls.first,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(product.id),
                                          Text(
                                            'Size: ${cartItem.selectedSize ?? "-"}',
                                          ),
                                          Text(
                                            'Color: ${cartItem.selectedColor ?? "-"}',
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'EGP ${product.price.toStringAsFixed(0)}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 28,
                                          ),
                                          onPressed: () {
                                            context
                                                .read<CartCubit>()
                                                .removeFromCart(cartItem.id);
                                          },
                                        ),
                                        DropdownButton<int>(
                                          value: qty,
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          elevation: 16,
                                          underline: const SizedBox.shrink(),
                                          items:
                                              List.generate(
                                                5,
                                                (i) => i + 1,
                                              ).map<DropdownMenuItem<int>>((
                                                int value,
                                              ) {
                                                return DropdownMenuItem<int>(
                                                  value: value,
                                                  child: Text(value.toString()),
                                                );
                                              }).toList(),
                                          onChanged: (int? newValue) {
                                            if (newValue != null) {
                                              context
                                                  .read<CartCubit>()
                                                  .updateQuantity(
                                                    cartItem.id,
                                                    newValue,
                                                  );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 6,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'GRAND TOTAL',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'EGP ${grandTotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: Colors.red[600],
                            ),
                            onPressed: () {},
                            child: const Text(
                              'PROCEED TO PAYMENT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
