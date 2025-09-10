import 'package:easy_localization/easy_localization.dart';
import 'package:fig/core/widgets/custom_button.dart';
import 'package:fig/features/home/widgets/snack_bar_widget.dart';
import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fig/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final SharedUserData? sharedData;

  const LoginForm({super.key, this.sharedData});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  @override
  void initState() {
    super.initState();
    
    emailController = TextEditingController(
      text: widget.sharedData?.email ?? '',
    );
    passwordController = TextEditingController(
      text: widget.sharedData?.password ?? '',
    );
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (widget.sharedData == null) {
      _loadStoredData();
    }
  }

  Future<void> _loadStoredData() async {
    final profileCubit = context.read<ProfileCubit>();
    final storedData = await profileCubit.getStoredUserData();

    if (storedData != null) {
      setState(() {
        emailController.text = storedData.email ?? '';
        passwordController.text = storedData.password ?? '';
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;

    return BlocProvider(
      create: (_) => LoginVisibilityCubit(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BuildTextField(
              hint: 'email_hint'.tr(),
              controller: emailController,
              focusNode: emailFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted:
                  (_) => FocusScope.of(context).requestFocus(passwordFocus),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'email_required'.tr();
                }
                if (!value.contains('@')) return 'email_invalid'.tr();
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),

            BlocBuilder<LoginVisibilityCubit, LoginVisibilityState>(
              builder: (context, state) {
                final isPasswordVisible = state is LoginVisibilityShown;

                return BuildTextField(
                  hint: 'password_hint'.tr(),
                  controller: passwordController,
                  focusNode: passwordFocus,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    context.read<ProfileCubit>().login(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password_required'.tr();
                    }
                    return null;
                  },
                  obscureText: !isPasswordVisible,
                  showToggleIcon: true,
                  isPasswordVisible: isPasswordVisible,
                  onToggle:
                      () =>
                          context
                              .read<LoginVisibilityCubit>()
                              .toggleVisibility(),
                );
              },
            ),

            const SizedBox(height: 24),

            PrimaryButton(
              backgroundColor: Colors.red.shade700,
              label: 'login'.tr(),
              onPressed: () async {
                try {
                  await context.read<ProfileCubit>().login(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    sharedData: widget.sharedData,
                  );
                } catch (e) {
                  
                  TopSnackBar.show(
                    context,
                    message: "حدث خطأ: $e",
                    icon: Icons.error,
                    backgroundColor: Colors.red,
                  );
                }
              },
            ),
            const SizedBox(height: 20),

            Text(
              "no_account".tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            PrimaryButton(
              label: 'create_account'.tr(),
              foregroundColor: Colors.black,
              onPressed: () {
                
                context.read<AuthTabCubit>().changeTab(1);
              },
              borderColor: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}
