import 'package:flutter/material.dart';








const double _referenceWidth = 384.0;
const double _referenceHeight = 784.0;


double responsiveWidth(BuildContext context, double value) {
  final screenWidth = MediaQuery.of(context).size.width;
  return (value / _referenceWidth) * screenWidth;
}


double responsiveHeight(BuildContext context, double value) {
  final screenHeight = MediaQuery.of(context).size.height;
  return (value / _referenceHeight) * screenHeight;
}


double responsiveText(BuildContext context, double value) {
  final screenWidth = MediaQuery.of(context).size.width;
  return (value / _referenceWidth) * screenWidth;
}


double responsiveRadius(BuildContext context, double value) {
  final screenWidth = MediaQuery.of(context).size.width;
  return (value / _referenceWidth) * screenWidth;
}


extension ResponsiveExtensions on num {
  double rw(BuildContext context) => responsiveWidth(context, toDouble());
  double rh(BuildContext context) => responsiveHeight(context, toDouble());
  double rt(BuildContext context) => responsiveText(context, toDouble());
  double rr(BuildContext context) => responsiveRadius(context, toDouble());
}
