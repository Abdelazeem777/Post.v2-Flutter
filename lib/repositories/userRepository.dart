import 'package:http/http.dart';
import 'package:post/apiEndpoint.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/networkService.dart';
import 'package:post/utils/requestException.dart';
import 'package:rxdart/rxdart.dart';

abstract class UserRepository {
  Stream<void> login(String email, String password);
  Stream<void> singup(User user);
  Stream<void> alternateLogin(User user);
  Stream<void> logout();
}

class UserRepositoryImpl implements UserRepository {
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
    Map userMap = user.toJson()
      ..remove("userID") //to change userID key to _id
      ..addAll({"_id": user.userID});

    String userJson = _networkService.convertMapToJson(userMap);
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

  @override
  Stream<void> logout() {
    return CurrentUser().logout();
  }
}
