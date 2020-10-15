import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String _USERDATA = "USER_DATA";

  static Future<String> getCurrentUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataString = prefs.getString(_USERDATA);
    return userDataString;
  }

  static Stream<void> setCurrentUserData(String userData) {
    return Stream.fromFuture(SharedPreferences.getInstance()).map((prefs) {
      return prefs.setString(_USERDATA, userData);
    });
  }

  static Stream<void> clear() {
    return Stream.fromFuture(SharedPreferences.getInstance()).map((prefs) {
      return prefs.clear();
    });
  }
}
