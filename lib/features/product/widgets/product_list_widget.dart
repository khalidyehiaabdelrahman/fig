import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:fig/core/widgets/loading_indicator.dart';

class ProductListWidget extends StatelessWidget {
  final List<ProductModel> products;
  final bool hasMore;
  final bool isLoading;
  final VoidCallback? onLoadMore;

  const ProductListWidget({
    super.key,
    required this.products,
    this.hasMore = false,
    this.isLoading = false,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo is ScrollEndNotification &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            if (hasMore && !isLoading && onLoadMore != null) {
              onLoadMore!();
            } else if (!hasMore && products.isNotEmpty) {
              
              WidgetsBinding.instance.addPostFrameCallback((_) {
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('No more products'),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
              });
            }
          }
          return false;
        },
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: products.length + (hasMore ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            if (index == products.length) {
              
              return Container(
                width: 60,
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: const Center(child: LoadingIndicator(color: Colors.red)),
              );
            }

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
      ),
    );
  }
}
