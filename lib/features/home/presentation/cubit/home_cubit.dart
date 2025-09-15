import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:fig/core/services/preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final PreferencesService _preferencesService;

  bool isGrid = true;
  bool forceShowShimmer = false;

  final List<String> allItems = List.generate(15, (i) => 'assets/images/1.jpg');

  List<String> items = [];
  int page = 1;
  final int limit = 5;
  bool isLoading = false;
  bool hasMore = true;

  HomeCubit(this._preferencesService) : super(HomeInitial());

  void toggleGrid() async {
    isGrid = !isGrid;
    emit(GridChanged(isGrid));

    await _preferencesService.setIsGrid(isGrid);
  }

  void setShimmer(bool value) {
    forceShowShimmer = value;
    emit(ShimmerChanged(forceShowShimmer));
  }

  Future<void> loadPreferences() async {
    isGrid = await _preferencesService.getIsGrid();
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
