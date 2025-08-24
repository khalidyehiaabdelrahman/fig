import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget alignedText({
  required String text,
  TextStyle? style,
  Alignment? alignment,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 8),
  TextDirection? textDirection,
  bool isBold = false,
}) {
  return Builder(
    builder: (context) {
      final isRtl = Directionality.of(context) == TextDirection.rtl;
      return Align(
        alignment:
            alignment ?? (isRtl ? Alignment.centerRight : Alignment.centerLeft),
        child: Padding(
          padding: padding,
          child: Text(
            text,
            textDirection: textDirection ?? Directionality.of(context),
            style: (style ?? const TextStyle()).copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    },
  );
}

Widget buildReusableDivider({
  double height = 3,
  double thickness = 0.5,
  Color color = Colors.black,
}) {
  return Divider(height: height, thickness: thickness, color: color);
}

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final Widget? spinner;

  const LoadingIndicator({
    Key? key,
    this.size = 60.0,
    this.color = Colors.white,
    this.spinner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitSpinningLines(size: size, color: color));
  }
}
