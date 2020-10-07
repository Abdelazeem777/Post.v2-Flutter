import 'package:flutter/material.dart';

class UserNameAndBio extends StatelessWidget {
  String userName;
  String bio;
  UserNameAndBio({this.userName, this.bio});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            bio,
            style: TextStyle(fontSize: 11.5, color: Colors.grey[700]),
          )
        ],
      ),
    );
  }
}
