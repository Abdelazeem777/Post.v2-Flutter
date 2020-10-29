import 'dart:convert';

import 'package:post/models/user.dart';
import 'package:post/utils/preferences.dart';

class CurrentUser extends User {
  static final CurrentUser _currentUserSingletone = CurrentUser._internal();

  CurrentUser._internal();

  factory CurrentUser() => _currentUserSingletone;

  ///save currentUser data to preference,
  ///
  ///User parameter is optional, if exist then clone its data to currentUser and then save it
  Stream<void> saveUserToPreference([User user]) {
    if (user != null) _currentUserSingletone.clone(user);

    Map userMap = _currentUserSingletone.toJson();
    String userString = json.encode(userMap);
    return Preferences.setCurrentUserData(userString);
  }

  Future<User> loadCurrentUserDataFromPreference() async {
    await Preferences.getCurrentUserData().then((userDataString) {
      if (userDataString == null) return;
      Map userMap = json.decode(userDataString);
      User user = User.fromJson(userMap);
      _currentUserSingletone.clone(user);
    });
    return _currentUserSingletone;
  }

  Stream<void> logout() => Preferences.clear();
}
