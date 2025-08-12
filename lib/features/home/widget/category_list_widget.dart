import 'package:flutter/material.dart';
import 'package:fig/features/home/domain/category_model.dart';
import 'package:fig/features/home/presentation/pages/Category_Products_Page_Screen.dart';

class CategoryListWidget extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoryListWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CategoryProductsScreen(category: category),
                ),
              );
            },
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    category.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                Text(category.name, style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}
