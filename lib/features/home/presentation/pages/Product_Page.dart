import 'package:fig/features/home/domain/model/category_model.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/widget/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product})
    : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

Color parseColor(String color) {
  switch (color.toLowerCase()) {
    case 'black':
      return Colors.black;
    case 'red':
      return Colors.red;
    case 'navy':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'beige':
      return Color(0xFFF5F5DC);
    case 'white':
      return Colors.white;
    case 'grey':
      return Colors.grey;
    default:
      return Colors.grey;
  }
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedImage = 0;
  String? _selectedColor;
  int? _selectedSize;

  late final List<String> colors;
  late final List<int> sizes;

  late Box<ProductModel> favoritesBox;
  @override
  void initState() {
    super.initState();
    colors = widget.product.availableColors;
    sizes = widget.product.availableSizes;
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = _selectedColor != null && _selectedSize != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 450,
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
                  // Indicators
                  Positioned(
                    left:
                        Directionality.of(context) == TextDirection.rtl
                            ? 8
                            : null,
                    right:
                        Directionality.of(context) == TextDirection.ltr
                            ? 8
                            : null,
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
                                _selectedImage == index
                                    ? Colors.red
                                    : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Colors
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Colors:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          colors.map((color) {
                            bool isSelected = _selectedColor == color;
                            return GestureDetector(
                              onTap:
                                  () => setState(() => _selectedColor = color),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: parseColor(color),
                                  shape: BoxShape.circle,
                                  border:
                                      isSelected
                                          ? Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          )
                                          : null,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sizes:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          sizes.map((size) {
                            bool isSelected = _selectedSize == size;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedSize = size),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? Colors.red
                                          : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  size.toString(),
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (isButtonEnabled) {
                            context.read<HomeCubit>().addToCart(widget.product);
                            TopSnackBar.show(
                              context,
                              message: 'Added to cart successfully!',
                              icon: Icons.check_circle_outline,
                            );
                          } else {
                            TopSnackBar.show(
                              context,
                              message: 'Please choose color and size first.',
                              icon: Icons.error_outline,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isButtonEnabled ? Colors.red : Colors.grey,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        context.read<HomeCubit>().toggleFavorite(
                          widget.product,
                        );
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
                      icon: const Icon(
                        Icons.share,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
