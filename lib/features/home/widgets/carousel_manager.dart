import 'dart:async';
import 'package:flutter/material.dart';

class CarouselManager {
  final PageController pageController;
  final List<String> images;
  int currentPage = 0;
  Timer? _timer;

  CarouselManager({required this.pageController, required this.images});

  void start(void Function(int) onPageChanged) {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (pageController.hasClients) {
        final nextPage = (currentPage + 1) % images.length;
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        currentPage = nextPage;
        onPageChanged(nextPage);
      }
    });
  }

  void dispose() => _timer?.cancel();
}
