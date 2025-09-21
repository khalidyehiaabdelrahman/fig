import 'package:easy_localization/easy_localization.dart';
import 'package:fig/core/widgets/common_widgets.dart';
import 'package:fig/core/widgets/custom_button.dart';
import 'package:fig/core/widgets/loading_indicator.dart';
import 'package:fig/core/widgets/base_scaffold.dart';
import 'package:fig/core/utils/top_snack_bar.dart';
import 'package:fig/features/profile/presentation/pages/language_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_logged_in_view.dart';
import '../widgets/profile_logged_out_view.dart';
import 'package:fig/core/di/service_locator.dart' as di;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = di.getIt<ProfileCubit>();
    _profileCubit.checkLoginStatus();
  }

  @override
  void dispose() {
    // لا نغلق ProfileCubit لأنه LazySingleton
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: BaseScaffold(
        title: 'profile'.tr(),
        wrapWithSafeArea: true,
        wrapWithScrollView: true,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              child: Image.asset('assets/images/7.jpg', height: 150),
            ),

            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileError) {
                  AppMessages.showError(context, state.message);
                }

                // فقط عند تسجيل الدخول الجديد
                if (state is ProfileLoggedIn) {
                  // لا نعرض رسالة النجاح هنا لأنها تظهر عند كل rebuild
                  // AppMessages.showSuccess(context, "login_success".tr());
                }

                if (state is ProfileSignedUp) {
                  AppMessages.showSignUpSuccess(context, "signup_success".tr());
                }

                if (state is ProfileLoggedOut) {
                  // Handle logout if needed
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    if (state is ProfileLoggedIn)
                      ProfileLoggedInView(
                        firstName: state.firstName,
                        lastName: state.lastName,
                        email: state.email,
                        phone: state.phone ?? 0,
                      )
                    else if (state is ProfileAlreadyLoggedIn)
                      ProfileLoggedInView(
                        firstName: state.firstName,
                        lastName: state.lastName,
                        email: state.email,
                        phone: state.phone ?? 0,
                      )
                    else if (state is ProfileSignedUp)
                      ProfileLoggedInView(
                        firstName: state.firstName,
                        lastName: state.lastName,
                        email: state.email,
                        phone: state.phone,
                      )
                    else
                      const ProfileLoggedOutView(),

                    if (state is ProfileLoading)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withAlpha((0.3 * 255).round()),
                          child: const Center(child: LoadingIndicator()),
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
                  context.locale.languageCode == 'ar' ? 'العربية' : 'English',
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
    );
  }
}
