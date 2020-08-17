import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String _USERDATA = "USER_DATA";

  static Future<String> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_USERDATA);
  }

  static Stream<void> setUserData(String userData) {
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
