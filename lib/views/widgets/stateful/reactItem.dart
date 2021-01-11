import 'package:flutter/material.dart';
import 'package:post/models/enums/reactTypeEnum.dart';
import 'package:post/models/react.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/iconHandler.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';
import 'package:post/views/widgets/stateless/userNameAndBio.dart';

import 'followButton.dart';

class ReactItem extends StatefulWidget {
  React react;
  ReactItem({this.react});
  @override
  _ReactItemState createState() => _ReactItemState();
}

class _ReactItemState extends State<ReactItem> {
  React _currentReact;
  User _reactOwner = User(
    active: true,
    bio: "mobile developer",
    userID: "45",
    userName: "Ahmed Mohamed",
    userProfilePicURL: "Default",
  );

  @override
  Widget build(BuildContext context) {
    _currentReact = widget.react;
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Row(
        children: [
          _createUserProfileAndIcon(),
          UserNameAndBio(userName: _reactOwner.userName, bio: _reactOwner.bio),
          Spacer(),
          FollowButton(
              following: CurrentUser().isFollowing(_currentReact.userID),
              onPressed: () {})
        ],
      ),
    );
  }

  Widget _createUserProfileAndIcon() {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical * 7,
            width: SizeConfig.blockSizeVertical * 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.SECONDARY_COLOR, width: .5),
            ),
            child:
                UserProfilePicture(active: false), //TODO: add user profile url
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconHandler.getReactIcon(_currentReact.reactType, size: 18),
          ),
        ],
      ),
    );
  }
}
