import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:post/models/comment.dart';
import 'package:post/models/currentUser.dart';
import 'package:post/models/react.dart';
import 'package:post/models/user.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/widgets/stateful/reactItem.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';
import 'package:post/views/widgets/stateless/userNameAndBio.dart';

import 'commentItem.dart';
import 'followButton.dart';

class CommentsBottomSheet extends StatefulWidget {
  List<Comment> commentsList;
  List<React> reactsList;
  CommentsBottomSheet({
    @required this.commentsList,
    @required this.reactsList,
  });
  @override
  _CommentsBottomSheetState createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  List<Comment> _commentsList;
  List<React> _reactsList;
  User _currentUser;

  //controllers
  PageController _pageController;
  TextEditingController _mainCommentTextController;

  FocusNode _mainCommentTextFocusNode;

  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _mainCommentTextController = TextEditingController();

    _mainCommentTextFocusNode = FocusNode();

    _currentUser = CurrentUserSingletone.getInstance();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    //_mainCommentTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _commentsList = widget.commentsList;
    _reactsList = widget.reactsList;
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      child: Column(
        children: [
          _createTopBar(),
          _createBody(),
          _createBottomBar(),
        ],
      ),
    );
  }

  Widget _createTopBar() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: AppColors.SECONDARY_COLOR),
      )),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 5,
              width: 70,
              margin: EdgeInsets.only(top: 12, bottom: 8),
              color: AppColors.SECONDARY_COLOR.withOpacity(.6),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                  onPressed: _moveToCommentsTab,
                  child: Text(
                    "Comments",
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            _tab == 0 ? AppColors.PRIMARY_COLOR : Colors.black),
                  )),
              FlatButton(
                  onPressed: _moveToReactsTab,
                  child: Text(
                    "Reacts",
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            _tab == 1 ? AppColors.PRIMARY_COLOR : Colors.black),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createBody() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        onPageChanged: (tabNumber) => setState(() => _tab = tabNumber),
        children: [
          _createCommentsTab(),
          _createReactsTab(),
        ],
      ),
    );
  }

  Widget _createCommentsTab() {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: ListView.builder(
          itemCount: _commentsList.length,
          itemBuilder: (context, index) =>
              CommentItem(comment: _commentsList[index])),
    );
  }

  Widget _createReactsTab() {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: ListView.builder(
          itemCount: _reactsList.length,
          itemBuilder: (context, index) =>
              ReactItem(react: _reactsList[index])),
    );
  }

  Widget _createBottomBar() {
    Widget widget = _tab == 0
        ? Row(
            children: [
              _createCurrentUserProfilePicture(),
              _createCommentTextField(),
              _createSendCommentButton(),
            ],
          )
        : Container();

    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: AppColors.SECONDARY_COLOR),
      )),
      child: widget,
    );
  }

  Widget _createCurrentUserProfilePicture() {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.all(12),
      child: UserProfilePicture(
        imageURL: _currentUser.userProfilePicURL,
      ),
    );
  }

  Widget _createCommentTextField() {
    return Expanded(
      child: TextField(
        controller: _mainCommentTextController,
        focusNode: _mainCommentTextFocusNode,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        cursorColor: AppColors.SECONDARY_COLOR,
        style: TextStyle(fontSize: 14),
        scrollPhysics: ScrollPhysics(),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
          hintText: 'Write a comment...',
          border: InputBorder.none,
          fillColor: AppColors.SECONDARY_COLOR.withOpacity(.15),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _createSendCommentButton() {
    return IconButton(
        icon: Icon(
          Icons.send,
          color: AppColors.SECONDARY_COLOR,
        ),
        onPressed: null);
  }

  void _moveToCommentsTab() =>
      setState(() => _pageController.animateToPage(_tab = 0,
          duration: Duration(milliseconds: 300), curve: Curves.decelerate));

  void _moveToReactsTab() =>
      setState(() => _pageController.animateToPage(_tab = 1,
          duration: Duration(milliseconds: 300), curve: Curves.decelerate));
}
