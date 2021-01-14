import 'package:flutter/material.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/post.dart';
import 'package:post/models/user.dart';
import 'package:post/services/connectionChecker.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';

class HomePageViewModel with ChangeNotifier, WidgetsBindingObserver {
  SocketServiceFacade _socketServiceFacade;
  bool _currentConnectionState = ConnectionChecker().hasConnection;
  HomePageViewModel() {
    _socketServiceFacade = SocketServiceFacade()..init();
    WidgetsBinding.instance.addObserver(this);

    ConnectionChecker().connectionChange.listen(_onConnectionStateChanged);
  }

  void _onConnectionStateChanged(bool isConnected) {
    if (_currentConnectionState == false && isConnected == true)
      notifyListeners();
    _currentConnectionState = isConnected;
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
    _socketServiceFacade.destroy();
    super.dispose();
  }
}

class HomeTabViewModel with ChangeNotifier {
  final followingUsers = List<User>();
  final postsList = List<Post>();

  final _postsRepository = Injector().postsRepository;
  final _otherUsersRepository = Injector().otherUsersRepository;

  HomeTabViewModel() {
    _fetchFollowingUsersAndPosts();
    ConnectionChecker().connectionChange.listen((connectionStatus) {
      if (connectionStatus) _fetchFollowingUsersAndPosts();
    });
  }

  void _fetchFollowingUsersAndPosts() {
    postsList.clear();
    _fetchFollowingUsers().then((_) => _fetchPosts());
  }

  Future<void> _fetchFollowingUsers() async {
    var fetFollowingUsersStream =
        _otherUsersRepository.loadFollowingUsers(CurrentUser().userID);
    await for (final user in fetFollowingUsersStream) {
      if (!followingUsers.contains(user)) followingUsers.add(user);
    }
  }

  void _fetchPosts() {
    var usersIDsList = followingUsers.map((user) => user.userID).toList();
    _postsRepository.getFollowingUsersPosts(usersIDsList).listen((post) {
      if (!postsList.contains(post)) postsList.insert(0, post);
      notifyListeners();
    });
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
  final usersList = List<User>();
  final _otherUsersRepository = Injector().otherUsersRepository;
  final _currentUsersRepository = Injector().currentUserRepository;

  void onSearchTextChanged(String text) {
    usersList.clear();
    if (text.isNotEmpty)
      _otherUsersRepository
          .searchForUsers(text)
          .listen(_addUserToSearchList)
          .onDone(notifyListeners);
    else
      notifyListeners();
  }

  void _addUserToSearchList(User user) {
    if (user == null)
      usersList.clear();
    else if (!usersList.contains(user)) {
      usersList.add(user);
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
