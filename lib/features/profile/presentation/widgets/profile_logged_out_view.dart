import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fig/features/profile/presentation/cubit/profile_state.dart';
import 'package:fig/features/profile/presentation/widgets/extra_buttons.dart';
import 'package:fig/features/profile/presentation/widgets/login_form.dart';
import 'package:fig/features/profile/presentation/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'toggle_tab_bar.dart';

class ProfileLoggedOutView extends StatelessWidget {
  final SharedUserData? sharedData;

  const ProfileLoggedOutView({super.key, this.sharedData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthTabCubit>(
      create: (_) => AuthTabCubit(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ToggleTabBar(),
                        BlocBuilder<AuthTabCubit, AuthTabState>(
                          builder: (context, state) {
                            int index = 0;
                            SharedUserData? currentSharedData = sharedData;

                            if (state is AuthTabChanged) {
                              index = state.index;
                              currentSharedData =
                                  state.sharedData ?? sharedData;
                            }

                            return index == 0
                                ? LoginForm(sharedData: currentSharedData)
                                : SignUpForm(sharedData: currentSharedData);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const ExtraButtonsForLoginOnly(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
