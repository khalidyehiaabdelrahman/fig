import 'dart:async';
import 'package:fig/features/home/domain/category_model.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:fig/features/home/presentation/pages/Category_Products_Page_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  Timer? _textTimer;

  final List<String> carouselImages = [
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
  ];

  final List<String> introTexts = [
    'Start your journey with us now!',
    'How Can I Help You?',
    'hey,👋',
  ];

  int _currentTextIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    _textTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentTextIndex = (_currentTextIndex + 1) % introTexts.length;
      });
    });

    // تحميل البيانات
    context.read<HomeCubit>().fetchCategories();
    context.read<HomeCubit>().fetchProducts();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentPage + 1;
        if (nextPage >= carouselImages.length) {
          _pageController.jumpToPage(0);
          nextPage = 0;
        } else {
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
        setState(() {
          _currentPage = nextPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _textTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  transitionBuilder:
                      (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                  child: Text(
                    introTexts[_currentTextIndex],
                    key: ValueKey(_currentTextIndex),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: 'Search Product',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Carousel
              _buildCarousel(),

              const SizedBox(height: 16),

              // ✅ Categories from Cubit
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  // && state.categories.isEmpty
                  if (state.isLoading) {
                    return _buildCategoryShimmer(); // أو shimmer بناءً على الحالة
                  } else if (state.errorMessage != null) {
                    return Center(child: Text(state.errorMessage!));
                  } else {
                    final categories = state.categories;
                    return _buildCategoryList(categories);
                  }
                },
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  //&& state.filteredProducts.isEmpty
                  if (state.isLoading) {
                    return _buildProductShimmer();
                  } else if (state.errorMessage != null) {
                    return Center(child: Text(state.errorMessage!));
                  } else {
                    final filteredProducts = state.filteredProducts;
                    return _buildProductList(filteredProducts);
                  }
                },
              ),

              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(16, (index) {
                  return Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.transparent,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/1.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Stack(
        children: [
          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: _pageController,
              itemCount: carouselImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    carouselImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                carouselImages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index
                            ? Colors.red[600]
                            : Colors.red[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(List<CategoryModel> categories) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CategoryProductsScreen(category: category),
                ),
              );
            },
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    category.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                Text(category.name, style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductList(List<ProductModel> products) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          return Column(
            children: [
              ClipOval(
                child: Image.asset(
                  product.imageUrls[0],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 6),
              Text(product.title, style: const TextStyle(fontSize: 12)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryShimmer() {
    return SizedBox(
      height: 100,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 60,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductShimmer() {
    return SizedBox(
      height: 100,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 60,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
