import 'package:flutter/material.dart';
import '../pages/user_profile_page.dart';
import '../cubit/profile_state.dart';

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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fullName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            email,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            phone.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
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
