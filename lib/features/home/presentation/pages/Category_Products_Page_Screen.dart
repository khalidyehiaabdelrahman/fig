import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/home/domain/category_model.dart';
import 'package:fig/features/home/presentation/cubit/products_cubit.dart';
import 'package:fig/features/home/presentation/cubit/products_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CategoryProductsScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    final allProducts =
        (context.read<ProductsCubit>().state as ProductsLoaded).allProducts;
    final filtered =
        allProducts.where((p) => p.categoryId == widget.category.id).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Product List (${filtered.length} products)',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade600, height: 1.0),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () => _showSortBottomSheet(context),
                  icon: const Icon(Icons.sort, color: Colors.black),
                  label: const Text(
                    'Sort',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.view_list,
                        color: !isGrid ? Colors.red[900] : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isGrid = false;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.grid_view,
                        color: isGrid ? Colors.red[900] : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isGrid = true;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          // 🛒 Products view
          Expanded(
            child:
                isGrid
                    ? GridView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: filtered.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 6,
                            childAspectRatio: 0.5,
                          ),
                      itemBuilder: (context, index) {
                        final product = filtered[index];
                        return _buildGridProduct(product);
                      },
                    )
                    : ListView.separated(
                      padding: const EdgeInsets.all(6),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final product = filtered[index];
                        return _buildListProduct(product);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridProduct(ProductModel product) {
    final pageController = PageController();

    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔁 PageView داخل Container دائري
          Container(
            height: 300,
            decoration: BoxDecoration(color: Colors.white),
            clipBehavior: Clip.antiAlias,
            child: PageView.builder(
              controller: pageController,
              itemCount: product.imageUrls.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  product.imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),

          const SizedBox(height: 4),

          // ⬤ SmoothPageIndicator
          SmoothPageIndicator(
            controller: pageController,
            count: product.imageUrls.length,
            effect: WormEffect(
              dotHeight: 5,
              dotWidth: 15,
              activeDotColor: Colors.red[900]!,
              dotColor: Colors.grey.shade300,
            ),
          ),

          const SizedBox(height: 6),

          // 📝 اسم المنتج
          Text(
            product.title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),

          // 💰 السعر
          Text(
            '${product.price.toStringAsFixed(2)} EGP',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListProduct(ProductModel product) {
    final pageController = PageController();

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // 🔥 بدون انحناءات
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🔁 الصور في PageView
          SizedBox(
            height: 450,
            child: PageView.builder(
              controller: pageController,
              itemCount: product.imageUrls.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  product.imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // ⬤ SmoothPageIndicator
          Center(
            child: SmoothPageIndicator(
              controller: pageController,
              count: product.imageUrls.length,
              effect: WormEffect(
                dotHeight: 5,
                dotWidth: 12,
                activeDotColor: Colors.red[900]!,
                dotColor: Colors.grey.shade300,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // 📝 اسم المنتج
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              product.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),

          const SizedBox(height: 4),

          // 💰 السعر
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${product.price.toStringAsFixed(2)} EGP',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

void _showSortBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      String selected = 'Recommended Sorting';
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.swap_vert),
                        SizedBox(width: 3),
                        Text(
                          'SORT',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(),
                _buildSortOption('Recommended Sorting', selected, setState),
                Divider(),
                _buildSortOption('Lowest Price', selected, setState),
                Divider(),
                _buildSortOption('Highest Price', selected, setState),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildSortOption(
  String title,
  String selected,
  void Function(void Function()) setState,
) {
  return ListTile(
    title: Text(title),
    trailing:
        selected == title ? const Icon(Icons.check, color: Colors.green) : null,
    onTap: () {
      setState(() {
        selected = title;
      });
    },
  );
}
