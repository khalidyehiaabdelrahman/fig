import 'package:fig/features/home/domain/category_model.dart';
import 'package:fig/features/home/presentation/cubit/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  List<ProductModel> _allProducts = [];

  Future<void> fetchProducts() async {
    emit(ProductsLoading());
    await Future.delayed(const Duration(seconds: 2)); // simulate API delay

    try {
      _allProducts = [
        ProductModel(
          id: '1',
          categoryId: '1',
          title: 'Slim Blazer',
          imageUrls: ['assets/images/1.jpg', 'assets/images/2.jpg'],
          description: 'Elegant navy blue slim blazer.',
          price: 1200.0,
        ),
        ProductModel(
          id: '2',
          categoryId: '1',
          title: 'White Shirt',
          imageUrls: ['assets/images/1.jpg', 'assets/images/2.jpg'],
          description: 'Classic white formal shirt.',
          price: 450.0,
        ),
        ProductModel(
          id: '3',
          categoryId: '1',
          title: 'Black Trousers',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Comfortable black trousers.',
          price: 700.0,
        ),
        ProductModel(
          id: '4',
          categoryId: '1',
          title: 'Leather Jacket',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Stylish black leather jacket.',
          price: 1500.0,
        ),
        ProductModel(
          id: '5',
          categoryId: '1',
          title: 'Denim Jeans',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Regular fit denim jeans.',
          price: 650.0,
        ),
        ProductModel(
          id: '6',
          categoryId: '2',
          title: 'Red Dress',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Beautiful red evening dress.',
          price: 1300.0,
        ),
        ProductModel(
          id: '7',
          categoryId: '2',
          title: 'Summer Skirt',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Light floral summer skirt.',
          price: 600.0,
        ),
        ProductModel(
          id: '8',
          categoryId: '2',
          title: 'Blue Blouse',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Elegant sky blue blouse.',
          price: 550.0,
        ),
        ProductModel(
          id: '9',
          categoryId: '2',
          title: 'Black Heels',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Stylish high heel shoes.',
          price: 800.0,
        ),
        ProductModel(
          id: '10',
          categoryId: '2',
          title: 'Handbag',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Leather brown handbag.',
          price: 950.0,
        ),
        ProductModel(
          id: '11',
          categoryId: '3',
          title: 'Kids T-shirt',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Colorful cartoon kids t-shirt.',
          price: 300.0,
        ),
        ProductModel(
          id: '12',
          categoryId: '3',
          title: 'Shorts',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Comfortable kids shorts.',
          price: 250.0,
        ),
        ProductModel(
          id: '13',
          categoryId: '3',
          title: 'Cap',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Cute kids cap with logo.',
          price: 150.0,
        ),
        ProductModel(
          id: '14',
          categoryId: '3',
          title: 'Sneakers',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Lightweight kids sneakers.',
          price: 400.0,
        ),
        ProductModel(
          id: '15',
          categoryId: '3',
          title: 'Raincoat',
          imageUrls: ['assets/images/appIcon/fig.png'],
          description: 'Waterproof kids raincoat.',
          price: 500.0,
        ),
      ];

      emit(
        ProductsLoaded(
          allProducts: _allProducts,
          filteredProducts: _allProducts,
        ),
      );
    } catch (e) {
      emit(ProductsError("فشل تحميل المنتجات"));
    }
  }

  void filterProductsByCategory(String categoryId) {
    if (state is ProductsLoaded) {
      final allProducts = (state as ProductsLoaded).allProducts;
      final filtered =
          allProducts
              .where((product) => product.categoryId == categoryId)
              .toList();
      emit(
        ProductsLoaded(allProducts: allProducts, filteredProducts: filtered),
      );
    }
  }

  void showAllProducts() {
    if (state is ProductsLoaded) {
      final allProducts = (state as ProductsLoaded).allProducts;
      emit(
        ProductsLoaded(allProducts: allProducts, filteredProducts: allProducts),
      );
    }
  }
}
