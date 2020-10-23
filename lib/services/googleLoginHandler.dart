import 'package:google_sign_in/google_sign_in.dart';
import 'package:post/di/injection.dart';

import 'package:post/models/user.dart';
import 'package:post/repositories/userRepository.dart';
import 'package:post/services/alternativeLoginHandler.dart';

import 'userAdapter.dart';

class GoogleLoginHandler extends AlternateLoginHandler {
  final UserRepository _userRepository = Injector().usersRepository;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void login({Function onLoginSuccess}) {
    _googleSignIn.signIn().then((googleUser) {
      User user = UserAdapter.adapt(googleUser);

      _userRepository.alternateLogin(user).listen((_) {
        onLoginSuccess();
      }).onError((err) => print(err));
    });
  }
}
