import 'package:fig/core/utils/top_snack_bar.dart';
import 'package:fig/features/home/widgets/carousel_manager.dart';
import 'package:fig/features/home/widgets/carousel_section.dart';
import 'package:fig/features/home/widgets/categories_section.dart';
import 'package:fig/features/home/widgets/intro_text_manager.dart';
import 'package:fig/features/home/widgets/intro_text_widget.dart';
import 'package:fig/features/home/widgets/pagination_items_widget.dart';
import 'package:fig/features/home/widgets/products_section.dart';
import 'package:fig/features/home/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/features/home/presentation/cubit/home_cubit.dart';
import 'package:fig/features/home/presentation/cubit/home_state.dart';
import 'package:fig/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:fig/features/product/presentation/cubit/products_cubit.dart';
import 'package:fig/core/di/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  late CarouselManager _carouselManager;
  late IntroTextManager _introTextManager;

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

  int _currentPage = 0;
  int _currentTextIndex = 0;

  @override
  void initState() {
    super.initState();

    _carouselManager = CarouselManager(
      pageController: _pageController,
      images: carouselImages,
    )..start((i) => setState(() => _currentPage = i));

    _introTextManager = IntroTextManager(texts: introTexts)
      ..start((i) => setState(() => _currentTextIndex = i));
  }

  @override
  void dispose() {
    _carouselManager.dispose();
    _introTextManager.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CategoriesCubit>()..fetchCategories(),
        ),
        BlocProvider(create: (_) => getIt<ProductsCubit>()..fetchProducts()),
        BlocProvider(create: (_) => getIt<HomeCubit>()..initHome()),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, homeState) {
              return NotificationListener<ScrollNotification>(
                onNotification:
                    (scrollInfo) => _handleScrollNotification(
                      context,
                      scrollInfo,
                      homeState,
                    ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  children: [
                    IntroTextWidget(
                      texts: introTexts,
                      currentIndex: _currentTextIndex,
                    ),
                    const SizedBox(height: 16),
                    const SearchBarWidget(),
                    const SizedBox(height: 10),
                    CarouselSection(
                      images: carouselImages,
                      pageController: _pageController,
                      currentPage: _currentPage,
                      onPageChanged: (i) => setState(() => _currentPage = i),
                    ),
                    const SizedBox(height: 16),
                    const CategoriesSection(),
                    const SizedBox(height: 10),
                    const ProductsSection(),
                    const SizedBox(height: 6),
                    if (homeState is PaginationLoaded)
                      PaginationItemsWidget(state: homeState),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool _handleScrollNotification(
    BuildContext context,
    ScrollNotification scrollInfo,
    HomeState homeState,
  ) {
    if (!_isUserVerticalScroll(scrollInfo)) return false;
    if (!_isAtScrollEnd(scrollInfo)) return false;

    _handlePagination(context, homeState);
    return false;
  }

  bool _isUserVerticalScroll(ScrollNotification scrollInfo) {
    return scrollInfo is UserScrollNotification &&
        scrollInfo.metrics.axis == Axis.vertical;
  }

  bool _isAtScrollEnd(ScrollNotification scrollInfo) {
    return scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        scrollInfo.metrics.maxScrollExtent > 0;
  }

  void _handlePagination(BuildContext context, HomeState state) {
    final homeCubit = context.read<HomeCubit>();

    if (state is PaginationLoaded && !state.isLoading) {
      if (state.hasMore) {
        homeCubit.fetchItems();
      } else if (state.message != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppMessages.showInfo(context, state.message!);
        });
      }
    }
  }
}
