import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24),
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile_photo.jpg'),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Catto',
            style: TextStyle(color: Colors.purple[800], fontSize: 22),
          ),
          SizedBox(height: 8),
          Text(
            'cattocutie@email.com',
            style: TextStyle(color: Colors.purple[600]),
          ),
        ],
      ),
    );
  }
}
