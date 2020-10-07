import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:post/enums/replyTypeEnum.dart';

import 'package:post/models/reply.dart';
import 'package:post/models/user.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/widgets/stateful/commentReactButton.dart';
import 'package:post/views/widgets/stateless/timeTextFromTimestamp.dart';
import 'package:post/views/widgets/stateless/replyButton.dart';
import 'package:post/views/widgets/stateless/userNameAndBio.dart';

import 'userProfilePicture.dart';

class ReplyItem extends StatefulWidget {
  Reply reply;
  void Function() onReplyButtonPressed;
  ReplyItem({
    @required this.reply,
    @required this.onReplyButtonPressed,
  });

  @override
  _ReplyItemState createState() => _ReplyItemState();
}

class _ReplyItemState extends State<ReplyItem> {
  Reply _currentReply;

  //just for testing
  User _replyOwner = User(
      active: true,
      bio: "mobile developer",
      userID: 45,
      userName: "Ahmed Mohamed",
      userProfilePicURL: "Default",
      following: true);
  @override
  Widget build(BuildContext context) {
    _currentReply = widget.reply;

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _createReplyThreadLine(),
      _createUserProfile(),
      Column(
        children: [
          Container(
            //51=(35+(8*2)) is the width of the user profile picture,
            //4 is for right margin,
            //multiplied by 2 because we want to leave a double space for the main comment profile picture and the reply one
            width: SizeConfig.screenWidth - (51 + 4) * 2,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
                color: AppColors.SECONDARY_COLOR.withOpacity(.15),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserNameAndBio(
                      userName: _replyOwner.userName,
                      bio: _replyOwner.bio,
                    ),
                    TimeTextFromTimestamp(_currentReply.timestamp),
                  ],
                ),
                _createReplyContent(
                  _currentReply.replyContent,
                  _currentReply.replyType,
                ),
                _createBottomPartOfReply(),
              ],
            ),
          ),
        ],
      )
    ]);
  }

  Widget _createReplyThreadLine() {
    return SizedBox(
      width: 51,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.PRIMARY_COLOR,
            width: 1,
            height: 123,
          ),
          _createHorizontalLine(),
        ],
      ),
    );
  }

  Widget _createHorizontalLine() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Container(
            color: AppColors.PRIMARY_COLOR,
            width: 19,
            height: 1,
          ),
          Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.PRIMARY_COLOR,
                shape: BoxShape.circle,
              )),
        ],
      ),
    );
  }

  Widget _createUserProfile() {
    return Container(
      width: 35,
      height: 35,
      margin: EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: UserProfilePicture(
        active: _replyOwner.active,
        imageURL: _replyOwner.userProfilePicURL,
        activeIndicatorSize: 10,
      ),
    );
  }

  Widget _createReplyContent(String content, ReplyType type) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: type == ReplyType.Text
          ? Text(content)
          : CachedNetworkImage(
              fit: BoxFit.contain,
              height: SizeConfig.screenWidth,
              imageUrl: content,
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.totalSize != null
                      ? progress.downloaded / progress.totalSize
                      : null,
                  valueColor: AlwaysStoppedAnimation(AppColors.SECONDARY_COLOR),
                ),
              ),
            ),
    );
  }

  Widget _createBottomPartOfReply() {
    return Row(
      children: [
        //TODO: don't forget to make a new custom react button for the comments and replies
        CommentReactButton(),
        ReplyButton(onPressed: widget.onReplyButtonPressed),
      ],
    );
  }
}
