import 'package:fig/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Color _baseColor(BuildContext c) => Colors.grey.shade300;
Color _highlightColor(BuildContext c) => Colors.grey.shade100;
const _period = Duration(milliseconds: 1200);

class AppShimmer extends StatelessWidget {
  final Widget child;

  const AppShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _baseColor(context),
      highlightColor: _highlightColor(context),
      period: _period,
      child: child,
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const _ShimmerBox({
    required this.height,
    required this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
    );
  }
}

class CategoryRowShimmer extends StatelessWidget {
  final int itemCount;
  final double itemSize;
  const CategoryRowShimmer({super.key, this.itemCount = 8, this.itemSize = 50});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SizedBox(
        height: (itemSize + 33).rh(context),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 12.rw(context)),
          itemCount: itemCount,
          separatorBuilder: (_, __) => SizedBox(width: 15.rw(context)),
          itemBuilder:
              (_, __) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ShimmerBox(
                    height: (itemSize + 10).rh(context),
                    width: itemSize.rw(context),
                    borderRadius: BorderRadius.circular(10.rr(context)),
                  ),
                  SizedBox(height: 8.rh(context)),
                  _ShimmerBox(
                    height: 13.rh(context),
                    width: (itemSize * 1.4).rw(context),
                    borderRadius: BorderRadius.circular(6.rr(context)),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

class ProductGridShimmer extends StatelessWidget {
  final int itemCount;
  const ProductGridShimmer({super.key, this.itemCount = 14});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = 8.rw(context) * 2;
    final spacing = 8.rw(context);
    final columnWidth = (screenWidth - padding - spacing) / 2;

    final cardHeight =
        190.rh(context) +
        10.rh(context) +
        18.rh(context) +
        10.rh(context) +
        16.rh(context);
    final childAspectRatio = columnWidth / cardHeight;

    return AppShimmer(
      child: GridView.builder(
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.rw(context),
          mainAxisSpacing: 15.rh(context),
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder:
            (_, __) => Card(
              elevation: 0,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.rr(context)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerBox(
                    height: 190.rh(context),
                    width: double.infinity,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.rr(context)),
                    ),
                  ),
                  SizedBox(height: 10.rh(context)),
                  _ShimmerBox(
                    height: 18.rh(context),
                    width: 100.rw(context),
                    borderRadius: BorderRadius.zero,
                  ),
                  SizedBox(height: 10.rh(context)),
                  _ShimmerBox(
                    height: 16.rh(context),
                    width: 80.rw(context),
                    borderRadius: BorderRadius.zero,
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

class ProductListShimmer extends StatelessWidget {
  final int itemCount;
  const ProductListShimmer({super.key, this.itemCount = 10});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.separated(
        padding: EdgeInsets.all(6.rw(context)),
        itemCount: itemCount,
        separatorBuilder: (_, __) => SizedBox(height: 12.rh(context)),
        itemBuilder:
            (_, __) => Card(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(
                horizontal: 6.rw(context),
                vertical: 6.rh(context),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.rr(context)),
              ),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(8.rw(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ShimmerBox(
                      height: 180.rh(context),
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(12.rr(context)),
                    ),
                    SizedBox(height: 10.rh(context)),
                    _ShimmerBox(
                      height: 14.rh(context),
                      width: 200.rw(context),
                      borderRadius: BorderRadius.zero,
                    ),
                    SizedBox(height: 6.rh(context)),
                    _ShimmerBox(
                      height: 14.rh(context),
                      width: 120.rw(context),
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
