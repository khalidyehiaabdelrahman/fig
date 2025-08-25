import 'package:fig/features/Favorites/presentation/cubit/favorites_cubit.dart';
import 'package:fig/features/home/presentation/cubit/product_selection_cubit.dart';
import 'package:fig/features/home/presentation/cubit/product_selection_state.dart';
import 'package:fig/features/home/widgets/add_to_cart_button.dart';
import 'package:fig/features/home/widgets/colors_selector.dart';
import 'package:fig/features/home/widgets/sizes_selector.dart';
import 'package:fig/features/home/widgets/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/home/presentation/pages/Product_detials_Page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductQuickReviewSheet extends StatelessWidget {
  final ProductModel product;
  const ProductQuickReviewSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductSelectionCubit(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildHeader(context),
              ),
            ),
            BlocBuilder<ProductSelectionCubit, ProductSelectionState>(
              builder: (context, selection) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _buildProductInfo(),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizesSelector(
                        sizes: product.availableSizes,
                        selectedSize: selection.selectedSize,
                        onSizeSelected:
                            (size) => context
                                .read<ProductSelectionCubit>()
                                .selectSize(size),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ColorsSelector(
                        colors: product.availableColors,
                        selectedColor: selection.selectedColor,
                        onColorSelected:
                            (color) => context
                                .read<ProductSelectionCubit>()
                                .selectColor(color),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildGoToDetails(context),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AddToCartButton(
                        product: product,
                        isEnabled:
                            selection.selectedColor != null &&
                            selection.selectedSize != null,
                        selectedColor: selection.selectedColor,
                        selectedSize: selection.selectedSize,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isFav = context.watch<FavoritesCubit>().isFavorite(product);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Quick Review",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Colors.black,
          ),
          onPressed: () {
            context.read<FavoritesCubit>().toggleFavorite(product);

            TopSnackBar.show(
              context,
              message: isFav ? "Removed from favorites" : "Added to favorites",
              icon: isFav ? Icons.favorite_border : Icons.favorite,
            );
          },
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(fontSize: 18, color: Colors.red[900]),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          product.imageUrls.first,
          height: 120,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(width: 15),
      Expanded(
        child: SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.lapel ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${product.price} EGP',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buildGoToDetails(BuildContext context) => Center(
    child: GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: const Text(
        "Go to Product Details",
        style: TextStyle(
          fontSize: 16,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
