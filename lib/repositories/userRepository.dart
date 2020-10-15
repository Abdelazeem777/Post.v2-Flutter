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
  Stream<void> singup(Map userData);
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
  Stream<void> singup(Map userData) {
    String userJson = _networkService.convertMapToJson(userData);
    return Stream.fromFuture(
            _networkService.post(ApiEndPoint.SIGN_UP, userJson))
        .flatMap((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        return login(userData["email"], userData["password"]);
      }
    });
  }

  @override
  Stream<void> logout() {
    return CurrentUser().logout();
  }
}
