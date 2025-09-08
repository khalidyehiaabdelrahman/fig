import 'package:flutter/material.dart';

class IntroTextWidget extends StatelessWidget {
  final List<String> texts;
  final int currentIndex;

  const IntroTextWidget({
    super.key,
    required this.texts,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder:
            (child, animation) =>
                FadeTransition(opacity: animation, child: child),
        child: Text(
          texts[currentIndex],
          key: ValueKey(currentIndex),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
