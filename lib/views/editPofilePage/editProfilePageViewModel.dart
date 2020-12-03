import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:post/di/injection.dart';
import 'package:post/repositories/currentUserRepository.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/utils/GalleryPicker.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class EditProfilePageViewModel with ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final bioController = TextEditingController();
  final userNameFocusNode = FocusNode();
  final bioFocusNode = FocusNode();

  bool autoValidate = false;

  CurrentUserRepository _userRepository;
  GalleryPicker _imagePicker;

  EditProfilePageViewModel() {
    _userRepository = Injector().currentUserRepository;
    _imagePicker = Injector().galleryImagePicker;
    userNameController.text = CurrentUser().userName;
    bioController.text = CurrentUser().bio;
  }
  void chooseImage() async {
    Map imageBase64Map = await _imagePicker.pickUserProfilePic();
    if (imageBase64Map != null) {
      _showSnackBar("Uploading...");
      _userRepository
          .uploadProfilePic(imageBase64Map)
          .listen((_) async => await _onUploadingSuccess())
          .onError(_showSnackBar);
    }
  }

  Future _onUploadingSuccess() async {
    await _deleteImageFromCache();
    _showSnackBar('Uploaded successfully');
    notifyListeners();
  }

  Future _deleteImageFromCache() async {
    final oldProfilePicURL = CurrentUser().userProfilePicURL;
    await CachedNetworkImage.evictFromCache(oldProfilePicURL);
  }

  void _showSnackBar(message) {
    final snackBar = SnackBar(content: Text(message.toString()));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void deleteAccount({onSuccess}) {
    _userRepository
        .deleteAccount(CurrentUser().email)
        .listen((_) => onSuccess())
        .onError(_showSnackBar);
  }

  void updateUserData({onSuccess}) {
    if (_shouldUpdate()) {
      String newUserName = userNameController.text;
      String newBio = bioController.text;
      _userRepository.updateProfileData(newUserName, newBio).listen((response) {
        _showSnackBar(response);
        onSuccess();
      }).onError(_showSnackBar);
    } else if (formKey.currentState.validate())
      _showSnackBar('No changes to update!');
    autoValidate = true;
  }

  bool _shouldUpdate() =>
      formKey.currentState.validate() &&
      (userNameController.text != CurrentUser().userName ||
          bioController.text != CurrentUser().bio);
  @override
  void dispose() {
    userNameController.dispose();
    bioController.dispose();
    super.dispose();
  }
}
