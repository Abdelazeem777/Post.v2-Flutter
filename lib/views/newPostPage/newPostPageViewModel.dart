import 'package:flutter/material.dart';
import 'package:post/di/injection.dart';
import 'package:post/enums/postTypeEnum.dart';
import 'package:post/models/post.dart';
import 'package:post/services/currentUser.dart';

class NewPostViewModel with ChangeNotifier {
  final _postsRepository = Injector().postsRepository;
  final newPostTextController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void uploadNewPost({@required Function onSuccess}) {
    if (_newPostTextFieldIsEmpty()) {
      _showSnackBar('Please, write something to post!');
      return;
    }
    _showSnackBar('Uploading...');
    final newPost = _getNewPost();
    _postsRepository.uploadNewPost(newPost).listen((_) {
      _showSnackBar('Post shared Successfully');
      onSuccess();
    }).onError(_showSnackBar);
  }

  bool _newPostTextFieldIsEmpty() {
    var newPostText = newPostTextController?.text;
    return newPostText == null || newPostText.isEmpty;
  }

  Post _getNewPost() => Post(
        userID: CurrentUser().userID,
        postContent: newPostTextController.text,
        postType: PostType.Text,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

  void _showSnackBar(message) {
    final snackBar = SnackBar(content: Text(message.toString()));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void pickPhotoFromGallery() {}

  void pickVideoFromGallery() {}
}
