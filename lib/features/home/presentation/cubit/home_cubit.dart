import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  bool isGrid = true;
  bool forceShowShimmer = false;

  final List<String> allItems = List.generate(15, (i) => 'assets/images/1.jpg');

  List<String> items = [];
  int page = 1;
  final int limit = 5;
  bool isLoading = false;
  bool hasMore = true;

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

  Future<void> initHome() async {
    await loadPreferences();
    fetchItems();
  }

  Future<void> fetchItems() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    emit(PaginationLoaded(items: items, hasMore: hasMore, isLoading: true));

    await Future.delayed(const Duration(milliseconds: 500));

    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= allItems.length) {
      hasMore = false;
      isLoading = false;
      emit(
        PaginationLoaded(
          items: items,
          hasMore: hasMore,
          isLoading: false,
          message: 'No more data',
        ),
      );
      return;
    } else {
      final newItems = allItems.sublist(
        startIndex,
        endIndex > allItems.length ? allItems.length : endIndex,
      );
      items.addAll(newItems);
      page++;
    }

    isLoading = false;
    emit(PaginationLoaded(items: items, hasMore: hasMore, isLoading: false));
  }
}
