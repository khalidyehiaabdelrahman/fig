import 'package:fig/core/widgets/common_widgets.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:fig/features/home/presentation/cubit/products_cubit.dart';
import 'package:fig/features/home/presentation/cubit/products_state.dart';
import 'package:fig/features/home/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/core/widgets/shimmer_skeletons.dart';

class CategoryProductsScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  bool forceShowShimmer = true;

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().loadSortOption();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          forceShowShimmer = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        List<ProductModel> filtered = [];

        if (state is ProductsError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text(state.error)),
          );
        }

        if (state is ProductsLoaded) {
          filtered =
              state.products
                  .where((p) => p.categoryId == widget.category.id)
                  .toList();
        } else if (state is ProductsFiltered) {
          filtered =
              state.filteredProducts
                  .where((p) => p.categoryId == widget.category.id)
                  .toList();
        }

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
            actions: [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ],
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
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        final cubit = context.read<HomeCubit>();

                        bool isGrid = cubit.isGrid;
                        if (state is GridChanged) {
                          isGrid = state.isGrid;
                        }

                        return Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.view_list,
                                color: !isGrid ? Colors.red[900] : Colors.black,
                              ),
                              onPressed: () {
                                context.read<HomeCubit>().toggleGrid();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.grid_view,
                                color: isGrid ? Colors.red[900] : Colors.black,
                              ),
                              onPressed: () {
                                context.read<HomeCubit>().toggleGrid();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              buildReusableDivider(),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, homeState) {
                    final isGrid =
                        homeState is GridChanged
                            ? homeState.isGrid
                            : context.read<HomeCubit>().isGrid;

                    if (state is ProductsLoading || forceShowShimmer) {
                      return isGrid
                          ? const ProductGridShimmer()
                          : const ProductListShimmer();
                    }

                    if (filtered.isEmpty) {
                      return const Center(child: Text('No products found'));
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
                  },
                ),
              ),
            ],
          ),
        );
      },
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
  final cubit = context.read<ProductsCubit>();
  final selected = cubit.currentSortOption ?? 'Recommended Sorting';

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
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
                    Text('SORT', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.red,
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
}

Widget _buildSortOption(BuildContext context, String title, String? selected) {
  return ListTile(
    title: Text(title),
    trailing:
        selected == title ? const Icon(Icons.check, color: Colors.green) : null,
    onTap: () {
      final cubit = context.read<ProductsCubit>();
      cubit.changeSortOption(title);
      Navigator.pop(context);
    },
  );
}
