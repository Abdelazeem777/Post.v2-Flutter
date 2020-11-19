import 'package:flutter/material.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';

class FollowersListViewModel with ChangeNotifier {
  var usersList = List<User>();
  final _otherUsersRepository = Injector().otherUsersRepository;
  final _currentUsersRepository = Injector().currentUsersRepository;
  FollowersListViewModel() {
    _otherUsersRepository
        .loadFollowersList(CurrentUser().userID)
        .listen((result) {
      usersList = result;
      notifyListeners();
    });
  }
  void follow(String targetUserID) {
    _currentUsersRepository
        .follow(CurrentUser().userID, targetUserID, CurrentUser().getRank())
        .listen((_) {});
  }

  void unFollow(String targetUserID, int rank) {
    _currentUsersRepository
        .unFollow(CurrentUser().userID, targetUserID, rank)
        .listen((_) {});
  }
}
