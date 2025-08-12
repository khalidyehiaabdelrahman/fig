import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  PreferredSizeWidget _buildAppBar() {
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          icon: const Icon(Icons.search, size: 28, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<HomeCubit>().state.favorites;
    final homeCubit = context.read<HomeCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body:
          favorites.isEmpty
              ? const Center(child: Text('No favorite products yet'))
              : GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: favorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.5,
                ),
                itemBuilder: (context, index) {
                  final product = favorites[index];
                  return Column(
                    children: [
                      GridProductView(product: product, showSecondIcon: false),
                      ElevatedButton(
                        onPressed: () {
                          homeCubit.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${product.title} to cart'),
                            ),
                          );
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  );
                },
              ),
    );
  }
}
