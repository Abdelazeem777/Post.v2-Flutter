import 'package:flutter/material.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/style/appColors.dart';
import 'package:post/views/widgets/stateful/followButton.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';
import 'package:provider/provider.dart';

//TODO: try to add a bottom border
class UserItemCard extends StatelessWidget {
  final User user;
  final viewModel;
  final withRank;

  const UserItemCard({
    Key key,
    @required this.user,
    @required this.viewModel,
    this.withRank = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<CurrentUser>(context);
    final userID = user.userID;
    final userName = user.userName;
    final profileURL = user.userProfilePicURL;
    final bio = user.bio;
    final active = user.active;
    final rank = _currentUser.getRank(userID);
    final following = _currentUser.isFollowing(userID);
    return ListTile(
      key: key,
      contentPadding: EdgeInsets.zero,
      leading: _createLeadingPartOfTile(rank, profileURL, active),
      title: Text(
        userName,
        softWrap: false,
        overflow: TextOverflow.fade,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        bio,
        softWrap: false,
        overflow: TextOverflow.fade,
        style: TextStyle(fontSize: 10.5, color: Colors.grey[700]),
      ),
      trailing: _isTheCurrentUser(userID)
          ? Container()
          : FollowButton(
              following: following,
              onPressed: () {
                return (following)
                    ? viewModel.unFollow(userID, rank)
                    : viewModel.follow(userID);
              },
            ),
    );
  }

  Widget _createLeadingPartOfTile(int rank, String profileURL, bool active) {
    return Container(
      height: 48,
      width: withRank ? 74 : 48,
      child: withRank
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${rank + 1}',
                  style:
                      TextStyle(fontSize: 18, color: AppColors.PRIMARY_COLOR),
                ),
                _createProfilePicture(profileURL, active),
              ],
            )
          : _createProfilePicture(profileURL, active),
    );
  }

  Widget _createProfilePicture(String profileURL, bool active) {
    return SizedBox(
      width: 48,
      height: 48,
      child: UserProfilePicture(
        imageURL: profileURL,
        active: active,
      ),
    );
  }

  bool _isTheCurrentUser(String userID) => userID == CurrentUser().userID;
}
