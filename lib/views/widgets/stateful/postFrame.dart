import 'package:flutter/material.dart';
import 'package:post/models/post.dart';
import 'package:post/models/user.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/dateTimeFormatHandler.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/widgets/stateful/postItem.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';

///if the frame has multiple posts, it will show them horizontally
///and if not, it will show one post inside the frame.
class PostFrame extends StatefulWidget {
  final bool multiplePosts;
  final List<Post> postsList;
  final User postOwnerUser;

  PostFrame({this.multiplePosts = false, this.postsList, this.postOwnerUser});

  @override
  _PostFrameState createState() => _PostFrameState();

  void addPost(Post post) => this.postsList.add(post);
}

class _PostFrameState extends State<PostFrame> {
  int _postItemNumber = 0;
  User _user;
  bool _multiplePosts;
  List<Post> _postsList;
  int _numberOfNewPosts = 5;

  ///TODO: add positioned widget to all children inside the stack
  Widget _createTopPart() {
    return _multiplePosts
        ? _createTopPartWithRankAndNewPostsNum()
        : _createTopPartWithoutRankAndNewPostsNum();
  }

  _createTopPartWithoutRankAndNewPostsNum() {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.SECONDARY_COLOR))),
      width: double.infinity,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: [
          Positioned(
              top: -10,
              left: 20,
              width: 60,
              height: 60,
              child: UserProfilePicture(imageURL: _user.userProfilePicURL)),
          Positioned(
            left: 96,
            child: _createUserNameAndPostTimeText(),
          ),
          Positioned(
            right: 16,
            child: _createPropertiesButton(),
          ),
        ],
      ),
    );
  }

  _createTopPartWithRankAndNewPostsNum() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border(bottom: BorderSide(color: AppColors.SECONDARY_COLOR))),
      width: double.infinity,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: [
          Positioned(top: 16, left: 16, child: _createRank(1)),
          Positioned(
              top: -10,
              left: 48,
              width: 60,
              height: 60,
              child: UserProfilePicture(imageURL: _user.userProfilePicURL)),
          Positioned(
            left: 120,
            child: _createUserNameAndPostTimeText(),
          ),
          Positioned(
            right: 16,
            child: _createPropertiesButton(),
          ),
          Positioned(
            right: 0,
            bottom: -25,
            child: _createNumberOfNewPosts(),
          ),
        ],
      ),
    );
  }

  Widget _createRank(int rankNumber) {
    return Text(
      "#" + rankNumber.toString(),
      style: TextStyle(fontSize: 18, color: AppColors.PRIMARY_COLOR),
    );
  }

  Widget _createUserNameAndPostTimeText() {
    String userName = _user.userName;
    int postTimestamp = _postsList[_postItemNumber].timestamp;
    String postTime = DateTimeFormatHandler.getTimeFromTimestamp(postTimestamp);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: TextStyle(color: AppColors.PRIMARY_COLOR),
          ),
          Text(
            postTime,
            style: TextStyle(color: AppColors.SECONDARY_COLOR, fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget _createPropertiesButton() {
    return IconButton(
        icon: Icon(
          Icons.more_horiz,
          color: AppColors.SECONDARY_COLOR,
          size: 32,
        ),
        onPressed: () {});
  }

  Widget _createNumberOfNewPosts() {
    String text = '+ ' + _numberOfNewPosts.toString() + ' New posts';
    return Container(
      alignment: Alignment.center,
      width: 90,
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
          color: AppColors.SECONDARY_COLOR),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _createBodyThatContainsPostItems() {
    return _multiplePosts
        ? _createMultiplePostItems()
        : PostItem(_postsList[_postItemNumber]);
  }

  ///TODO: Don't forget to create a horizontal scrollable widget
  /// in case I have multiple posts at the same frame
  ///  like what happen inside the home page
  Widget _createMultiplePostItems() {
    return Container();
  }

  Widget _createBottomPart() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border(top: BorderSide(color: AppColors.SECONDARY_COLOR))),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _createBottomButton(
                  text: 'Like', icon: Icons.thumb_up, onPressed: () {}),
              _createBottomButton(
                  text: 'Comment', icon: Icons.comment, onPressed: () {}),
              _createBottomButton(
                  text: 'Share', icon: Icons.share, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createBottomButton({
    String text,
    IconData icon,
    Null Function() onPressed,
  }) {
    return FlatButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.SECONDARY_COLOR,
        size: 21,
      ),
      label: Text(
        text,
        style: TextStyle(color: AppColors.SECONDARY_COLOR, fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _user = this.widget.postOwnerUser;
    _multiplePosts = this.widget.multiplePosts;
    _postsList = this.widget.postsList;
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 2.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          _createTopPart(),
          _createBodyThatContainsPostItems(),
          _createBottomPart()
        ],
      ),
    );
  }
}
