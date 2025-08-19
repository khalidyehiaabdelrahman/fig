import 'package:easy_localization/easy_localization.dart';
import 'package:fig/features/Basket/basket_screen.dart';
import 'package:fig/features/Favorites/presentation/pages/favorites_Screen.dart';
import 'package:fig/features/Navigation/presentation/cubit/navigation_cubit.dart';
import 'package:fig/features/home/presentation/pages/home_page.dart';
import 'package:fig/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _screens = const [
    HomePage(),
    Center(child: Text("Categories")),
    CartScreen(),
    FavoritesScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        context.locale;
        return BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return Scaffold(
              body: _screens[currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.red[900],
                unselectedItemColor: Colors.black87,
                onTap: (index) {
                  context.read<NavigationCubit>().changeTab(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'home'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category),
                    label: 'categories'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_basket),
                    label: 'basket'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'favorites'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'profile'.tr(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
