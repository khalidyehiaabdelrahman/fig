import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/home/domain/category_model.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  // ===== Fetch Categories =====
  Future<void> fetchCategories() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await Future.delayed(const Duration(seconds: 2));

    try {
      final categories = [
        CategoryModel(
          id: '1',
          name: 'Blazers',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '2',
          name: 'Blouses',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '3',
          name: 'Bodysuits',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '4',
          name: 'Cardigan',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '5',
          name: 'Cargo pants',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '6',
          name: 'Shirts',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
        CategoryModel(
          id: '7',
          name: 'Pants',
          imageUrl: 'assets/images/appIcon/fig.png',
        ),
      ];
      emit(state.copyWith(isLoading: false, categories: categories));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'فشل تحميل الأقسام'));
    }
  }

  // ===== Select Category =====
  void selectCategory(String categoryId) {
    emit(state.copyWith(selectedCategoryId: categoryId));
    filterProductsByCategory(categoryId);
  }

  // ===== Fetch Products =====
  Future<void> fetchProducts() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await Future.delayed(const Duration(seconds: 2));

    try {
      final products = [
        // Category 1: Blazers
        ProductModel(
          id: '34',
          categoryId: '1',
          title: 'Denim Shirt',
          imageUrls: [
            'assets/images/18.jpg',
            'assets/images/19.jpg',
            'assets/images/20.jpg',
            'assets/images/21.jpg',
            'assets/images/22.jpg',
          ],
          description: 'Rugged denim look.',
          price: 500.0,
        ),
        ProductModel(
          id: '35',
          categoryId: '1',
          title: 'Linen Shirt',
          imageUrls: [
            'assets/images/23.jpg',
            'assets/images/24.jpg',
            'assets/images/25.jpg',
            'assets/images/26.jpg',
            'assets/images/27.jpg',
          ],
          description: 'Light linen fabric.',
          price: 460.0,
        ),
        ProductModel(
          id: '36',
          categoryId: '1',
          title: 'Striped Shirt',
          imageUrls: [
            'assets/images/28.jpg',
            'assets/images/29.jpg',
            'assets/images/30.jpg',
            'assets/images/31.jpg',
            'assets/images/1.jpg',
          ],
          description: 'Modern striped look.',
          price: 470.0,
        ),

        ProductModel(
          id: '1',
          categoryId: '1',
          title: 'Slim Blazer',
          imageUrls: [
            'assets/images/8.jpg',
            'assets/images/9.jpg',
            'assets/images/10.jpg',
            'assets/images/11.jpg',
            'assets/images/12.jpg',
          ],
          description: 'Elegant navy blue slim blazer.',
          price: 1200.0,
        ),
        ProductModel(
          id: '2',
          categoryId: '1',
          title: 'Classic Black Blazer',
          imageUrls: [
            'assets/images/13.jpg',
            'assets/images/14.jpg',
            'assets/images/15.jpg',
            'assets/images/16.jpg',
            'assets/images/17.jpg',
          ],
          description: 'Timeless black blazer.',
          price: 1300.0,
        ),
        ProductModel(
          id: '3',
          categoryId: '1',
          title: 'Grey Blazer',
          imageUrls: [
            'assets/images/18.jpg',
            'assets/images/19.jpg',
            'assets/images/20.jpg',
            'assets/images/21.jpg',
            'assets/images/22.jpg',
          ],
          description: 'Modern grey blazer.',
          price: 1100.0,
        ),
        ProductModel(
          id: '4',
          categoryId: '1',
          title: 'Checked Blazer',
          imageUrls: [
            'assets/images/23.jpg',
            'assets/images/24.jpg',
            'assets/images/25.jpg',
            'assets/images/26.jpg',
            'assets/images/27.jpg',
          ],
          description: 'Stylish checked pattern.',
          price: 1250.0,
        ),
        ProductModel(
          id: '5',
          categoryId: '1',
          title: 'Double-breasted Blazer',
          imageUrls: [
            'assets/images/28.jpg',
            'assets/images/29.jpg',
            'assets/images/30.jpg',
            'assets/images/31.jpg',
            'assets/images/1.jpg',
          ],
          description: 'Elegant double-breasted.',
          price: 1400.0,
        ),
        ProductModel(
          id: '6',
          categoryId: '1',
          title: 'Linen Blazer',
          imageUrls: [
            'assets/images/2.jpg',
            'assets/images/3.jpg',
            'assets/images/4.jpg',
            'assets/images/5.jpg',
            'assets/images/6.jpg',
          ],
          description: 'Lightweight linen fabric.',
          price: 1150.0,
        ),

        // Category 2: Blouses
        ProductModel(
          id: '7',
          categoryId: '2',
          title: 'Silk Blouse',
          imageUrls: [
            'assets/images/7.jpg',
            'assets/images/8.jpg',
            'assets/images/9.jpg',
            'assets/images/10.jpg',
            'assets/images/11.jpg',
          ],
          description: 'Soft pink silk blouse.',
          price: 700.0,
        ),
        ProductModel(
          id: '8',
          categoryId: '2',
          title: 'Floral Blouse',
          imageUrls: [
            'assets/images/12.jpg',
            'assets/images/13.jpg',
            'assets/images/14.jpg',
            'assets/images/15.jpg',
            'assets/images/16.jpg',
          ],
          description: 'Bright floral print blouse.',
          price: 650.0,
        ),
        ProductModel(
          id: '9',
          categoryId: '2',
          title: 'Sleeveless Blouse',
          imageUrls: [
            'assets/images/17.jpg',
            'assets/images/18.jpg',
            'assets/images/19.jpg',
            'assets/images/20.jpg',
            'assets/images/21.jpg',
          ],
          description: 'Light summer style.',
          price: 550.0,
        ),
        ProductModel(
          id: '10',
          categoryId: '2',
          title: 'Ruffled Blouse',
          imageUrls: [
            'assets/images/22.jpg',
            'assets/images/23.jpg',
            'assets/images/24.jpg',
            'assets/images/25.jpg',
            'assets/images/26.jpg',
          ],
          description: 'Elegant ruffles design.',
          price: 750.0,
        ),
        ProductModel(
          id: '11',
          categoryId: '2',
          title: 'Buttoned Blouse',
          imageUrls: [
            'assets/images/27.jpg',
            'assets/images/28.jpg',
            'assets/images/29.jpg',
            'assets/images/30.jpg',
            'assets/images/31.jpg',
          ],
          description: 'Casual buttoned blouse.',
          price: 600.0,
        ),
        ProductModel(
          id: '12',
          categoryId: '2',
          title: 'Chiffon Blouse',
          imageUrls: [
            'assets/images/1.jpg',
            'assets/images/2.jpg',
            'assets/images/3.jpg',
            'assets/images/4.jpg',
            'assets/images/5.jpg',
          ],
          description: 'Light chiffon fabric.',
          price: 680.0,
        ),

        // Category 3: Bodysuits
        ProductModel(
          id: '13',
          categoryId: '3',
          title: 'Black Bodysuit',
          imageUrls: [
            'assets/images/6.jpg',
            'assets/images/7.jpg',
            'assets/images/8.jpg',
            'assets/images/9.jpg',
            'assets/images/10.jpg',
          ],
          description: 'Comfortable black bodysuit.',
          price: 550.0,
        ),
        ProductModel(
          id: '14',
          categoryId: '3',
          title: 'White Bodysuit',
          imageUrls: [
            'assets/images/11.jpg',
            'assets/images/12.jpg',
            'assets/images/13.jpg',
            'assets/images/14.jpg',
            'assets/images/15.jpg',
          ],
          description: 'Elegant white bodysuit.',
          price: 580.0,
        ),
        ProductModel(
          id: '15',
          categoryId: '3',
          title: 'Lace Bodysuit',
          imageUrls: [
            'assets/images/16.jpg',
            'assets/images/17.jpg',
            'assets/images/18.jpg',
            'assets/images/19.jpg',
            'assets/images/20.jpg',
          ],
          description: 'Delicate lace design.',
          price: 620.0,
        ),
        ProductModel(
          id: '16',
          categoryId: '3',
          title: 'Long Sleeve Bodysuit',
          imageUrls: [
            'assets/images/21.jpg',
            'assets/images/22.jpg',
            'assets/images/23.jpg',
            'assets/images/24.jpg',
            'assets/images/25.jpg',
          ],
          description: 'Perfect for layering.',
          price: 600.0,
        ),
        ProductModel(
          id: '17',
          categoryId: '3',
          title: 'Tank Bodysuit',
          imageUrls: [
            'assets/images/26.jpg',
            'assets/images/27.jpg',
            'assets/images/28.jpg',
            'assets/images/29.jpg',
            'assets/images/30.jpg',
          ],
          description: 'Casual tank style.',
          price: 530.0,
        ),
        ProductModel(
          id: '18',
          categoryId: '3',
          title: 'Striped Bodysuit',
          imageUrls: [
            'assets/images/31.jpg',
            'assets/images/1.jpg',
            'assets/images/2.jpg',
            'assets/images/3.jpg',
            'assets/images/4.jpg',
          ],
          description: 'Modern striped look.',
          price: 590.0,
        ),

        // Category 4: Cardigan
        ProductModel(
          id: '19',
          categoryId: '4',
          title: 'Cozy Cardigan',
          imageUrls: [
            'assets/images/5.jpg',
            'assets/images/6.jpg',
            'assets/images/7.jpg',
            'assets/images/8.jpg',
            'assets/images/9.jpg',
          ],
          description: 'Warm beige cardigan.',
          price: 650.0,
        ),
        ProductModel(
          id: '20',
          categoryId: '4',
          title: 'Knitted Cardigan',
          imageUrls: [
            'assets/images/10.jpg',
            'assets/images/11.jpg',
            'assets/images/12.jpg',
            'assets/images/13.jpg',
            'assets/images/14.jpg',
          ],
          description: 'Soft knitted fabric.',
          price: 700.0,
        ),
        ProductModel(
          id: '21',
          categoryId: '4',
          title: 'Button Cardigan',
          imageUrls: [
            'assets/images/15.jpg',
            'assets/images/16.jpg',
            'assets/images/17.jpg',
            'assets/images/18.jpg',
            'assets/images/19.jpg',
          ],
          description: 'Classic button style.',
          price: 680.0,
        ),
        ProductModel(
          id: '22',
          categoryId: '4',
          title: 'Long Cardigan',
          imageUrls: [
            'assets/images/20.jpg',
            'assets/images/21.jpg',
            'assets/images/22.jpg',
            'assets/images/23.jpg',
            'assets/images/24.jpg',
          ],
          description: 'Elegant long design.',
          price: 720.0,
        ),
        ProductModel(
          id: '23',
          categoryId: '4',
          title: 'Chunky Cardigan',
          imageUrls: [
            'assets/images/25.jpg',
            'assets/images/26.jpg',
            'assets/images/27.jpg',
            'assets/images/28.jpg',
            'assets/images/29.jpg',
          ],
          description: 'Thick and warm.',
          price: 750.0,
        ),
        ProductModel(
          id: '24',
          categoryId: '4',
          title: 'Open Front Cardigan',
          imageUrls: [
            'assets/images/30.jpg',
            'assets/images/31.jpg',
            'assets/images/1.jpg',
            'assets/images/2.jpg',
            'assets/images/3.jpg',
          ],
          description: 'Casual open front.',
          price: 670.0,
        ),

        // Category 5: Cargo pants
        ProductModel(
          id: '25',
          categoryId: '5',
          title: 'Green Cargo Pants',
          imageUrls: [
            'assets/images/4.jpg',
            'assets/images/5.jpg',
            'assets/images/6.jpg',
            'assets/images/7.jpg',
            'assets/images/8.jpg',
          ],
          description: 'Durable green cargo pants.',
          price: 800.0,
        ),
        ProductModel(
          id: '26',
          categoryId: '5',
          title: 'Beige Cargo Pants',
          imageUrls: [
            'assets/images/9.jpg',
            'assets/images/10.jpg',
            'assets/images/11.jpg',
            'assets/images/12.jpg',
            'assets/images/13.jpg',
          ],
          description: 'Casual beige cargo.',
          price: 780.0,
        ),
        ProductModel(
          id: '27',
          categoryId: '5',
          title: 'Slim Cargo Pants',
          imageUrls: [
            'assets/images/14.jpg',
            'assets/images/15.jpg',
            'assets/images/16.jpg',
            'assets/images/17.jpg',
            'assets/images/18.jpg',
          ],
          description: 'Modern slim fit.',
          price: 820.0,
        ),
        ProductModel(
          id: '28',
          categoryId: '5',
          title: 'Camouflage Cargo Pants',
          imageUrls: [
            'assets/images/19.jpg',
            'assets/images/20.jpg',
            'assets/images/21.jpg',
            'assets/images/22.jpg',
            'assets/images/23.jpg',
          ],
          description: 'Stylish camo print.',
          price: 850.0,
        ),
        ProductModel(
          id: '29',
          categoryId: '5',
          title: 'Black Cargo Pants',
          imageUrls: [
            'assets/images/24.jpg',
            'assets/images/25.jpg',
            'assets/images/26.jpg',
            'assets/images/27.jpg',
            'assets/images/28.jpg',
          ],
          description: 'Classic black cargo.',
          price: 790.0,
        ),
        ProductModel(
          id: '30',
          categoryId: '5',
          title: 'Wide-leg Cargo Pants',
          imageUrls: [
            'assets/images/29.jpg',
            'assets/images/30.jpg',
            'assets/images/31.jpg',
            'assets/images/1.jpg',
            'assets/images/2.jpg',
          ],
          description: 'Comfortable wide-leg.',
          price: 810.0,
        ),

        // Category 6: Shirts
        ProductModel(
          id: '31',
          categoryId: '6',
          title: 'Formal White Shirt',
          imageUrls: [
            'assets/images/3.jpg',
            'assets/images/4.jpg',
            'assets/images/5.jpg',
            'assets/images/6.jpg',
            'assets/images/7.jpg',
          ],
          description: 'Classic white formal shirt.',
          price: 450.0,
        ),
        ProductModel(
          id: '32',
          categoryId: '6',
          title: 'Casual Shirt',
          imageUrls: [
            'assets/images/8.jpg',
            'assets/images/9.jpg',
            'assets/images/10.jpg',
            'assets/images/11.jpg',
            'assets/images/12.jpg',
          ],
          description: 'Comfortable casual style.',
          price: 430.0,
        ),
        ProductModel(
          id: '33',
          categoryId: '6',
          title: 'Checked Shirt',
          imageUrls: [
            'assets/images/13.jpg',
            'assets/images/14.jpg',
            'assets/images/15.jpg',
            'assets/images/16.jpg',
            'assets/images/17.jpg',
          ],
          description: 'Stylish checked pattern.',
          price: 480.0,
        ),
        ProductModel(
          id: '34',
          categoryId: '6',
          title: 'Denim Shirt',
          imageUrls: [
            'assets/images/18.jpg',
            'assets/images/19.jpg',
            'assets/images/20.jpg',
            'assets/images/21.jpg',
            'assets/images/22.jpg',
          ],
          description: 'Rugged denim look.',
          price: 500.0,
        ),
        ProductModel(
          id: '35',
          categoryId: '6',
          title: 'Linen Shirt',
          imageUrls: [
            'assets/images/23.jpg',
            'assets/images/24.jpg',
            'assets/images/25.jpg',
            'assets/images/26.jpg',
            'assets/images/27.jpg',
          ],
          description: 'Light linen fabric.',
          price: 460.0,
        ),
        ProductModel(
          id: '36',
          categoryId: '6',
          title: 'Striped Shirt',
          imageUrls: [
            'assets/images/28.jpg',
            'assets/images/29.jpg',
            'assets/images/30.jpg',
            'assets/images/31.jpg',
            'assets/images/1.jpg',
          ],
          description: 'Modern striped look.',
          price: 470.0,
        ),

        // Category 7: Jackets
        ProductModel(
          id: '37',
          categoryId: '7',
          title: 'Leather Jacket',
          imageUrls: [
            'assets/images/2.jpg',
            'assets/images/3.jpg',
            'assets/images/4.jpg',
            'assets/images/5.jpg',
            'assets/images/6.jpg',
          ],
          description: 'Classic leather jacket.',
          price: 1500.0,
        ),
        ProductModel(
          id: '38',
          categoryId: '7',
          title: 'Bomber Jacket',
          imageUrls: [
            'assets/images/7.jpg',
            'assets/images/8.jpg',
            'assets/images/9.jpg',
            'assets/images/10.jpg',
            'assets/images/11.jpg',
          ],
          description: 'Stylish bomber style.',
          price: 1400.0,
        ),
        ProductModel(
          id: '39',
          categoryId: '7',
          title: 'Denim Jacket',
          imageUrls: [
            'assets/images/12.jpg',
            'assets/images/13.jpg',
            'assets/images/14.jpg',
            'assets/images/15.jpg',
            'assets/images/16.jpg',
          ],
          description: 'Casual denim jacket.',
          price: 1350.0,
        ),
        ProductModel(
          id: '40',
          categoryId: '7',
          title: 'Hooded Jacket',
          imageUrls: [
            'assets/images/17.jpg',
            'assets/images/18.jpg',
            'assets/images/19.jpg',
            'assets/images/20.jpg',
            'assets/images/21.jpg',
          ],
          description: 'Casual hooded jacket.',
          price: 1300.0,
        ),
        ProductModel(
          id: '41',
          categoryId: '7',
          title: 'Puffer Jacket',
          imageUrls: [
            'assets/images/22.jpg',
            'assets/images/23.jpg',
            'assets/images/24.jpg',
            'assets/images/25.jpg',
            'assets/images/26.jpg',
          ],
          description: 'Warm and padded.',
          price: 1450.0,
        ),
        ProductModel(
          id: '42',
          categoryId: '7',
          title: 'Windbreaker Jacket',
          imageUrls: [
            'assets/images/27.jpg',
            'assets/images/28.jpg',
            'assets/images/29.jpg',
            'assets/images/30.jpg',
            'assets/images/31.jpg',
          ],
          description: 'Lightweight windbreaker.',
          price: 1250.0,
        ),
      ];

      emit(
        state.copyWith(
          isLoading: false,
          allProducts: products,
          filteredProducts: products,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: "فشل تحميل المنتجات"),
      );
    }
  }

  // ===== Filter Products =====
  void filterProductsByCategory(String categoryId) {
    final filtered =
        state.allProducts.where((p) => p.categoryId == categoryId).toList();
    emit(state.copyWith(filteredProducts: filtered));
  }

  void showAllProducts() {
    emit(
      state.copyWith(
        filteredProducts: state.allProducts,
        selectedCategoryId: null,
      ),
    );
  }

  // ===== Sort Products =====
  void sortProducts(String sortOption) {
    print('sorting with option: $sortOption');

    List<ProductModel> sorted = List.from(state.filteredProducts);
    print('قبل الترتيب: ${sorted.map((e) => e.price).toList()}');

    if (sortOption == 'Lowest Price') {
      sorted.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOption == 'Highest Price') {
      sorted.sort((a, b) => b.price.compareTo(a.price));
    } else {
      sorted = List.from(state.filteredProducts);
    }

    print('بعد الترتيب: ${sorted.map((e) => e.price).toList()}');

    emit(
      state.copyWith(filteredProducts: sorted, currentSortOption: sortOption),
    );
  }
}
