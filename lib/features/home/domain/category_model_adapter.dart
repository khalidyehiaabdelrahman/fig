import 'package:fig/features/home/domain/category_model.dart';
import 'package:hive_flutter/adapters.dart';

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 0;

  @override
  CategoryModel read(BinaryReader reader) {
    return CategoryModel(
      id: reader.readString(),
      name: reader.readString(),
      imageUrl: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.imageUrl);
  }
}

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    return ProductModel(
      id: reader.readString(),
      categoryId: reader.readString(),
      title: reader.readString(),
      imageUrls: reader.readList().cast<String>(),
      description: reader.readString(),
      price: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.categoryId);
    writer.writeString(obj.title);
    writer.writeList(obj.imageUrls);
    writer.writeString(obj.description);
    writer.writeDouble(obj.price);
  }
}

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 2;

  @override
  CartItem read(BinaryReader reader) {
    return CartItem(
      id: reader.readString(),
      product: reader.read() as ProductModel,
      quantity: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    writer.writeString(obj.id);
    writer.write(obj.product);
    writer.writeInt(obj.quantity);
  }
}

class FavoritesAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 3;

  @override
  ProductModel read(BinaryReader reader) {
    return ProductModel(
      id: reader.readString(),
      categoryId: reader.readString(),
      title: reader.readString(),
      imageUrls: reader.readList().cast<String>(),
      description: reader.readString(),
      price: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.categoryId);
    writer.writeString(obj.title);
    writer.writeList(obj.imageUrls);
    writer.writeString(obj.description);
    writer.writeDouble(obj.price);
  }
}

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(FavoritesAdapter());

  await Hive.openBox<CategoryModel>('categories');
  await Hive.openBox<ProductModel>('products');
  await Hive.openBox<CartItem>('cart');
  await Hive.openBox<ProductModel>('favorites');
}
