import 'dart:async';
import 'package:fig/core/widgets/shimmer_skeletons.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:fig/features/home/widgets/carousel_widget.dart';
import 'package:fig/features/home/widgets/category_list_widget.dart';
import 'package:fig/features/home/widgets/product_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

              CarouselWidget(
                pageController: _pageController,
                images: carouselImages,
                currentPage: _currentPage,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),

              const SizedBox(height: 16),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  // && state.categories.isEmpty
                  if (state.isLoadingCategories) {
                    return const CategoryRowShimmer();
                  } else if (state.categoriesError != null) {
                    return Center(child: Text(state.categoriesError!));
                  } else {
                    return CategoryListWidget(categories: state.categories);
                  }
                },
              ),
              const SizedBox(height: 16),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  //&& state.filteredProducts.isEmpty
                  if (state.isLoadingProducts) {
                    return const CategoryRowShimmer();
                  } else if (state.productsError != null) {
                    return Center(child: Text(state.productsError!));
                  } else {
                    return ProductListWidget(products: state.filteredProducts);
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
}
