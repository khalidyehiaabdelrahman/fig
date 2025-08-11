import 'package:fig/features/home/domain/category_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

abstract class ProductView extends StatefulWidget {
  final ProductModel product;
  const ProductView({Key? key, required this.product}) : super(key: key);
}

abstract class ProductViewState<T extends ProductView> extends State<T> {
  late final PageController pageController;
  bool isFavorite = false;

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

  // دالة تبني صورة مع أيقونات favorites وشراء فوقها
  Widget buildImageWithIcons(String imageUrl) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(imageUrl, fit: BoxFit.cover),
        Positioned(
          top: 20,
          right: 10,
          bottom: 20,
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
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  // هنا كود الإضافة للسلة أو الشراء
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
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Column(
        children: [
          buildImages(),
          const SizedBox(height: 4),
          SmoothPageIndicator(
            controller: pageController,
            count: widget.product.imageUrls.length,
            effect: WormEffect(
              dotHeight: 5,
              dotWidth: 15,
              activeDotColor: Colors.red[900]!,
              dotColor: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 6),
          buildProductInfo(),
        ],
      ),
    );
  }
}

class GridProductView extends ProductView {
  const GridProductView({Key? key, required super.product}) : super(key: key);

  @override
  State<GridProductView> createState() => _GridProductViewState();
}

class _GridProductViewState extends ProductViewState<GridProductView> {
  @override
  Widget buildImages() {
    return Container(
      height: 300,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
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
          return buildImageWithIcons(widget.product.imageUrls[index]);
        },
      ),
    );
  }

  @override
  Widget buildProductInfo() {
    return Column(
      children: [
        Text(
          widget.product.title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          '${widget.product.price.toStringAsFixed(2)} EGP',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ListProductView extends ProductView {
  const ListProductView({Key? key, required super.product}) : super(key: key);

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
          return buildImageWithIcons(widget.product.imageUrls[index]);
        },
      ),
    );
  }

  @override
  Widget buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            widget.product.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.product.price.toStringAsFixed(2)} EGP',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
