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
