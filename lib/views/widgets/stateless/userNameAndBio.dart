import 'package:flutter/material.dart';
import 'package:post/utils/sizeConfig.dart';

class UserNameAndBio extends StatelessWidget {
  final String userName;
  final String bio;
  UserNameAndBio({this.userName, this.bio});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.safeBlockHorizontal * 50,
        height: 30,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: userName + '\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: bio,
                style: TextStyle(fontSize: 11.5, color: Colors.grey[700]),
              )
            ],
          ),
        ));
  }
}
