import 'package:flutter/material.dart';

class ProfileLoggedInView extends StatelessWidget {
  final String username;
  final String email;

  const ProfileLoggedInView({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome, $username', style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text('Email: $email', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
