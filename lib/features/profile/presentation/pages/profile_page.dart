import 'package:easy_localization/easy_localization.dart';
import 'package:fig/core/widgets/common_widgets.dart';
import 'package:fig/core/widgets/custom_button.dart';
import 'package:fig/features/home/widgets/snack_bar_widget.dart';
import 'package:fig/features/profile/presentation/pages/language_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_logged_in_view.dart';
import '../widgets/profile_logged_out_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('profile'.tr()),
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                  child: Image.asset('assets/images/7.jpg', height: 150),
                ),

                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state.errorMessage != null) {
                      TopSnackBar.show(
                        context,
                        message: state.errorMessage!,
                        icon: Icons.error,
                        backgroundColor: Colors.red,
                      );
                    }

                    if (state.status == ProfileStatus.loggedIn &&
                        !state.isLoading) {
                      TopSnackBar.show(
                        context,
                        message: "login_success".tr(),
                        icon: Icons.check_circle,
                        backgroundColor: Colors.green,
                      );
                    }

                    if (state.status == ProfileStatus.signedUp &&
                        !state.isLoading) {
                      TopSnackBar.show(
                        context,
                        message: "signup_success".tr(),
                        icon: Icons.person_add,
                        backgroundColor: Colors.green,
                      );
                    }

                    if (state.status == ProfileStatus.loggedOut &&
                        !state.isLoading) {
                      TopSnackBar.show(
                        context,
                        message: "logout_success".tr(),
                        icon: Icons.exit_to_app,
                        backgroundColor: Colors.blueGrey,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Stack(
                      children: [
                        state.status == ProfileStatus.loggedIn
                            ? ProfileLoggedInView(
                              username: state.username,
                              email: state.email,
                            )
                            : const ProfileLoggedOutView(),

                        if (state.isLoading)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withAlpha(
                                (0.3 * 255).round(),
                              ),
                              child: Center(child: LoadingIndicator()),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                alignedText(
                  isBold: true,
                  text: "fig_support".tr(),
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 10),

                PrimaryButton(
                  label: 'contact_form'.tr(),
                  onPressed: () {},
                  foregroundColor: Colors.black,
                  borderColor: Colors.grey,
                  icon: Icons.contact_page,
                  iconAtEnd: false,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),

                PrimaryButton(
                  label: 'contact_phone'.tr(),
                  fontWeight: FontWeight.normal,
                  onPressed: () {},
                  foregroundColor: Colors.black,
                  borderColor: Colors.grey,
                  icon: Icons.phone,
                  iconAtEnd: false,
                ),

                const SizedBox(height: 10),
                alignedText(
                  isBold: true,
                  text: 'language_selection'.tr(),
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),

                const SizedBox(height: 10),

                PrimaryButton(
                  label:
                      context.locale.languageCode == 'ar'
                          ? 'العربية'
                          : 'English',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LanguageSelectionPage(),
                      ),
                    );
                  },
                  foregroundColor: Colors.black,
                  fontWeight: FontWeight.normal,
                  borderColor: Colors.grey,
                  icon: Icons.language,
                  iconAtEnd: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
