import 'package:flutter/material.dart';

import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/home/homeViewModel.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';
import 'package:post/views/widgets/stateless/userNameAndBio.dart';
import 'package:provider/provider.dart';

import '../stateful/followButton.dart';

class UserItem extends StatelessWidget {
  final User user;
  const UserItem({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<SearchTabViewModel>(context);
    final userID = user.userID;
    final userName = user.userName;
    final profileURL = user.userProfilePicURL;
    final bio = user.bio;
    final active = user.active;

    bool following = CurrentUser().isFollowing(userID);
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
          (_isTheCurrentUser(userID))
              ? Container()
              : FollowButton(
                  following: following,
                  onPressed: () => (following)
                      ? _viewModel.unFollow(userID)
                      : _viewModel.follow(userID))
        ],
      ),
    );
  }

  bool _isTheCurrentUser(String userID) => userID == CurrentUser().userID;
}
