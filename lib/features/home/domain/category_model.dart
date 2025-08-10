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

  const ProductModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.imageUrls,
    required this.description,
    required this.price,
  });
}
