import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';

class FollowButton extends StatefulWidget {
  bool following;
  Function onPressed;
  FollowButton({this.following, this.onPressed});
  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.widget.following ? 80 : 72,
      height: 30,
      child: RaisedButton(
        color: this.widget.following ? AppColors.PRIMARY_COLOR : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: AppColors.PRIMARY_COLOR)),
        padding: EdgeInsets.all(0),
        child: this.widget.following
            ? Text(
                'Following',
                style: TextStyle(color: Colors.white),
              )
            : Text(
                '+ Follow',
                style: TextStyle(color: AppColors.PRIMARY_COLOR),
              ),
        onPressed: this.widget.onPressed,
      ),
    );
  }
}
