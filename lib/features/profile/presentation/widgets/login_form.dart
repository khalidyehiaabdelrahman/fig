import 'package:easy_localization/easy_localization.dart';
import 'package:fig/core/widgets/custom_button.dart';
import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => LoginVisibilityCubit(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BuildTextField(
              hint: 'email_hint'.tr(),
              controller: emailController,
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

            BlocBuilder<LoginVisibilityCubit, bool>(
              builder: (context, isPasswordVisible) {
                return BuildTextField(
                  hint: 'password_hint'.tr(),
                  controller: passwordController,
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
              onPressed: () {
                context.read<ProfileCubit>().login(
                  username: "User", // ممكن بعدين تجيبه من TextField
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
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





// import 'package:easy_localization/easy_localization.dart';
// import 'package:fig/core/widgets/custom_button.dart';
// import 'package:fig/features/profile/presentation/cubit/auth_tab_cubit.dart';
// import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginForm extends StatelessWidget {
//   const LoginForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     context.locale;
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

//     return BlocProvider(
//       create: (_) => LoginVisibilityCubit(),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             BuildTextField(
//               hint: 'email_hint'.tr(),
//               controller: emailController,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'email_required'.tr();
//                 }
//                 if (!value.contains('@')) return 'email_invalid'.tr();
//                 return null;
//               },
//               keyboardType: TextInputType.emailAddress,
//             ),

//             const SizedBox(height: 16),

//             BlocBuilder<LoginVisibilityCubit, bool>(
//               builder: (context, isPasswordVisible) {
//                 return BuildTextField(
//                   hint: 'password_hint'.tr(),
//                   controller: passwordController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'password_required'.tr();
//                     }

//                     return null;
//                   },
//                   obscureText: !isPasswordVisible,
//                   showToggleIcon: true,
//                   isPasswordVisible: isPasswordVisible,
//                   onToggle:
//                       () =>
//                           context
//                               .read<LoginVisibilityCubit>()
//                               .toggleVisibility(),
//                 );
//               },
//             ),

//             const SizedBox(height: 24),

//             PrimaryButton(
//               backgroundColor: Colors.red.shade700,
//               label: 'login'.tr(),
//               onPressed: () {
//  context.read<ProfileCubit>().login(
//       username: "User", 
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//           );



//               },
//             ),
//             const SizedBox(height: 20),

//             Text(
//               "no_account".tr(),
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.black54,
//               ),
//             ),
//             const SizedBox(height: 20),

//             PrimaryButton(
//               label: 'create_account'.tr(),
//               foregroundColor: Colors.black,
//               onPressed: () {
//                 context.read<AuthTabCubit>().changeTab(1);
//               },
//               borderColor: Colors.black26,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
