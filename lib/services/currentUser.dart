import 'dart:convert';

import 'package:post/models/user.dart';
import 'package:post/utils/preferences.dart';

class CurrentUser extends User {
  static final CurrentUser _currentUserSingletone = CurrentUser._internal();

  CurrentUser._internal();

  factory CurrentUser() => _currentUserSingletone;

  Stream<void> saveUserToPreference(User user) {
    _cloneToCurrentUserSingletone(user);
    return Preferences.setCurrentUserData(json.encode(user.toJson()));
  }

  Future<User> loadCurrentUserDataFromPreference() async {
    await Preferences.getCurrentUserData().then((userDataString) {
      if (userDataString == null) return;
      Map userMap = json.decode(userDataString);
      User user = User.fromJson(userMap);
      _cloneToCurrentUserSingletone(user);
    });
    return _currentUserSingletone;
  }

  Stream<void> logout() => Preferences.clear();

  void _cloneToCurrentUserSingletone(User user) {
    _currentUserSingletone.active = user.active;
    _currentUserSingletone.bio = user.bio;
    _currentUserSingletone.followersList = user.followersList;
    _currentUserSingletone.followingRankedList = user.followingRankedList;
    _currentUserSingletone.postsList = user.postsList;
    _currentUserSingletone.userID = user.userID;
    _currentUserSingletone.userName = user.userName;
    _currentUserSingletone.userProfilePicURL = user.userProfilePicURL;
  }
}
