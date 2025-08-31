import 'package:easy_localization/easy_localization.dart';
import 'package:fig/core/utils/responsive.dart';
import 'package:fig/core/widgets/common_widgets.dart';
import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fig/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtraButtonsForLoginOnly extends StatelessWidget {
  const ExtraButtonsForLoginOnly({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        context.locale;

        return BlocBuilder<AuthTabCubit, AuthTabState>(
          builder: (context, state) {
            int index = 0;
            if (state is AuthTabChanged) {
              index = state.index;
            }

            if (index != 0) return const SizedBox();

            return Column(
              children: [
                _buildRow(
                  context: context,
                  label: tr('order_tracking'),
                  onTap: () {},
                ),
                buildReusableDivider(),
                _buildRow(context: context, label: tr('help'), onTap: () {}),
                buildReusableDivider(),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildRow({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.zero,
      splashColor: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.rw(context),
          vertical: 12.rh(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.rt(context),
                fontWeight: FontWeight.w400,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
