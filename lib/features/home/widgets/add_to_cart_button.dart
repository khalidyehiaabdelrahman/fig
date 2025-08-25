import 'package:fig/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/home/widgets/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartButton extends StatelessWidget {
  final ProductModel product;
  final bool isEnabled;
  final bool popAfterAdd;

  final Color? backgroundColor;
  final Color? textColor;
  final String? selectedColor;
  final int? selectedSize;

  const AddToCartButton({
    super.key,
    required this.product,
    required this.isEnabled,
    this.popAfterAdd = true,
    this.backgroundColor,
    this.textColor,

    this.selectedColor,
    this.selectedSize,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor =
        backgroundColor ?? (isEnabled ? Colors.red : Colors.grey.shade300);
    final fgColor = textColor ?? (isEnabled ? Colors.white : Colors.black54);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (!isEnabled) {
            TopSnackBar.show(
              context,
              message: 'Choose Color And Size.',
              icon: Icons.error_outline,
            );
            return;
          }

          context.read<CartCubit>().addToCart(
            product,
            color: selectedColor!,
            size: selectedSize!,
          );

          TopSnackBar.show(
            context,
            message: 'Added to cart successfully!',
            icon: Icons.check_circle_outline,
          );

          if (popAfterAdd) {
            Navigator.pop(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          isEnabled ? "Add to Cart" : "Choose Color And Size.",
          style: TextStyle(
            color: fgColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
