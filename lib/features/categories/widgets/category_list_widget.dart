import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/product/presentation/pages/products_by_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:fig/core/utils/responsive.dart';

class CategoryListWidget extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoryListWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.rh(context),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.rw(context)),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.rw(context)),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ProductsByCategoryScreen(category: category),
                ),
              );
            },
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    category.imageUrl,
                    width: 50.rw(context),
                    height: 50.rh(context),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 6.rh(context)),
                Text(category.name, style: TextStyle(fontSize: 12.rt(context))),
              ],
            ),
          );
        },
      ),
    );
  }
}
