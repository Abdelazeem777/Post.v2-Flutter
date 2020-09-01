import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/widgets/stateless/userProfileAvatar.dart';

class NewPost extends StatefulWidget {
  static const String routeName = '/NewPost';
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  Widget _createAppBar() {
    return AppBar(
      shadowColor: AppColors.SECONDARY_COLOR,
      title: Text(
        "New Post",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      iconTheme: IconThemeData(color: AppColors.PRIMARY_COLOR),
      actions: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(0, 12, 16, 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [AppColors.PRIMARY_COLOR, AppColors.SECONDARY_COLOR],
            ),
          ),
          child: Hero(
            tag: "newPost",
            child: Material(
              type: MaterialType.transparency,
              child: RaisedButton(
                  elevation: 0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: SizedBox(
                    height: 17,
                    child: Image.asset(
                      "lib/assets/post_logo_without_background.png",
                    ),
                  ),
                  onPressed: () {}),
            ),
          ),
        )
      ],
    );
  }

  Widget _createNewPost() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileAvatar(),
            _createPostTextField(),
          ],
        ),
        _createAddMoreToPost()
      ],
    );
  }

  Widget _createPostTextField() {
    return SizedBox(
      width: SizeConfig.safeBlockHorizontal * 75,
      child: TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: 'What do you want to Post?',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _createAddMoreToPost() {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.SECONDARY_COLOR))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _createAddButton(
            text: "Add Photo",
            icon: Icon(
              FontAwesomeIcons.image,
              color: AppColors.SECONDARY_COLOR,
              size: 48,
            ),
            onPressed: () {},
          ),
          _createAddButton(
            text: "Add Video",
            icon: Icon(
              FontAwesomeIcons.video,
              color: AppColors.SECONDARY_COLOR,
              size: 46,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _createAddButton({String text, Icon icon, Null Function() onPressed}) {
    return Container(
      height: 110,
      width: 110,
      margin: EdgeInsets.only(top: 36, bottom: 36),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: AppColors.SECONDARY_COLOR)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Text(
            text,
            style: TextStyle(fontSize: 16, color: AppColors.SECONDARY_COLOR),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _createAppBar(),
      body: SafeArea(
        child: _createNewPost(),
      ),
    );
  }
}
