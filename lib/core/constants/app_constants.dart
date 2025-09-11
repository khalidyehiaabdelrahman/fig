class AppConstants {
  static const String categoriesBoxName = 'categories';
  static const String productsBoxName = 'products';
  static const String cartBoxName = 'cart';
  static const String favoritesBoxName = 'favorites';

  static const int defaultPageSize = 10;
  static const int categoriesPageSize = 5;
  static const int productsPageSize = 10;
  static const int cartPageSize = 6;
  static const int favoritesPageSize = 8;
  static const int searchPageSize = 12;

  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 8.0;
  static const double largeBorderRadius = 16.0;

  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  static const int minTitleLength = 3;
  static const int maxTitleLength = 100;
  static const int minDescriptionLength = 10;
  static const int maxDescriptionLength = 500;
  static const double minPrice = 0.01;
  static const double maxPrice = 999999.99;

  
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;

  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 1000;

  static const String networkErrorMessage = 'Network error occurred';
  static const String databaseErrorMessage = 'Database error occurred';
  static const String validationErrorMessage = 'Validation error occurred';
  static const String notFoundErrorMessage = 'Item not found';
  static const String unauthorizedErrorMessage = 'Unauthorized access';
  static const String serverErrorMessage = 'Server error occurred';
}
