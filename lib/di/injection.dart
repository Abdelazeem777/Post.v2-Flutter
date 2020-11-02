import 'package:post/repositories/otherUsersRepository.dart';
import 'package:post/repositories/userRepository.dart';
import 'package:post/services/alternativeLoginHandler.dart';
import 'package:post/services/facebookLoginHelper.dart';
import 'package:post/services/googleLoginHandler.dart';
import 'package:post/services/networkService.dart';
import 'package:post/services/socketService.dart';
import 'package:post/utils/GalleryPicker.dart';

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  UserRepository get usersRepository => UserRepositoryImpl();

  OtherUsersRepository get otherUsersRepository => OtherUsersRepositoryImpl();

  NetworkService get networkService => NetworkService();

  AlternateLoginHandler get facebookLoginHandler => FaceBookLoginHandler();

  AlternateLoginHandler get googleLoginHandler => GoogleLoginHandler();

  GalleryPicker get galleryImagePicker => GalleryImagePickerImpl();

  SocketService get socketService => SocketService();
}
