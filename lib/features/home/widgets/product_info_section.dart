import 'package:fig/core/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fig/features/home/widgets/colors_selector.dart';
import 'package:fig/features/home/widgets/sizes_selector.dart';

class ProductInfoSection extends StatelessWidget {
  final List<int> sizes;
  final List<String> colors;
  final int? selectedSize;
  final String? selectedColor;
  final ValueChanged<int> onSizeSelected;
  final ValueChanged<String> onColorSelected;
  final String shortDescription;
  final String fullDescription;
  final String title;
  final String price;
  final String lapel;

  const ProductInfoSection({
    super.key,
    required this.sizes,
    required this.colors,
    this.selectedSize,
    this.selectedColor,
    required this.onSizeSelected,
    required this.onColorSelected,
    required this.shortDescription,
    required this.fullDescription,
    required this.title,
    required this.price,
    required this.lapel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '${price} EGP',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        Text(lapel, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        buildReusableDivider(),
        // Sizes Selector
        SizesSelector(
          sizes: sizes,
          selectedSize: selectedSize,
          onSizeSelected: onSizeSelected,
        ),
        const SizedBox(height: 20),

        // Colors Selector
        ColorsSelector(
          colors: colors,
          selectedColor: selectedColor,
          onColorSelected: onColorSelected,
        ),
        const SizedBox(height: 18),

        const Text(
          "Product Short Description",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          shortDescription,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.4,
          ),
        ),

        const Text(
          "Product Full Description",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          fullDescription,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.4,
          ),
        ),

        // Return Section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Return Within 30 Days",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.1416),
              child: const Icon(Icons.replay, color: Colors.black54, size: 24),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Payment Options Section
        const Text(
          "Payment Options",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 18),

        Row(
          children: const [
            Icon(Icons.payments, color: Colors.yellow, size: 24),
            SizedBox(width: 8),
            Text(
              "Paying Cash On Delivery",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: const [
            Icon(Icons.payment, color: Colors.blue, size: 24),
            SizedBox(width: 8),
            Text(
              "Card Payment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
