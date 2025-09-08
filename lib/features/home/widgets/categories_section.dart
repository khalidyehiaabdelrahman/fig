import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:fig/features/categories/presentation/cubit/categories_state.dart';
import 'package:fig/features/categories/widgets/category_list_widget.dart';
import 'package:fig/core/widgets/shimmer_skeletons.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const CategoryRowShimmer();
        } else if (state is CategoriesError) {
          return Center(child: Text(state.error));
        } else if (state is CategoriesLoaded) {
          return CategoryListWidget(categories: state.categories);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
