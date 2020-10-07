import 'package:flutter/material.dart';
import 'package:post/models/user.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';
import 'package:post/views/widgets/stateless/userNameAndBio.dart';

import 'followButton.dart';

class UserItem extends StatefulWidget {
  final User user;
  UserItem(this.user);

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    String userName = this.widget.user.userName;
    String profileURL = this.widget.user.userProfilePicURL;
    String bio = this.widget.user.bio;
    bool active = this.widget.user.active;
    bool following = this.widget.user.following;
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.only(top: 16, bottom: 16),
      margin: EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.SECONDARY_COLOR))),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            margin: EdgeInsets.only(right: 8),
            child: UserProfilePicture(
              imageURL: profileURL,
              active: active,
            ),
          ),
          UserNameAndBio(userName: userName, bio: bio),
          Spacer(),
          FollowButton(following: following, onPressed: () {})
        ],
      ),
    );
  }
}
