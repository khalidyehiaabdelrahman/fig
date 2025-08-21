import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/widgets/add_to_cart_button.dart';
import 'package:fig/features/home/widgets/carousel_widget.dart';
import 'package:fig/features/home/widgets/product_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late PageController _pageController;

  int _selectedImage = 0;
  String? _selectedColor;
  int? _selectedSize;

  late final List<String> colors;
  late final List<int> sizes;

  late DraggableScrollableController _draggableController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedImage);
    _draggableController = DraggableScrollableController();
    colors = widget.product.availableColors;
    sizes = widget.product.availableSizes;
  }

  void _togglePanel() {
    if (_isExpanded) {
      _draggableController.animateTo(
        0.42,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _draggableController.animateTo(
        0.65,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.product.title),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              CarouselWidget(
                pageController: _pageController,
                images: widget.product.imageUrls,
                height: 400,
                scrollDirection: Axis.vertical,
                onPageChanged:
                    (index) => setState(() => _selectedImage = index),
              ),

              Positioned(
                left:
                    Directionality.of(context) == TextDirection.rtl ? 8 : null,
                right:
                    Directionality.of(context) == TextDirection.ltr ? 8 : null,
                top: 0,
                bottom: 0,
                child: CarouselIndicator(
                  itemCount: widget.product.imageUrls.length,
                  currentPage: _selectedImage,
                  direction: Axis.vertical,
                  size: 8,
                  spacing: 4,
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey,
                ),
              ),
            ],
          ),

          DraggableScrollableSheet(
            controller: _draggableController,
            initialChildSize: 0.42,
            minChildSize: 0.42,
            maxChildSize: 0.65,
            builder: (context, scrollController) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: ProductInfoSection(
                        sizes: sizes,
                        colors: colors,
                        selectedSize: _selectedSize,
                        selectedColor: _selectedColor,
                        onSizeSelected:
                            (size) => setState(() => _selectedSize = size),
                        onColorSelected:
                            (color) => setState(() => _selectedColor = color),
                        shortDescription: '',
                        fullDescription: widget.product.description,
                        title: widget.product.title,
                        price: widget.product.price.toString(),
                        lapel: widget.product.lapel ?? '',
                      ),
                    ),
                  ),

                  Positioned(
                    top: -6,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _togglePanel,
                        child: Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            size: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Row(
            children: [
              Expanded(
                child: AddToCartButton(
                  product: widget.product,
                  isEnabled: _selectedColor != null && _selectedSize != null,
                ),
              ),

              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  context.read<HomeCubit>().toggleFavorite(widget.product);
                },
                icon: Builder(
                  builder: (context) {
                    bool isFav = context.watch<HomeCubit>().isFavorite(
                      widget.product,
                    );
                    return Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.black,
                      size: 28,
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  Share.share(
                    'شوف المنتج ده: ${widget.product.title} - السعر: ${widget.product.price} EGP',
                    subject: 'منتج جديد!',
                  );
                },
                icon: const Icon(Icons.share, color: Colors.black, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
