import 'package:flutter/material.dart';
import 'package:fig/core/utils/responsive.dart';

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
          style: TextStyle(
            fontSize: 16.rt(context),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
