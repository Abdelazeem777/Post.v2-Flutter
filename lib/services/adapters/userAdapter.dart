import 'package:google_sign_in/google_sign_in.dart';
import 'package:post/models/user.dart';

class UserAdapter {
  static User adapt(user) {
    return user is GoogleSignInAccount
        ? _adaptGoogleAccount(user)
        : _adaptFacebookAccount(user);
  }

  static User _adaptGoogleAccount(GoogleSignInAccount user) {
    return User(
      userName: user.displayName,
      userProfilePicURL: user.photoUrl,
      userID: user.id,
      email: user.email,
    );
  }

  static User _adaptFacebookAccount(user) {
    return User(
      userName: user["name"],
      userID: user['id'],
      userProfilePicURL: user["picture"]['data']['url'],
      email: user['email'],
      accessToken: user['accessToken'],
    );
  }
}
