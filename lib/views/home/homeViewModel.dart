import 'package:flutter/material.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/post.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/otherUsersRepository.dart';
import 'package:post/repositories/currentUserRepository.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';
import 'package:rxdart/rxdart.dart';

class HomePageViewModel with ChangeNotifier, WidgetsBindingObserver {
  final _userRepository = Injector().currentUserRepository;
  final _postsRepository = Injector().postsRepository;
  final _socketService = SocketService();
  HomePageViewModel() {
    _socketService.connect();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        _socketService.reconnect();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _socketService.disconnect();
    super.dispose();
  }
}

class HomeTabViewModel with ChangeNotifier {}

class ProfileTabViewModel with ChangeNotifier {
  final _userRepository = Injector().currentUserRepository;
  final _postsRepository = Injector().postsRepository;

  final postsList = List<Post>();
  ProfileTabViewModel() {
    var currentUserPostsStream = _postsRepository.getCurrentUserPosts();
    currentUserPostsStream.listen((post) {
      print('new post is added: $post');
      _addPostAtFirstIndex(post);
      notifyListeners();
    }).onDone(() {
      print('stream is done');
    });
  }

  void _addPostAtFirstIndex(Post post) {
    this.postsList.insert(0, post);
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
  final _currentUsersRepository = Injector().currentUserRepository;

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
