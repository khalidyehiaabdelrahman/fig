import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_tab_cubit.dart';

class ToggleTabBar extends StatelessWidget {
  const ToggleTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthTabCubit, int>(
      builder: (context, selectedIndex) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final containerWidth = constraints.maxWidth;
            final tabWidth = containerWidth / 2;

            final isRtl = context.locale.languageCode == 'ar';

            final indicatorPosition =
                (isRtl ? (1 - selectedIndex) : selectedIndex) * tabWidth;

            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  left: indicatorPosition,
                  child: Container(
                    width: tabWidth,
                    height: 2,
                    color: Colors.red[900],
                  ),
                ),
                Row(
                  children: [
                    _buildTab(context, 'LOGIN', 0, tabWidth, selectedIndex),
                    _buildTab(context, 'SIGN UP', 1, tabWidth, selectedIndex),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTab(
    BuildContext context,
    String labelKey,
    int index,
    double width,
    int selectedIndex,
  ) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => context.read<AuthTabCubit>().changeTab(index),
      child: SizedBox(
        width: width,
        height: 48,
        child: Center(
          child: Text(
            labelKey.tr(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.red[900] : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
