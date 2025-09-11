import 'package:fig/core/widgets/common_widgets.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:fig/features/product/presentation/cubit/products_cubit.dart';
import 'package:fig/features/product/presentation/cubit/products_state.dart';
import 'package:fig/features/home/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/core/widgets/shimmer_skeletons.dart';
import 'package:hive/hive.dart';
import 'package:fig/core/utils/responsive.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final CategoryModel category;

  const ProductsByCategoryScreen({super.key, required this.category});

  @override
  State<ProductsByCategoryScreen> createState() =>
      _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<ProductsByCategoryScreen> {
  bool forceShowShimmer = true;
  List<ProductModel> _cachedProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().fetchProducts();
    context.read<ProductsCubit>().loadSortOption();
    _loadProducts();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          forceShowShimmer = false;
        });
      }
    });
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    final box = await Hive.openBox<ProductModel>('products');
    final products =
        box.values.where((p) => p.categoryId == widget.category.id).toList();

    if (mounted) {
      setState(() {
        _cachedProducts = products;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsPaginationLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _loadProducts();
          });
        }

        if (_isLoading) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.category.name)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Product List (${_cachedProducts.length} products)',
              style: TextStyle(
                fontSize: 18.rt(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            actions: [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey.shade600,
                height: 1.rh(context),
              ),
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

                    if (forceShowShimmer) {
                      return isGrid
                          ? const ProductGridShimmer()
                          : const ProductListShimmer();
                    }

                    if (_cachedProducts.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }

                    return isGrid
                        ? GridView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount: _cachedProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 6,
                                childAspectRatio: 0.5,
                              ),
                          itemBuilder: (context, index) {
                            final product = _cachedProducts[index];
                            return _buildGridProduct(product);
                          },
                        )
                        : ListView.separated(
                          padding: const EdgeInsets.all(6),
                          itemCount: _cachedProducts.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final product = _cachedProducts[index];
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
