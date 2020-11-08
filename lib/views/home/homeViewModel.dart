import 'package:flutter/cupertino.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/otherUsersRepository.dart';
import 'package:post/repositories/currentUserRepository.dart';
import 'package:post/services/currentUser.dart';
import 'package:rxdart/rxdart.dart';

class HomeTabViewModel with ChangeNotifier {}

class ProfileTabViewModel with ChangeNotifier {
  CurrentUserRepository _userRepository;
  ProfileTabViewModel() {
    _userRepository = Injector().currentUsersRepository;
  }
  void logout({Function onLogoutSuccess}) {
    _userRepository.logout().listen((_) {
      onLogoutSuccess();
      notifyListeners();
    });
  }
}

class SearchTabViewModel with ChangeNotifier {
  final searchTextController = TextEditingController();
  var usersList = List<User>();
  OtherUsersRepository _otherUsersRepository;

  SearchTabViewModel() {
    _otherUsersRepository = Injector().otherUsersRepository;
  }

  void onSearchTextChanged(String text) {
    if (text.isNotEmpty)
      _otherUsersRepository.searchForUsers(text).listen((result) {
        usersList = result;
        notifyListeners();
      });
    else {
      usersList = [];
      notifyListeners();
    }
  }

  void follow(String targetUserID) {
    _otherUsersRepository
        .follow(CurrentUser().userID, targetUserID)
        .listen((result) => notifyListeners());
  }

  void unFollow(String targetUserID) {
    _otherUsersRepository
        .unFollow(CurrentUser().userID, targetUserID)
        .listen((result) => notifyListeners());
  }
}
