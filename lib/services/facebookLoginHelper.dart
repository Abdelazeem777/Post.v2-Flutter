import 'dart:convert';

import 'package:http/src/response.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/userRepository.dart';
import 'package:post/services/alternativeLoginHandler.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:post/services/networkService.dart';
import 'userAdapter.dart';

class FaceBookLoginHandler extends AlternateLoginHandler {
  final UserRepository _userRepository = Injector().usersRepository;
  final facebookLogin = FacebookLogin();
  final _networkService = Injector().networkService;
  @override
  Future<void> login({Function onLoginSuccess}) async {
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        await doOnLoggedInStatus(result, onLoginSuccess);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("canceled from user");
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  Future doOnLoggedInStatus(
      FacebookLoginResult result, Function onLoginSuccess) async {
    String token = result.accessToken.token;
    final graphResponse = await _networkService.get(
        'https://graph.facebook.com/v2.12/me?fields=name,email,picture.type(large)&access_token=$token');

    User user = getUserFromFacebookResponseBody(graphResponse, token);

    _userRepository.alternateLogin(user).listen((_) {
      onLoginSuccess();
    }).onError((err) => print(err));
  }

  User getUserFromFacebookResponseBody(Response graphResponse, String token) {
    final facebookUserStringJSON = graphResponse.body;
    Map<String, dynamic> userMap =
        _networkService.convertJsonToMap(facebookUserStringJSON);
    userMap.addAll({"accessToken": token});
    print(userMap);
    User user = UserAdapter.adapt(userMap);
    return user;
  }
}
