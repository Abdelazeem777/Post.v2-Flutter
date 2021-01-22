import 'package:post/apiEndpoint.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/baseLocalRepository.dart';
import 'package:post/repositories/abstract/otherUsersRepository.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/utils/requestException.dart';
import 'package:rxdart/rxdart.dart';

class OtherUsersRepositoryRemoteImpl implements OtherUsersRepository {
  final _networkService = Injector().networkService;
  @override
  Stream<User> searchForUsers(String userName) {
    String userNameParam = '/$userName';
    return Stream.fromFuture(
            _networkService.get(ApiEndPoint.SEARCH_FOR_USERS + userNameParam))
        .flatMap((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        var usersListOfMap = responseMap['usersList'] as List;
        var usersStream = _getUsersFromMapList(usersListOfMap);
        return usersStream;
      }
    });
  }

  Stream<User> _getUsersFromMapList(List usersListOfMap) async* {
    if (usersListOfMap.isEmpty) {
      yield null;
      return;
    }
    for (var userMap in usersListOfMap) {
      yield User.fromMap(userMap);
    }
  }

  @override
  Stream<User> loadFollowersUsers(String userID) {
    String userIDParam = '/$userID';
    return Stream.fromFuture(
            _networkService.get(ApiEndPoint.LOAD_FOLLOWERS_USERS + userIDParam))
        .flatMap((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        var usersListOfMap = responseMap['usersList'] as List;
        var usersStream =
            _getUsersFromMapList(usersListOfMap).asBroadcastStream();
        _updateCurrentUserFollowersList(usersListOfMap);
        _addUsersToLocal(usersListOfMap);
        return usersStream;
      }
    });
  }

  void _updateCurrentUserFollowersList(List usersList) {
    CurrentUser()
      ..followersList = usersList.map<String>((user) => user['userID']).toList()
      ..saveUserToPreference().listen((_) {})
      ..notify();
  }

  void _addUsersToLocal(List usersListOfMap) {
    BaseLocalRepository local = Injector().otherUsersRepositoryLocal;

    for (var user in usersListOfMap) {
      local.updateLocalFromRemote(user).listen((_) {});
    }
  }

  @override
  Stream<User> loadFollowingUsers(String userID) {
    String userIDParam = '/$userID';
    return Stream.fromFuture(
            _networkService.get(ApiEndPoint.LOAD_FOLLOWING_USERS + userIDParam))
        .flatMap((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        var usersListMap = responseMap['usersList'] as List;
        var usersStream =
            _getUsersFromMapList(usersListMap).asBroadcastStream();
        _updateCurrentUserFollowingList(usersListMap);
        _addUsersToLocal(usersListMap);
        return usersStream;
      }
    });
  }

  void _updateCurrentUserFollowingList(List usersList) {
    CurrentUser()
      ..followingRankedList =
          usersList.map<String>((user) => user['userID']).toList()
      ..saveUserToPreference().listen((_) {})
      ..notify();
  }

  @override
  void dispose() {}
}
