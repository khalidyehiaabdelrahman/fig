import 'package:easy_localization/easy_localization.dart';
import 'package:fig/core/constants/components.dart';
import 'package:fig/core/widgets/custom_button.dart';
import 'package:fig/features/profile/presentation/pages/LanguageSelectionPage.dart';
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
          title: Text('profile'.tr()), // 🔁 معرّب
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

                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state.status == ProfileStatus.loggedIn) {
                      return ProfileLoggedInView(
                        username: state.username,
                        email: state.email,
                      );
                    } else {
                      return const ProfileLoggedOutView();
                    }
                  },
                ),

                alignedText(
                  isBold: true,
                  text: "fig_support".tr(), // 🔁 معرّب
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 10),

                PrimaryButton(
                  label: 'contact_form'.tr(), // 🔁 معرّب
                  onPressed: () {},
                  foregroundColor: Colors.black,
                  borderColor: Colors.grey,
                  icon: Icons.contact_page,
                  iconAtEnd: false,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),

                PrimaryButton(
                  label: 'contact_phone'.tr(), // 🔁 معرّب
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
                  text: 'language_selection'.tr(), // 🔁 معرّب
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

// import 'package:easy_localization/easy_localization.dart';
// import 'package:fig/core/constants/components.dart';
// import 'package:fig/core/widgets/custom_button.dart';
// import 'package:fig/features/profile/presentation/pages/LanguageSelectionPage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/profile_cubit.dart';
// import '../cubit/profile_state.dart';
// import '../widgets/profile_logged_in_view.dart';
// import '../widgets/profile_logged_out_view.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ProfileCubit(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text('Profile'),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           surfaceTintColor: Colors.transparent,
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
//                   child: Image.asset(
//                     'assets/images/7.jpg',
//                     height: 150,
//                   ),
//                 ),

//                 BlocBuilder<ProfileCubit, ProfileState>(
//                   builder: (context, state) {
//                     if (state.status == ProfileStatus.loggedIn) {
//                       return ProfileLoggedInView(
//                         username: state.username,
//                         email: state.email,
//                       );
//                     } else {
//                       return const ProfileLoggedOutView();
//                     }
//                   },
//                 ),

//                 alignedText(
//                   isBold: true,
//                   text: "fig_support".tr(),
//                   style: const TextStyle(fontSize: 20, color: Colors.black),
//                 ),
//                 const SizedBox(height: 10),

//                 PrimaryButton(
//                   label: 'Contact Form',
//                   onPressed: () {},
//                   foregroundColor: Colors.black,
//                   borderColor: Colors.grey,
//                   icon: Icons.contact_page,
//                   iconAtEnd: false,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 const SizedBox(height: 10),

//                 PrimaryButton(
//                   label: 'Contact Form',
//                   fontWeight: FontWeight.normal,
//                   onPressed: () {},
//                   foregroundColor: Colors.black,
//                   borderColor: Colors.grey,
//                   icon: Icons.phone,
//                   iconAtEnd: false,
//                 ),

//                 const SizedBox(height: 10),
//                 alignedText(
//                   isBold: true,
//                   text: 'Language Selection',
//                   style: const TextStyle(fontSize: 20, color: Colors.black),
//                 ),

//                 const SizedBox(height: 10),

//                 PrimaryButton(
//                   label:
//                       context.locale.languageCode == 'ar'
//                           ? 'العربية'
//                           : 'English',
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LanguageSelectionPage(),
//                       ),
//                     );
//                   },
//                   foregroundColor: Colors.black,

//                   fontWeight: FontWeight.normal,
//                   borderColor: Colors.grey,
//                   icon: Icons.language,
//                   iconAtEnd: false,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
