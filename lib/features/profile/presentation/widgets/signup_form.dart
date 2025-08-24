import 'package:easy_localization/easy_localization.dart';
import 'package:fig/core/widgets/custom_button.dart';
import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale; // Force rebuild on language change

    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (_) => SignUpVisibilityCubit(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            BuildTextField(
              hint: 'username_hint'.tr(),
              controller: usernameController,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'username_required'.tr()
                          : null,
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 12),

            BuildTextField(
              hint: 'email_hint'.tr(),
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'email_required'.tr();
                if (!value.contains('@')) return 'email_invalid'.tr();
                return null;
              },
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),

            BlocBuilder<SignUpVisibilityCubit, SignUpVisibilityState>(
              builder: (context, state) {
                return BuildTextField(
                  hint: 'password_hint'.tr(),
                  controller: passwordController,
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
            const SizedBox(height: 12),

            BlocBuilder<SignUpVisibilityCubit, SignUpVisibilityState>(
              builder: (context, state) {
                return BuildTextField(
                  hint: 'confirm_password_hint'.tr(),
                  controller: confirmPasswordController,
                  obscureText: !state.isConfirmPasswordVisible,
                  showToggleIcon: true,
                  isPasswordVisible: state.isConfirmPasswordVisible,
                  onToggle:
                      () =>
                          context
                              .read<SignUpVisibilityCubit>()
                              .toggleConfirmPasswordVisibility(),
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'confirm_password_required'.tr();
                    }
                    if (value != passwordController.text) {
                      return 'passwords_do_not_match'.tr();
                    }
                    return null;
                  },
                );
              },
            ),

            const SizedBox(height: 24),
            PrimaryButton(
              label: 'create_account'.tr().toUpperCase(),
              onPressed: () {
                context.read<ProfileCubit>().signUp(
                  username: usernameController.text.trim(),
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  confirmPassword: confirmPasswordController.text.trim(),
                );
              },
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
