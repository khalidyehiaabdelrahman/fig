import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  final PageController pageController;
  final List<String> images;
  final Axis scrollDirection;
  final double height;
  final double borderRadius;
  final bool showBorderRadius;
  final Function(int)? onPageChanged;

  const CarouselWidget({
    super.key,
    required this.pageController,
    required this.images,
    this.scrollDirection = Axis.horizontal,
    this.height = 200,
    this.borderRadius = 12,
    this.showBorderRadius = true,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: PageView.builder(
        controller: pageController,
        scrollDirection: scrollDirection,
        itemCount: images.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          final image = Image.asset(
            images[index],
            fit: BoxFit.cover,
            width: double.infinity,
          );

          return showBorderRadius
              ? ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: image,
              )
              : image;
        },
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  final int itemCount;
  final int currentPage;
  final Axis direction; // horizontal أو vertical
  final Alignment alignment; // مكان المؤشر
  final Color activeColor;
  final Color inactiveColor;
  final double size; // حجم المؤشر
  final double spacing; // المسافة بين المؤشرات

  const CarouselIndicator({
    super.key,
    required this.itemCount,
    required this.currentPage,
    this.direction = Axis.horizontal,
    this.alignment = Alignment.bottomCenter,
    this.activeColor = Colors.red,
    this.inactiveColor = const Color(0xFFFF8A80),
    this.size = 12,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    final indicators = List.generate(
      itemCount,
      (index) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin:
            direction == Axis.horizontal
                ? EdgeInsets.symmetric(horizontal: spacing)
                : EdgeInsets.symmetric(vertical: spacing),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: currentPage == index ? activeColor : inactiveColor,
          borderRadius: BorderRadius.circular(size / 2),
        ),
      ),
    );

    return Align(
      alignment: alignment,
      child:
          direction == Axis.horizontal
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators,
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators,
              ),
    );
  }
}
