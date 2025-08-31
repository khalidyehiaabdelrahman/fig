import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  bool isGrid = true;
  bool forceShowShimmer = false;

  HomeCubit() : super(HomeInitial());

  void toggleGrid() async {
    isGrid = !isGrid;
    emit(GridChanged(isGrid));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGrid', isGrid);
  }

  void setShimmer(bool value) {
    forceShowShimmer = value;
    emit(ShimmerChanged(forceShowShimmer));
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    isGrid = prefs.getBool('isGrid') ?? true;

    emit(GridChanged(isGrid));
  }
}
