import 'package:flutter/material.dart';

class UserProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: CircleAvatar(
        backgroundImage: AssetImage('lib/assets/test_profile.jpg'),
      ),
    );
  }
}
