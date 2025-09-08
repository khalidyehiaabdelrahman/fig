abstract class HomeState {}

class HomeInitial extends HomeState {}

class GridChanged extends HomeState {
  final bool isGrid;
  GridChanged(this.isGrid);
}

class ShimmerChanged extends HomeState {
  final bool forceShowShimmer;
  ShimmerChanged(this.forceShowShimmer);
}

class PaginationLoaded extends HomeState {
  final List<String> items;
  final bool hasMore;
  final bool isLoading;
  final String? message;

  PaginationLoaded({
    required this.items,
    required this.hasMore,
    required this.isLoading,
    this.message,
  });
}
