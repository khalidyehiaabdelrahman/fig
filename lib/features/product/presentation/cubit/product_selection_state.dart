import 'package:equatable/equatable.dart';

class ProductSelectionState extends Equatable {
  final String? selectedColor;
  final int? selectedSize;

  const ProductSelectionState({this.selectedColor, this.selectedSize});

  @override
  List<Object?> get props => [selectedColor, selectedSize];
}
