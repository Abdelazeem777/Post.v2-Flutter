import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:post/models/user.dart';
import 'package:post/utils/preferences.dart';

class CurrentUser extends User with ChangeNotifier {
  static final _currentUserSingletone = CurrentUser._internal();

  CurrentUser._internal();

  factory CurrentUser() => _currentUserSingletone;

  ///save currentUser data to preference,
  ///
  ///User parameter is optional, if exist then clone its data to currentUser and then save it
  Stream<void> saveUserToPreference([User user]) {
    if (user != null) _currentUserSingletone.clone(user);

    Map userMap = _currentUserSingletone.toMap();
    String userString = json.encode(userMap);

    return Preferences.setCurrentUserData(userString);
  }

  Future<User> loadCurrentUserDataFromPreference() async {
    await Preferences.getCurrentUserData().then((userDataString) {
      if (userDataString == null) return;
      Map userMap = json.decode(userDataString);
      User user = User.fromMap(userMap);
      _currentUserSingletone.clone(user);
    });
    return _currentUserSingletone;
  }

  Stream<void> logout() => Preferences.clear();

  bool isFollowing(String userID) => followingRankedList.contains(userID);

  void notify() => notifyListeners();

  ///it returns the rank of the input userID (the index inside followingRankedList)
  ///
  ///if this userID is not specified then it will return a rank at the end of the list
  ///(the length of the list to set the new user at the end of the list )
  int getRank([String userID = 'return the last index +1']) {
    int rank = followingRankedList.indexOf(userID);
    return rank != -1 ? rank : _setRankAtTheEndOfFollowingList();
  }

  int _setRankAtTheEndOfFollowingList() => followingRankedList.length;

  void changeRankOfUser(String targetUserID, int oldRank, int newRank) {
    assert(followingRankedList[oldRank] == targetUserID,
        'Not the same targetUser');
    print('oldRank: $oldRank, newRank: $newRank');
    followingRankedList.removeAt(oldRank);
    followingRankedList.insert(newRank, targetUserID);
  }
}
