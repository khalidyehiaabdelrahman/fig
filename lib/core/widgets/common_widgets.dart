import 'package:flutter/material.dart';
import 'package:fig/core/utils/responsive.dart';

Widget alignedText({
  required String text,
  TextStyle? style,
  Alignment? alignment,
  EdgeInsetsGeometry? padding,
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
          padding: padding ?? EdgeInsets.symmetric(horizontal: 8.rw(context)),
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
  double? height,
  double? thickness,
  Color color = Colors.black,
}) {
  return Builder(
    builder: (context) {
      return Divider(
        height: height ?? 3.rh(context),
        thickness: thickness ?? 0.5.rw(context),
        color: color,
      );
    },
  );
}
