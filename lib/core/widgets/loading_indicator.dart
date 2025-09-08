import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final Widget? spinner;

  const LoadingIndicator({
    super.key,
    this.size = 60.0,
    this.color = Colors.white,
    this.spinner,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitSpinningLines(size: size, color: color));
  }
}
