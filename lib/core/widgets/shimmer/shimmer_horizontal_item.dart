import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHorizontalItem extends StatelessWidget {
  const ShimmerHorizontalItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Container(height: 12, width: 80, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
