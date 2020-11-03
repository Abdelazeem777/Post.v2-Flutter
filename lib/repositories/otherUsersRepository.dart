import 'package:post/apiEndpoint.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/networkService.dart';
import 'package:post/utils/requestException.dart';
import 'package:rxdart/rxdart.dart';

abstract class OtherUsersRepository {
  Stream<List<User>> searchForUsers(String userName);
  Stream<String> follow(String currentUserID, String targetUserID);
  Stream<String> unFollow(String currentUserID, String targetUserID);
}

class OtherUsersRepositoryImpl extends OtherUsersRepository {
  final NetworkService _networkService = Injector().networkService;
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
        var usersListOfJson = responseMap['usersList'] as List;
        List<User> usersList = _getUsersFromJsonList(usersListOfJson);
        return usersList;
      }
    });
  }

  List<User> _getUsersFromJsonList(List usersListOfJson) {
    List<User> usersList = usersListOfJson.map((userJson) {
      return User.fromJson(userJson);
    }).toList();
    return usersList;
  }

  @override
  Stream<String> follow(String currentUserID, String targetUserID) {
    final data = {'currentUserID': currentUserID, 'targetUserID': targetUserID};
    final dataJson = _networkService.convertMapToJson(data);
    return Stream.fromFuture(
            _networkService.patch(ApiEndPoint.FOLLOW, dataJson))
        .flatMap((response) {
      if (response.statusCode != 200 || null == response.statusCode) {
        Map responseMap = _networkService.convertJsonToMap(response.body);
        throw new RequestException(responseMap["message"]);
      } else {
        CurrentUser().followingRankedList.add(targetUserID);
        return CurrentUser()
            .saveUserToPreference()
            .map((_) => response.body.toString());
      }
    });
  }

  @override
  Stream<String> unFollow(String currentUserID, String targetUserID) {
    final data = {'currentUserID': currentUserID, 'targetUserID': targetUserID};
    final dataJson = _networkService.convertMapToJson(data);
    return Stream.fromFuture(
            _networkService.patch(ApiEndPoint.UNFOLLOW, dataJson))
        .flatMap((response) {
      if (response.statusCode != 200 || null == response.statusCode) {
        Map responseMap = _networkService.convertJsonToMap(response.body);
        throw new RequestException(responseMap["message"]);
      } else {
        CurrentUser().followingRankedList.remove(targetUserID);
        return CurrentUser()
            .saveUserToPreference()
            .map((_) => response.body.toString());
      }
    });
  }
}
