import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/newPostPage/newPostPageViewModel.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {
  static const String routeName = '/NewPost';
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _viewModel = NewPostViewModel();
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      builder: (context, child) => Scaffold(
        key: _viewModel.scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: _createAppBar(),
        body: SafeArea(
          child: _createNewPost(),
        ),
      ),
    );
  }

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
                  onPressed: () =>
                      _viewModel.uploadNewPost(onSuccess: _goBack)),
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
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.all(16),
              child: UserProfilePicture(
                imageURL: CurrentUser().userProfilePicURL,
                active: CurrentUser().active,
              ),
            ),
            _createPostTextField(),
          ],
        ),
        _createAddMoreToPost()
      ],
    );
  }

  Widget _createPostTextField() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: SizeConfig.safeBlockHorizontal * 75,
      child: TextField(
        controller: _viewModel.newPostTextController,
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
          PickFromGalleryButton(
              text: "Add Photo",
              icon: Icon(
                FontAwesomeIcons.image,
                color: AppColors.SECONDARY_COLOR,
                size: 48,
              ),
              onPressed: _viewModel.pickPhotoFromGallery),
          PickFromGalleryButton(
              text: "Add Video",
              icon: Icon(
                FontAwesomeIcons.video,
                color: AppColors.SECONDARY_COLOR,
                size: 46,
              ),
              onPressed: _viewModel.pickVideoFromGallery),
        ],
      ),
    );
  }

  _goBack() => Navigator.of(context).pop();
}

class PickFromGalleryButton extends StatelessWidget {
  const PickFromGalleryButton({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
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
}
