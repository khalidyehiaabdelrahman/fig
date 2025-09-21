import 'package:flutter/material.dart';
import '../pages/user_profile_page.dart';
import '../cubit/profile_state.dart';
import 'package:fig/core/utils/responsive.dart';

class ProfileLoggedInView extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final int phone;

  const ProfileLoggedInView({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final fullName = "$firstName $lastName";

    return Padding(
      padding: EdgeInsets.all(16.rw(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fullName,
            style: TextStyle(
              fontSize: 22.rt(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.rh(context)),
          Text(
            email,
            style: TextStyle(
              fontSize: 16.rt(context),
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.rh(context)),
          Text(
            phone == 0 ? 'لا يوجد رقم هاتف' : '0$phone',
            style: TextStyle(
              fontSize: 16.rt(context),
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.rh(context)),
          ElevatedButton(
            onPressed: () {
              final userData = SharedUserData(
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(userData: userData),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('View Full Profile'),
          ),
        ],
      ),
    );
  }
}
