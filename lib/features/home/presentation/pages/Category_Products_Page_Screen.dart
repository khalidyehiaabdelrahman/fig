import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:fig/features/home/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CategoryProductsScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  bool isGrid = true;
  bool showShimmer = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showShimmer = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered =
        context
            .watch<HomeCubit>()
            .state
            .filteredProducts
            .where((p) => p.categoryId == widget.category.id)
            .toList();

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
                showShimmer
                    ? (isGrid ? _buildGridShimmer() : _buildListShimmer())
                    : BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state.productsError != null) {
                          return Center(child: Text(state.productsError!));
                        } else {
                          final filtered =
                              state.filteredProducts
                                  .where(
                                    (p) => p.categoryId == widget.category.id,
                                  )
                                  .toList();

                          if (filtered.isEmpty) {
                            return Center(child: Text('No products found'));
                          }

                          return isGrid
                              ? GridView.builder(
                                padding: const EdgeInsets.all(5),
                                itemCount: filtered.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 15,
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
                                separatorBuilder:
                                    (_, __) => const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final product = filtered[index];
                                  return _buildListProduct(product);
                                },
                              );
                        }
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridProduct(ProductModel product) {
    return GridProductView(product: product);
  }

  Widget _buildListProduct(ProductModel product) {
    return ListProductView(product: product);
  }
}

void _showSortBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final selected = state.currentSortOption;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                          color: Colors.red[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                _buildSortOption(context, 'Recommended Sorting', selected),
                const Divider(),
                _buildSortOption(context, 'Lowest Price', selected),
                const Divider(),
                _buildSortOption(context, 'Highest Price', selected),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildSortOption(BuildContext context, String title, String? selected) {
  return ListTile(
    title: Text(title),
    trailing:
        selected == title ? const Icon(Icons.check, color: Colors.green) : null,
    onTap: () {
      context.read<HomeCubit>().sortProducts(title);
      Navigator.pop(context);
    },
  );
}

Widget _buildGridShimmer() {
  return GridView.builder(
    padding: const EdgeInsets.all(5),
    itemCount: 16,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 1,
      mainAxisSpacing: 6,
      childAspectRatio: 0.5,
    ),
    itemBuilder: (context, index) {
      return Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(height: 300, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Container(width: 140, height: 20, color: Colors.white),
              const SizedBox(height: 6),
              Container(width: 120, height: 16, color: Colors.white),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildListShimmer() {
  return ListView.separated(
    padding: const EdgeInsets.all(6),
    itemCount: 4,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (context, index) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(height: 450, color: Colors.white),
              const SizedBox(height: 8),
              Container(
                height: 12,
                margin: const EdgeInsets.symmetric(horizontal: 120),
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Container(
                height: 12,
                margin: const EdgeInsets.symmetric(horizontal: 120),
                color: Colors.white,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      );
    },
  );
}
