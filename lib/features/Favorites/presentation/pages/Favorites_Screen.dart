import 'package:fig/features/Favorites/presentation/cubit/favorites_cubit.dart';
import 'package:fig/features/Favorites/presentation/cubit/favorites_state.dart';
import 'package:fig/features/home/widgets/add_to_cart_button.dart';
import 'package:fig/features/home/widgets/home_widget.dart';
import 'package:fig/features/product/widgets/product_quick_review_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/core/utils/responsive.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Text(
        'My Favorites',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: 16.rw(context)),
          icon: Icon(Icons.search, size: 28.rt(context), color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FavoritesLoaded) {
          final favorites = state.favorites;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _buildAppBar(context),
            body:
                favorites.isEmpty
                    ? const Center(child: Text('No favorite products yet'))
                    : GridView.builder(
                      padding: EdgeInsets.all(8.rw(context)),
                      itemCount: favorites.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.5,
                          ),
                      itemBuilder: (context, index) {
                        final product = favorites[index];
                        return Column(
                          children: [
                            Expanded(
                              child: GridProductView(
                                product: product,
                                showSecondIcon: false,
                              ),
                            ),
                            AddToCartButton(
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              product: product,
                              isEnabled: true,
                              popAfterAdd: false,
                              selectedColor: null,
                              selectedSize: null,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder:
                                      (_) => FractionallySizedBox(
                                        heightFactor: 0.25,
                                        widthFactor: 1.0,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: ProductQuickReviewSheet(
                                            product: product,
                                            quickAddMode: true,
                                          ),
                                        ),
                                      ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
