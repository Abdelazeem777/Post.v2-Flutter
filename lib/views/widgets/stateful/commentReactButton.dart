import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';

//TODO: don't forget to make a new custom react button for the comments and replies
///Now, it's just for testing
class CommentReactButton extends StatefulWidget {
  @override
  _CommentReactButtonState createState() => _CommentReactButtonState();
}

class _CommentReactButtonState extends State<CommentReactButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: Text(
          'Like',
          style: TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: 12),
        ),
      ),
    );
  }
}
