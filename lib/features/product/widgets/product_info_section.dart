import 'package:fig/core/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fig/features/home/widgets/colors_selector.dart';
import 'package:fig/features/home/widgets/sizes_selector.dart';
import 'package:fig/core/utils/responsive.dart';

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
                style: TextStyle(
                  fontSize: 22.rt(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '${price} EGP',
              style: TextStyle(
                fontSize: 20.rt(context),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.rh(context)),

        Text(
          lapel,
          style: TextStyle(fontSize: 16.rt(context), color: Colors.grey),
        ),
        buildReusableDivider(),

        SizesSelector(
          sizes: sizes,
          selectedSize: selectedSize,
          onSizeSelected: onSizeSelected,
        ),
        SizedBox(height: 20.rh(context)),

        ColorsSelector(
          colors: colors,
          selectedColor: selectedColor,
          onColorSelected: onColorSelected,
        ),
        SizedBox(height: 18.rh(context)),

        Text(
          "Product Short Description",
          style: TextStyle(
            fontSize: 18.rt(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.rh(context)),
        Text(
          shortDescription,
          style: TextStyle(
            fontSize: 16.rt(context),
            color: Colors.black87,
            height: 1.4,
          ),
        ),

        Text(
          "Product Full Description",
          style: TextStyle(
            fontSize: 18.rt(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.rh(context)),
        Text(
          fullDescription,
          style: TextStyle(
            fontSize: 16.rt(context),
            color: Colors.black87,
            height: 1.4,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Return Within 30 Days",
              style: TextStyle(
                fontSize: 18.rt(context),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8.rw(context)),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.1416),
              child: Icon(
                Icons.replay,
                color: Colors.black54,
                size: 24.rt(context),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.rh(context)),

        Text(
          "Payment Options",
          style: TextStyle(
            fontSize: 18.rt(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 18.rh(context)),

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
