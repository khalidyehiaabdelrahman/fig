import 'package:fig/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:fig/features/categories/presentation/cubit/categories_state.dart';
import 'package:fig/features/product/presentation/cubit/products_cubit.dart';
import 'package:fig/features/product/presentation/cubit/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/core/widgets/shimmer_skeletons.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/home/widgets/snack_bar_widget.dart';
import 'package:fig/core/widgets/loading_indicator.dart';

class CategoriesAndProductsScreen extends StatelessWidget {
  const CategoriesAndProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesCubit>(
          create: (_) => CategoriesCubit()..fetchCategories(),
        ),
        BlocProvider<ProductsCubit>(
          create: (_) => ProductsCubit()..fetchProducts(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, categoryState) {
            List<CategoryModel> categories = [];
            if (categoryState is CategoriesLoaded) {
              categories = categoryState.categories;
            }

            return BlocListener<ProductsCubit, ProductsState>(
              listener: (context, productState) {
                if (productState is ProductsPaginationLoaded &&
                    !productState.hasMore &&
                    productState.products.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    TopSnackBar.show(
                      context,
                      message: 'No more products',
                      icon: Icons.info_outline,
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    );
                  });
                }
              },
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, productState) {
                  List<ProductModel> products = [];
                  bool hasMore = false;
                  bool isLoading = false;

                  if (productState is ProductsLoaded) {
                    products = productState.products;
                  } else if (productState is ProductsFiltered) {
                    products = productState.filteredProducts;
                  } else if (productState is ProductsPaginationLoaded) {
                    products = productState.products;
                    hasMore = productState.hasMore;
                    isLoading = productState.isLoading;
                  } else if (productState is ProductsLoadingMore) {
                    products = productState.products;
                    isLoading = true;
                  }

                  if (categoryState is CategoriesLoading ||
                      productState is ProductsLoading) {
                    return const ProductOrCategoryCardShimmer();
                  }

                  final allItems = [
                    ...categories.map((c) => {"type": "category", "data": c}),
                    ...products.map((p) => {"type": "product", "data": p}),
                  ];

                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo is ScrollEndNotification &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        if (hasMore && !isLoading) {
                          context.read<ProductsCubit>().loadMoreProducts();
                        } else if (!hasMore && products.isNotEmpty) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            TopSnackBar.show(
                              context,
                              message: 'No more products',
                              icon: Icons.info_outline,
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            );
                          });
                        }
                      }
                      return false;
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: allItems.length + (hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == allItems.length) {
                          return Container(
                            height: 60,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: LoadingIndicator(
                                color: Colors.red.shade800,
                              ),
                            ),
                          );
                        }
                        final item = allItems[index];

                        return Container(
                          height: 100,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:
                                      item["type"] == "product"
                                          ? ((item["data"] as ProductModel)
                                                  .imageUrls
                                                  .isNotEmpty
                                              ? Image.asset(
                                                (item["data"] as ProductModel)
                                                    .imageUrls
                                                    .first,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )
                                              : Container(
                                                width: 100,
                                                height: 100,
                                                color: Colors.grey[400],
                                                child: const Icon(
                                                  Icons.shopping_bag,
                                                  size: 32,
                                                  color: Colors.white,
                                                ),
                                              ))
                                          : ((item["data"] as CategoryModel)
                                                  .imageUrl
                                                  .isNotEmpty
                                              ? Image.asset(
                                                (item["data"] as CategoryModel)
                                                    .imageUrl,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )
                                              : Container(
                                                width: 100,
                                                height: 100,
                                                color: Colors.grey[400],
                                                child: const Icon(
                                                  Icons.category,
                                                  size: 32,
                                                  color: Colors.white,
                                                ),
                                              )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  item["type"] == "category"
                                      ? (item["data"] as CategoryModel).name
                                      : (item["data"] as ProductModel).title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
