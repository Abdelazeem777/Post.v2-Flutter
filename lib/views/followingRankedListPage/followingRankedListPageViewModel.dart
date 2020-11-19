import 'package:flutter/cupertino.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';

class FollowingRankedListViewModel with ChangeNotifier {
  var usersMap = Map<int, User>();
  final _otherUsersRepository = Injector().otherUsersRepository;
  final _currentUsersRepository = Injector().currentUsersRepository;

  FollowingRankedListViewModel() {
    _otherUsersRepository
        .loadFollowingList(CurrentUser().userID)
        .listen((result) {
      usersMap = result;
      notifyListeners();
    });
  }
  void reorder(int oldIndex, int newIndex) {}
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
