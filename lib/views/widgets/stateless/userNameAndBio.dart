import 'package:flutter/material.dart';
import 'package:post/utils/sizeConfig.dart';

class UserNameAndBio extends StatelessWidget {
  String userName;
  String bio;
  UserNameAndBio({this.userName, this.bio});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 50,
      height: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            bio,
            overflow: TextOverflow.fade,
            style: TextStyle(fontSize: 11.5, color: Colors.grey[700]),
          )
        ],
      ),
    );
  }
}
