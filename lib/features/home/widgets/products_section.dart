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
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const CategoryRowShimmer();
        } else if (state is ProductsError) {
          return Center(child: Text(state.error));
        } else if (state is ProductsLoaded) {
          return ProductListWidget(products: state.products);
        } else if (state is ProductsFiltered) {
          return ProductListWidget(products: state.filteredProducts);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
