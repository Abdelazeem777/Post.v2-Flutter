import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post/style/appColors.dart';

abstract class GalleryPicker {
  Future<Map<String, String>> pickUserProfilePic();
}

class GalleryImagePickerImpl implements GalleryPicker {
  ImagePicker _picker = ImagePicker();

  ///return a cropped image in Base64 format with 3 steps:
  ///1. pick the image from gallery using ImagePicker plugin.
  ///2. crop the image by using ImageCropper.
  ///3. convert it to base64 format that the api accept.
  Future<Map<String, String>> pickUserProfilePic() async {
    var pickedImage = await _picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = _getFileFromPath(pickedImage);
      imageFile = await _cropImage(imageFile);
      if (imageFile != null) {
        Map imageInBase64 = _convertImageToBase64(imageFile);
        return imageInBase64;
      }
    }
    throw Exception('user didn\'nt pick an image');
  }

  File _getFileFromPath(PickedFile pickedImage) {
    String pickImagePath = pickedImage.path;
    File imageFile = File(pickImagePath);
    return imageFile;
  }

  Future<File> _cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 80,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop profile picture',
          toolbarColor: AppColors.PRIMARY_COLOR,
          activeControlsWidgetColor: AppColors.SECONDARY_COLOR,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Crop profile picture',
        ));
    return croppedFile;
  }

  Map<String, String> _convertImageToBase64(File imageFile) {
    String base64Image = base64Encode(imageFile.readAsBytesSync());
    String fileName = imageFile.path.split("/").last;
    String ext = fileName.split('.').last;
    return {'base64': base64Image, 'ext': ext};
  }
}
