import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';

class ReplyButton extends StatelessWidget {
  void Function() onPressed;
  ReplyButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(right: 8, left: 8),
        child: Text(
          'Reply',
          style: TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: 12),
        ),
      ),
      onTap: onPressed,
    );
  }
}
