import 'package:easy_localization/easy_localization.dart';
import 'package:fig/core/constants/components.dart';
import 'package:fig/core/utils/responsive.dart';
import 'package:fig/features/profile/presentation/cubit/auth_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtraButtonsForLoginOnly extends StatelessWidget {
  const ExtraButtonsForLoginOnly({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        context.locale;

        return BlocBuilder<AuthTabCubit, int>(
          builder: (context, index) {
            if (index != 0) return const SizedBox();

            return Column(
              children: [
                _buildRow(
                  context: context,
                  label: tr('order_tracking'),
                  onTap: () {
                    // TODO
                  },
                ),
                buildReusableDivider(),
                _buildRow(
                  context: context,
                  label: tr('help'),
                  onTap: () {
                    // TODO
                  },
                ),
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
