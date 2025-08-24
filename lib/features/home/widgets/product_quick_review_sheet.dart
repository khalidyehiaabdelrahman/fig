import 'package:fig/features/home/widgets/add_to_cart_button.dart';
import 'package:fig/features/home/widgets/colors_selector.dart';
import 'package:fig/features/home/widgets/sizes_selector.dart';
import 'package:flutter/material.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/home/presentation/pages/Product_detials_Page.dart';

class ProductQuickReviewSheet extends StatefulWidget {
  final ProductModel product;
  const ProductQuickReviewSheet({super.key, required this.product});

  @override
  State<ProductQuickReviewSheet> createState() =>
      _ProductQuickReviewSheetState();
}

class _ProductQuickReviewSheetState extends State<ProductQuickReviewSheet> {
  String? selectedColor;
  int? selectedSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildHeader(context),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildProductInfo(),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizesSelector(
                  sizes: widget.product.availableSizes,
                  selectedSize: selectedSize,
                  onSizeSelected: (size) {
                    setState(() => selectedSize = size);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ColorsSelector(
                  colors: widget.product.availableColors,
                  selectedColor: selectedColor,
                  onColorSelected: (color) {
                    setState(() => selectedColor = color);
                  },
                ),
              ),
              const SizedBox(height: 30),
              _buildGoToDetails(context),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AddToCartButton(
                  product: widget.product,
                  isEnabled: selectedColor != null && selectedSize != null,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Quick Review",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget _buildProductInfo() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          widget.product.imageUrls.first,
          height: 120,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),

      SizedBox(width: 15),
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
                  widget.product.lapel ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${widget.product.price} EGP',
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
            builder: (_) => ProductDetailsScreen(product: widget.product),
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
