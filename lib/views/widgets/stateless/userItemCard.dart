import 'package:flutter/material.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/views/widgets/stateful/followButton.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';
import 'package:provider/provider.dart';

///TODO: use this class for all different places like searchpage and followers list
///it will help when adding view profiles feature.
class UserItemCard extends StatelessWidget {
  final User user;
  final rank;
  final viewModel;

  const UserItemCard({
    Key key,
    @required this.user,
    this.rank = -1,
    @required this.viewModel,
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
        leading: Container(
          height: 56,
          width: 56,
          child: UserProfilePicture(
            imageURL: profileURL,
            active: active,
          ),
        ),
        title: Text(
          userName,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          bio,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 11.5, color: Colors.grey[700]),
        ),
        trailing: _isTheCurrentUser(userID)
            ? Container()
            : FollowButton(
                following: following,
                onPressed: () => (following)
                    ? viewModel.unFollow(userID, rank)
                    : viewModel.follow(userID)));
  }

  bool _isTheCurrentUser(String userID) => userID == CurrentUser().userID;
}
