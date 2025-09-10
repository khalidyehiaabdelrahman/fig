import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/product/presentation/cubit/products_cubit.dart';
import 'package:fig/features/product/presentation/cubit/products_state.dart';
import 'package:fig/features/product/widgets/product_list_widget.dart';
import 'package:fig/core/widgets/shimmer_skeletons.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {},
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const CategoryRowShimmer();
          } else if (state is ProductsError) {
            return Center(child: Text(state.error));
          } else if (state is ProductsLoaded) {
            return ProductListWidget(
              products: state.products,
              hasMore: false,
              isLoading: false,
              onLoadMore: null,
            );
          } else if (state is ProductsFiltered) {
            return ProductListWidget(
              products: state.filteredProducts,
              hasMore: false,
              isLoading: false,
              onLoadMore: null,
            );
          } else if (state is ProductsPaginationLoaded) {
            return ProductListWidget(
              products: state.products,
              hasMore: state.hasMore,
              isLoading: state.isLoading,
              onLoadMore:
                  () => context.read<ProductsCubit>().loadMoreProducts(),
            );
          } else if (state is ProductsLoadingMore) {
            return ProductListWidget(
              products: state.products,
              hasMore: true,
              isLoading: true,
              onLoadMore: null,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
