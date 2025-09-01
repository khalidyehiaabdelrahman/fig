import 'dart:async';
import 'package:fig/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:fig/features/categories/presentation/cubit/categories_state.dart';
import 'package:fig/features/product/presentation/cubit/products_cubit.dart';
import 'package:fig/features/product/presentation/cubit/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/home/widgets/category_list_widget.dart';
import 'package:fig/features/home/widgets/product_list_widget.dart';
import 'package:fig/core/widgets/shimmer_skeletons.dart';
import 'package:fig/features/home/widgets/carousel_widget.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesCubit>(
          create: (_) => CategoriesCubit()..fetchCategories(),
        ),

        BlocProvider<ProductsCubit>(
          create: (_) => ProductsCubit()..fetchProducts(),
        ),
      ],
      child: SafeArea(
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

                Stack(
                  children: [
                    CarouselWidget(
                      pageController: _pageController,
                      images: carouselImages,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (i) => setState(() => _currentPage = i),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: CarouselIndicator(
                        itemCount: carouselImages.length,
                        currentPage: _currentPage,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return const CategoryRowShimmer();
                    } else if (state is CategoriesError) {
                      return Center(child: Text(state.error));
                    } else if (state is CategoriesLoaded) {
                      return CategoryListWidget(categories: state.categories);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),

                const SizedBox(height: 16),

                BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductsLoading) {
                      return const CategoryRowShimmer();
                    } else if (state is ProductsError) {
                      return Center(child: Text(state.error));
                    } else if (state is ProductsLoaded) {
                      return ProductListWidget(products: state.products);
                    } else if (state is ProductsFiltered) {
                      return ProductListWidget(
                        products: state.filteredProducts,
                      );
                    } else {
                      return const SizedBox.shrink();
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
      ),
    );
  }
}
