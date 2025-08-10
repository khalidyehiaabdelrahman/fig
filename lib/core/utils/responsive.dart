import 'package:flutter/material.dart';

/// 📱 Khalid Responsive Helper
/// للحفاظ على ثبات التصميم عبر جميع الشاشات.
///
/// المرجعية الحالية:
/// Width: 384
/// Height: 784

const double _referenceWidth = 384.0;
const double _referenceHeight = 784.0;

/// 📏 للحساب بناءً على عرض الشاشة
double responsiveWidth(BuildContext context, double value) {
  final screenWidth = MediaQuery.of(context).size.width;
  return (value / _referenceWidth) * screenWidth;
}

/// 📏 للحساب بناءً على ارتفاع الشاشة
double responsiveHeight(BuildContext context, double value) {
  final screenHeight = MediaQuery.of(context).size.height;
  return (value / _referenceHeight) * screenHeight;
}

/// 🔠 لحساب حجم الخط بشكل متوازن مع العرض
double responsiveText(BuildContext context, double value) {
  final screenWidth = MediaQuery.of(context).size.width;
  return (value / _referenceWidth) * screenWidth;
}

/// 🎨 لحساب BorderRadius متوازن مع العرض
double responsiveRadius(BuildContext context, double value) {
  final screenWidth = MediaQuery.of(context).size.width;
  return (value / _referenceWidth) * screenWidth;
}

/// 🪄 لتسهيل كتابة responsive بأسلوب مختصر
extension ResponsiveExtensions on num {
  double rw(BuildContext context) => responsiveWidth(context, toDouble());
  double rh(BuildContext context) => responsiveHeight(context, toDouble());
  double rt(BuildContext context) => responsiveText(context, toDouble());
  double rr(BuildContext context) => responsiveRadius(context, toDouble());
}
