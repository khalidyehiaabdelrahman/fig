import 'package:fig/features/Favorites/presentation/cubit/favorites_cubit.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/product/presentation/pages/Product_detials_Page.dart';
import 'package:fig/features/product/widgets/product_quick_review_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fig/core/utils/responsive.dart';

abstract class ProductView extends StatefulWidget {
  final ProductModel product;
  const ProductView({super.key, required this.product});
}

abstract class ProductViewState<T extends ProductView> extends State<T> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget buildImageWithIcons(
    BuildContext context,
    String imageUrl, {
    bool showSecondIcon = true,
  }) {
    final isFavorite = context.watch<FavoritesCubit>().isFavorite(
      widget.product,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(imageUrl, fit: BoxFit.cover),
        Positioned(
          top: 20.rh(context),
          right: 10.rw(context),
          bottom: 20.rh(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  context.read<FavoritesCubit>().toggleFavorite(widget.product);
                },
              ),
              if (showSecondIcon)
                IconButton(
                  icon: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.rr(context)),
                        ),
                      ),
                      builder:
                          (_) =>
                              ProductQuickReviewSheet(product: widget.product),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImages();

  Widget buildProductInfo();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: widget.product),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImages(),
          SizedBox(height: 4.rh(context)),
          Center(
            child: SmoothPageIndicator(
              controller: pageController,
              count: widget.product.imageUrls.length,
              effect: WormEffect(
                dotHeight: 5,
                dotWidth: 15,
                activeDotColor: Colors.red[900]!,
                dotColor: Colors.grey.shade300,
              ),
            ),
          ),
          SizedBox(height: 6.rh(context)),
          buildProductInfo(),
        ],
      ),
    );
  }
}

class GridProductView extends ProductView {
  final bool showSecondIcon;

  const GridProductView({
    super.key,
    required super.product,
    this.showSecondIcon = true,
  });

  @override
  State<GridProductView> createState() => _GridProductViewState();
}

class _GridProductViewState extends ProductViewState<GridProductView> {
  @override
  Widget buildImages() {
    return Container(
      height: 220.rh(context),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.white),
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.product.imageUrls.length,
        onPageChanged: (index) {
          if (index == widget.product.imageUrls.length - 1) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              pageController.jumpToPage(0);
            });
          }
        },
        itemBuilder: (context, index) {
          return buildImageWithIcons(
            context,
            widget.product.imageUrls[index],
            showSecondIcon: widget.showSecondIcon,
          );
        },
      ),
    );
  }

  @override
  Widget buildProductInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.product.title,
          style: TextStyle(
            fontSize: 13.rt(context),
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.rh(context)),
        Text(
          '${widget.product.price.toStringAsFixed(2)} EGP',
          style: TextStyle(
            fontSize: 13.rt(context),
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ListProductView extends ProductView {
  const ListProductView({super.key, required super.product});

  @override
  State<ListProductView> createState() => _ListProductViewState();
}

class _ListProductViewState extends ProductViewState<ListProductView> {
  @override
  Widget buildImages() {
    return SizedBox(
      height: 450,
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.product.imageUrls.length,
        itemBuilder: (context, index) {
          return buildImageWithIcons(context, widget.product.imageUrls[index]);
        },
      ),
    );
  }

  @override
  Widget buildProductInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.rw(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.rh(context)),
          Text(
            widget.product.title,
            style: TextStyle(
              fontSize: 16.rt(context),
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.rh(context)),
          Text(
            '${widget.product.price.toStringAsFixed(2)} EGP',
            style: TextStyle(
              fontSize: 15.rt(context),
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12.rh(context)),
        ],
      ),
    );
  }
}
