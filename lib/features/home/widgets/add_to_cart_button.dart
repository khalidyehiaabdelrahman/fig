import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/widgets/snack_bar_widget.dart';

class AddToCartButton extends StatelessWidget {
  final ProductModel product;
  final bool isEnabled;
  final bool popAfterAdd; 

  const AddToCartButton({
    super.key,
    required this.product,
    required this.isEnabled,
    this.popAfterAdd = true,
  });

  @override
  Widget build(BuildContext context) {
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

          context.read<HomeCubit>().addToCart(product);

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
          backgroundColor: isEnabled ? Colors.red : Colors.grey.shade400,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          isEnabled ? "Add to Cart" : "Choose Color And Size.",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
