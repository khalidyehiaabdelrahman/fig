class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

class ProductModel {
  final String id;
  final String categoryId;
  final String title;
  final List<String> imageUrls;
  final String description;
  final double price;
  final List<String> availableColors;
  final List<int> availableSizes;
  final String? lapel;

  const ProductModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.imageUrls,
    required this.description,
    required this.price,
    this.availableColors = const [],
    this.availableSizes = const [],
    this.lapel,
  });
}

class CartItem {
  final String id;
  final ProductModel product;
  final int quantity;
  final String? selectedColor;
  final int? selectedSize;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
  });

  CartItem copyWith({int? quantity, String? selectedColor, int? selectedSize}) {
    return CartItem(
      id: id,
      product: product,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }
}
