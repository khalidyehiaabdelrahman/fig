import 'package:flutter/material.dart';
import 'package:fig/features/home/widgets/carousel_widget.dart';
import 'package:fig/core/utils/responsive.dart';

class CarouselSection extends StatelessWidget {
  final List<String> images;
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const CarouselSection({
    super.key,
    required this.images,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselWidget(
          pageController: pageController,
          images: images,
          onPageChanged: onPageChanged,
        ),
        Positioned(
          bottom: 8.rh(context),
          left: 0,
          right: 0,
          child: CarouselIndicator(
            itemCount: images.length,
            currentPage: currentPage,
          ),
        ),
      ],
    );
  }
}
