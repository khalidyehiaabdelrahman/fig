import 'package:fig/features/home/domain/category_model.dart';
import 'package:flutter/material.dart';

class ProductListWidget extends StatelessWidget {
  final List<ProductModel> products;

  const ProductListWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          return Column(
            children: [
              ClipOval(
                child: Image.asset(
                  product.imageUrls[0],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 6),
              Text(product.title, style: const TextStyle(fontSize: 12)),
            ],
          );
        },
      ),
    );
  }
}
