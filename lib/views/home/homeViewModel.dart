import 'package:flutter/material.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/post.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';
import 'package:rxdart/rxdart.dart';

class HomePageViewModel with ChangeNotifier, WidgetsBindingObserver {
  var _socketServiceFacade;
  HomePageViewModel() {
    _socketServiceFacade = SocketServiceFacade()..init();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        _socketServiceFacade.reconnect();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        _socketServiceFacade.pause();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _socketServiceFacade.disconnect();
    super.dispose();
  }
}

class HomeTabViewModel with ChangeNotifier {
  final followingUsers = List<User>();
  final postsList = List<Post>();

  final _postsRepository = Injector().postsRepository;
  final _otherUsersRepository = Injector().otherUsersRepository;

  HomeTabViewModel() {
    _fetchFollowingUsersFromRepo().then(
      (_) => _fetchFollowingPostsFromRepo(),
    );
  }

  void _fetchFollowingPostsFromRepo() {
    var usersIDsList = followingUsers.map((user) => user.userID).toList();
    print(usersIDsList);
    _postsRepository.getFollowingUsersPosts(usersIDsList).listen((post) {
      print('new post: ' + post.toString());
      postsList.insert(0, post);
      notifyListeners();
    });
  }

  Future<void> _fetchFollowingUsersFromRepo() async {
    await for (final usersList
        in _otherUsersRepository.loadFollowingList(CurrentUser().userID)) {
      usersList.forEach((user) => followingUsers.add(user));
    }
    notifyListeners();
  }
}

class ProfileTabViewModel with ChangeNotifier {
  final _userRepository = Injector().currentUserRepository;
  final _postsRepository = Injector().postsRepository;

  final postsList = List<Post>();
  ProfileTabViewModel() {
    var currentUserPostsStream = _postsRepository.getCurrentUserPosts();
    currentUserPostsStream.listen((post) {
      _addPostAtFirstIndex(post);
      notifyListeners();
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
