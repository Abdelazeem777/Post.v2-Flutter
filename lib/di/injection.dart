import 'package:post/repositories/userRepository.dart';
import 'package:post/services/alternativeLoginHandler.dart';
import 'package:post/services/facebookLoginHelper.dart';
import 'package:post/services/googleLoginHandler.dart';
import 'package:post/services/networkService.dart';

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  UserRepository get usersRepository => UserRepositoryImpl();

  NetworkService get networkService => NetworkService();

  AlternateLoginHandler get facebookLoginHandler => FaceBookLoginHandler();

  AlternateLoginHandler get googleLoginHandler => GoogleLoginHandler();
}
