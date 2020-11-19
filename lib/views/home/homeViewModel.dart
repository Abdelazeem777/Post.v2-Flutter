import 'package:flutter/material.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/otherUsersRepository.dart';
import 'package:post/repositories/currentUserRepository.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';
import 'package:rxdart/rxdart.dart';

class HomePageViewModel with ChangeNotifier, WidgetsBindingObserver {
  final _socketService = SocketService();
  final _userRepository = Injector().currentUsersRepository;

  HomePageViewModel() {
    _socketService.connect();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        _socketService.disconnect();
        break;
      case AppLifecycleState.resumed:
        _socketService.connect();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  @override
  void dispose() {
    _socketService.disconnect();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

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
  final _otherUsersRepository = Injector().otherUsersRepository;
  final _currentUsersRepository = Injector().currentUsersRepository;

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
    _currentUsersRepository
        .follow(CurrentUser().userID, targetUserID, CurrentUser().getRank())
        .listen((result) => notifyListeners());
  }

  void unFollow(String targetUserID, int rank) {
    _currentUsersRepository
        .unFollow(CurrentUser().userID, targetUserID, rank)
        .listen((result) => notifyListeners());
  }
}
