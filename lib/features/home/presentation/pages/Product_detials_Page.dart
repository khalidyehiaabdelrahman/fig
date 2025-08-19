import 'package:fig/core/widgets/common_widgets.dart';
import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/widgets/add_to_cart_button.dart';
import 'package:fig/features/home/widgets/colors_selector.dart';
import 'package:fig/features/home/widgets/sizes_selector.dart';
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
              SizedBox(
                height: 400,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: widget.product.imageUrls.length,
                  onPageChanged:
                      (index) => setState(() => _selectedImage = index),
                  itemBuilder: (context, index) {
                    return Image.asset(
                      widget.product.imageUrls[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),

              Positioned(
                left:
                    Directionality.of(context) == TextDirection.rtl ? 8 : null,
                right:
                    Directionality.of(context) == TextDirection.ltr ? 8 : null,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.product.imageUrls.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      height: _selectedImage == index ? 12 : 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color:
                            _selectedImage == index ? Colors.red : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.product.title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '${widget.product.price} EGP',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          Text(
                            widget.product.lapel ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          buildReusableDivider(),
                          const SizedBox(height: 20),
                          SizesSelector(
                            sizes: sizes,
                            selectedSize: _selectedSize,
                            onSizeSelected: (size) {
                              setState(() => _selectedSize = size);
                            },
                          ),

                          const SizedBox(height: 20),
                          ColorsSelector(
                            colors: colors,
                            selectedColor: _selectedColor,
                            onColorSelected: (color) {
                              setState(() => _selectedColor = color);
                            },
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "Product Short Description",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),

                          const Text(
                            "Product Full Description",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.product.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ],
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
