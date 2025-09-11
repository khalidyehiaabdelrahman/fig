import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_selection_state.dart';

class ProductSelectionCubit extends Cubit<ProductSelectionState> {
  ProductSelectionCubit() : super(const ProductSelectionState());

  void selectColor(String color) {
    emit(
      ProductSelectionState(
        selectedColor: color,
        selectedSize: state.selectedSize,
      ),
    );
  }

  void selectSize(int size) {
    emit(
      ProductSelectionState(
        selectedColor: state.selectedColor,
        selectedSize: size,
      ),
    );
  }

  void clearSelection() {
    emit(const ProductSelectionState());
  }
}
