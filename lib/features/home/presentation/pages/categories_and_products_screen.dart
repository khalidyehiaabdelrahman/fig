import 'package:fig/features/home/presentation/cubit/categories_cubit.dart';
import 'package:fig/features/home/presentation/cubit/categories_state.dart';
import 'package:fig/features/home/presentation/cubit/products_cubit.dart';
import 'package:fig/features/home/presentation/cubit/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/core/widgets/shimmer_skeletons.dart';
import 'package:fig/features/home/domain/model/category_model.dart';

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

            return BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, productState) {
                List<ProductModel> products = [];
                if (productState is ProductsLoaded) {
                  products = productState.products;
                } else if (productState is ProductsFiltered) {
                  products = productState.filteredProducts;
                }

                if (categoryState is CategoriesLoading ||
                    productState is ProductsLoading) {
                  return const ProductOrCategoryCardShimmer();
                }

                final allItems = [
                  ...categories.map((c) => {"type": "category", "data": c}),
                  ...products.map((p) => {"type": "product", "data": p}),
                ];

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: allItems.length,
                  itemBuilder: (context, index) {
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
