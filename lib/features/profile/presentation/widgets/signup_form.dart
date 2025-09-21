import 'package:easy_localization/easy_localization.dart';
import 'package:fig/core/widgets/custom_button.dart';
import 'package:fig/core/utils/top_snack_bar.dart';
import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fig/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/core/utils/responsive.dart';

class SignUpForm extends StatefulWidget {
  final SharedUserData? sharedData;

  const SignUpForm({super.key, this.sharedData});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(
      text: widget.sharedData?.firstName ?? '',
    );
    lastNameController = TextEditingController(
      text: widget.sharedData?.lastName ?? '',
    );
    emailController = TextEditingController(
      text: widget.sharedData?.email ?? '',
    );
    passwordController = TextEditingController(
      text: widget.sharedData?.password ?? '',
    );
    confirmPasswordController = TextEditingController();
    phoneController = TextEditingController(
      text: widget.sharedData?.phone?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final sharedData = SharedUserData(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      phone: int.tryParse(phoneController.text.trim()) ?? 0,
    );

    try {
      await context.read<ProfileCubit>().signUp(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
        phone: int.tryParse(phoneController.text.trim()) ?? 0,
      );
      _showSuccessAndNavigate(sharedData);
    } catch (e) {
      _showError(e);
    }
  }

  void _showSuccessAndNavigate(SharedUserData sharedData) {
    AppMessages.showSignUpSuccess(context, "signup_success".tr());

    Future.delayed(const Duration(milliseconds: 500), () {
      context.read<AuthTabCubit>().changeTab(0, sharedData: sharedData);
    });
  }

  void _showError(dynamic error) {
    AppMessages.showError(context, "حدث خطأ: $error");
  }

  @override
  Widget build(BuildContext context) {
    context.locale;

    final firstNameFocus = FocusNode();
    final lastNameFocus = FocusNode();
    final emailFocus = FocusNode();
    final passwordFocus = FocusNode();
    final confirmPasswordFocus = FocusNode();
    final phoneFocus = FocusNode();

    return BlocProvider(
      create: (_) => SignUpVisibilityCubit(),
      child: Padding(
        padding: EdgeInsets.all(24.rw(context)),
        child: Column(
          children: [
            BuildTextField(
              hint: 'first_name_hint'.tr(),
              controller: firstNameController,
              focusNode: firstNameFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted:
                  (_) => FocusScope.of(context).requestFocus(lastNameFocus),
              prefixIcon: Icons.person,
            ),
            SizedBox(height: 12.rh(context)),

            BuildTextField(
              hint: 'last_name_hint'.tr(),
              controller: lastNameController,
              focusNode: lastNameFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted:
                  (_) => FocusScope.of(context).requestFocus(emailFocus),
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: 12.rh(context)),

            BuildTextField(
              hint: 'email_hint'.tr(),
              controller: emailController,
              focusNode: emailFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted:
                  (_) => FocusScope.of(context).requestFocus(passwordFocus),
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 12.rh(context)),

            BlocBuilder<SignUpVisibilityCubit, SignUpVisibilityState>(
              builder: (context, state) {
                return BuildTextField(
                  hint: 'password_hint'.tr(),
                  controller: passwordController,
                  focusNode: passwordFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted:
                      (_) => FocusScope.of(
                        context,
                      ).requestFocus(confirmPasswordFocus),
                  obscureText: !state.isPasswordVisible,
                  showToggleIcon: true,
                  isPasswordVisible: state.isPasswordVisible,
                  onToggle:
                      () =>
                          context
                              .read<SignUpVisibilityCubit>()
                              .togglePasswordVisibility(),
                  prefixIcon: Icons.lock,
                );
              },
            ),
            SizedBox(height: 12.rh(context)),

            BlocBuilder<SignUpVisibilityCubit, SignUpVisibilityState>(
              builder: (context, state) {
                return BuildTextField(
                  hint: 'confirm_password_hint'.tr(),
                  controller: confirmPasswordController,
                  focusNode: confirmPasswordFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted:
                      (_) => FocusScope.of(context).requestFocus(phoneFocus),
                  obscureText: !state.isConfirmPasswordVisible,
                  showToggleIcon: true,
                  isPasswordVisible: state.isConfirmPasswordVisible,
                  onToggle:
                      () =>
                          context
                              .read<SignUpVisibilityCubit>()
                              .toggleConfirmPasswordVisibility(),
                  prefixIcon: Icons.lock_outline,
                );
              },
            ),

            SizedBox(height: 12.rh(context)),

            BuildTextField(
              hint: 'phone_hint'.tr(),
              controller: phoneController,
              focusNode: phoneFocus,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone,
              onFieldSubmitted: (_) => _handleSignUp(),
            ),
            const SizedBox(height: 24),

            PrimaryButton(
              label: 'create_account'.tr().toUpperCase(),
              onPressed: _handleSignUp,
              backgroundColor: Colors.red.shade700,
            ),
            const SizedBox(height: 20),

            Text(
              "already_have_account".tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            PrimaryButton(
              borderColor: Colors.black26,
              label: 'login'.tr().toUpperCase(),
              foregroundColor: Colors.black,
              onPressed: () {
                context.read<AuthTabCubit>().changeTab(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
