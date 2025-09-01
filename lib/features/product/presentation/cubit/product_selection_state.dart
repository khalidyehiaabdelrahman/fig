import 'package:equatable/equatable.dart';

class ProductSelectionState extends Equatable {
  final String? selectedColor;
  final int? selectedSize;

  const ProductSelectionState({this.selectedColor, this.selectedSize});

  ProductSelectionState copyWith({String? selectedColor, int? selectedSize}) {
    return ProductSelectionState(
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }

  @override
  List<Object?> get props => [selectedColor, selectedSize];
}
