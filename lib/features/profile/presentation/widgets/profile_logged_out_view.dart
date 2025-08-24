import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fig/features/profile/presentation/widgets/extra_buttons.dart';
import 'package:fig/features/profile/presentation/widgets/login_form.dart';
import 'package:fig/features/profile/presentation/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'toggle_tab_bar.dart';

class ProfileLoggedOutView extends StatelessWidget {
  const ProfileLoggedOutView({super.key});

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
                // 🧱 Login/SignUp Container
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
                        BlocBuilder<AuthTabCubit, int>(
                          builder: (context, index) {
                            return index == 0
                                ? const LoginForm()
                                : const SignUpForm();
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

// import 'package:fig/features/profile/presentation/cubit/profile_cubit.dart';
// import 'package:fig/features/profile/presentation/widgets/extra_buttons.dart';
// import 'package:fig/features/profile/presentation/widgets/login_form.dart';
// import 'package:fig/features/profile/presentation/widgets/signup_form.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/auth_tab_cubit.dart';
// import 'toggle_tab_bar.dart';

// class ProfileLoggedOutView extends StatelessWidget {
//   const ProfileLoggedOutView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<AuthTabCubit>(
//       create: (_) => AuthTabCubit(),
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(top: 8),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 8,
//                           offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ToggleTabBar(),
//                         BlocBuilder<AuthTabCubit, int>(
//                           builder: (context, index) {
//                             return index == 0
//                                 ? LoginForm()
//                                 : BlocProvider(
//                                   create: (_) => SignUpVisibilityCubit(),
//                                   child: SignUpForm(),
//                                 );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 5),
//                 ExtraButtonsForLoginOnly(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
