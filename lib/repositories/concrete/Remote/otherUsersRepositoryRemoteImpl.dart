import 'package:post/apiEndpoint.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/otherUsersRepository.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/utils/requestException.dart';

class OtherUsersRepositoryRemoteImpl extends OtherUsersRepository {
  final _networkService = Injector().networkService;
  @override
  Stream<List<User>> searchForUsers(String userName) {
    String userNameParam = '/$userName';
    return Stream.fromFuture(
            _networkService.get(ApiEndPoint.SEARCH_FOR_USERS + userNameParam))
        .map((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        var usersListOfMap = responseMap['usersList'] as List;
        List<User> usersList = _getUsersFromMapList(usersListOfMap);
        return usersList;
      }
    });
  }

  List<User> _getUsersFromMapList(List usersListOfMap) {
    List<User> usersList = usersListOfMap.map((userMap) {
      return User.fromMap(userMap);
    }).toList();
    return usersList;
  }

  @override
  Stream<List<User>> loadFollowersList(String userID) {
    String userIDParam = '/$userID';
    return Stream.fromFuture(
            _networkService.get(ApiEndPoint.LOAD_FOLLOWERS_LIST + userIDParam))
        .map((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        var usersListOfMap = responseMap['usersList'] as List;
        List<User> usersList = _getUsersFromMapList(usersListOfMap);
        _updateCurrentUserFollowersList(usersList);
        return usersList;
      }
    });
  }

  void _updateCurrentUserFollowersList(List<User> usersList) {
    CurrentUser()
      ..followersList = usersList.map<String>((user) => user.userID).toList()
      ..saveUserToPreference().listen((_) {})
      ..notify();
  }

  @override
  Stream<List<User>> loadFollowingList(String userID) {
    String userIDParam = '/$userID';
    return Stream.fromFuture(
            _networkService.get(ApiEndPoint.LOAD_FOLLOWING_LIST + userIDParam))
        .map((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        var usersListJson = responseMap['usersList'] as List;
        List<User> usersList = _getUsersFromMapList(usersListJson);
        _updateCurrentUserFollowingList(usersList);
        return usersList;
      }
    });
  }

  void _updateCurrentUserFollowingList(List<User> usersList) {
    CurrentUser()
      ..followingRankedList =
          usersList.map<String>((user) => user.userID).toList()
      ..saveUserToPreference().listen((_) {})
      ..notify();
  }

  @override
  void dispose() {}
}