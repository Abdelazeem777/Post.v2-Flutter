import 'package:post/apiEndpoint.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/networkService.dart';
import 'package:post/utils/requestException.dart';
import 'package:rxdart/rxdart.dart';

abstract class CurrentUserRepository {
  Stream<void> login(String email, String password);
  Stream<void> singup(User user);
  Stream<void> alternateLogin(User user);
  Stream<String> deleteAccount(String email);
  Stream<void> logout();
  Stream<void> uploadProfilePic(Map<String, String> imageMap);
  Stream<String> updateProfileData(String newUserName, String newBio);
}

class CurrentUserRepositoryImpl implements CurrentUserRepository {
  final NetworkService _networkService = Injector().networkService;
  @override
  Stream<void> login(String email, String password) {
    Map data = {'email': email, 'password': password};
    String jsonData = _networkService.convertMapToJson(data);
    return Stream.fromFuture(_networkService.post(ApiEndPoint.LOGIN, jsonData))
        .flatMap((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        User user = User.fromJson(responseMap);
        return CurrentUser().saveUserToPreference(user);
      }
    });
  }

  @override
  Stream<void> singup(User user) {
    String userJson = _networkService.convertMapToJson(user.toJson());
    return Stream.fromFuture(
            _networkService.post(ApiEndPoint.SIGN_UP, userJson))
        .flatMap((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        return login(user.email, user.password);
      }
    });
  }

  @override
  Stream<void> alternateLogin(User user) {
    String userJson = changeUserIDKeyTo_id(user);
    return Stream.fromFuture(
            _networkService.post(ApiEndPoint.ALTERNATE_LOGIN, userJson))
        .flatMap((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        User user = User.fromJson(responseMap);
        return CurrentUser().saveUserToPreference(user);
      }
    });
  }

  String changeUserIDKeyTo_id(User user) {
    Map userMap = user.toJson()
      ..remove("userID") //to change userID key to _id
      ..addAll({"_id": user.userID});

    String userJson = _networkService.convertMapToJson(userMap);
    return userJson;
  }

  @override
  Stream<String> deleteAccount(String email) {
    String emailParam = '/$email';
    return Stream.fromFuture(
            _networkService.delete(ApiEndPoint.DELETE_ACCOUNT + emailParam))
        .flatMap((response) {
      if (response.statusCode != 200 || null == response.statusCode) {
        Map responseMap = _networkService.convertJsonToMap(response.body);
        throw new RequestException(responseMap["message"]);
      } else {
        return logout().map((_) {
          return response.body.toString();
        });
      }
    });
  }

  @override
  Stream<void> logout() {
    return CurrentUser().logout();
  }

  @override
  Stream<void> uploadProfilePic(Map<String, String> imageMap) {
    imageMap.addAll({'userID': CurrentUser().userID});
    String imageJson = _networkService.convertMapToJson(imageMap);
    return Stream.fromFuture(
            _networkService.post(ApiEndPoint.UPLOAD_PROFILE_PIC, imageJson))
        .flatMap((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        CurrentUser().userProfilePicURL = User()
            .fixUserProfilePicURLIfNeeded(responseMap['userProfilePicURL']);
        return CurrentUser().saveUserToPreference();
      }
    });
  }

  @override
  Stream<String> updateProfileData(String newUserName, String newBio) {
    var newProfileDataMap = {
      'userID': CurrentUser().userID,
      'userName': newUserName,
      'bio': newBio
    };
    var newProfileData = _networkService.convertMapToJson(newProfileDataMap);
    return Stream.fromFuture(_networkService.patch(
            ApiEndPoint.UPDATE_PROFILE_DATA, newProfileData))
        .flatMap((response) {
      if (response.statusCode != 200 || null == response.statusCode) {
        Map responseMap = _networkService.convertJsonToMap(response.body);
        throw new RequestException(responseMap["message"]);
      } else {
        CurrentUser()
          ..userName = newUserName
          ..bio = newBio;
        return CurrentUser().saveUserToPreference().map((_) {
          return response.body.toString();
        });
      }
    });
  }
}
