import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_selection_state.dart';

class ProductSelectionCubit extends Cubit<ProductSelectionState> {
  ProductSelectionCubit() : super(const ProductSelectionState());

  void selectColor(String color) {
    emit(state.copyWith(selectedColor: color));
  }

  void selectSize(int size) {
    emit(state.copyWith(selectedSize: size));
  }

  void clearSelection() {
    emit(const ProductSelectionState());
  }
}
