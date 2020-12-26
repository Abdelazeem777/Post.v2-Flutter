import 'package:flutter/cupertino.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';

class FollowingRankedListViewModel with ChangeNotifier {
  var usersList = List<User>();
  final _otherUsersRepository = Injector().otherUsersRepository;
  final _currentUsersRepository = Injector().currentUserRepository;

  FollowingRankedListViewModel() {
    _otherUsersRepository
        .loadFollowingList(CurrentUser().userID)
        .listen((result) {
      usersList = result;
      notifyListeners();
    });
  }
  void reorder(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;
    if (newIndex > oldIndex) newIndex -= 1;
    print('oldRank: $oldIndex, newRank: $newIndex');
    final currentUserID = CurrentUser().userID;
    final targetUserID = CurrentUser().followingRankedList[oldIndex];
    _currentUsersRepository
        .updateRank(currentUserID, targetUserID, oldIndex, newIndex)
        .listen(print);
    _updateUsersListWithTheNewRank(oldIndex, newIndex);
  }

  void _updateUsersListWithTheNewRank(int oldIndex, int newIndex) {
    final targetUser = usersList.removeAt(oldIndex);
    usersList.insert(newIndex, targetUser);
    notifyListeners();
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
