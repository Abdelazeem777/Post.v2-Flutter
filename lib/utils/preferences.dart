import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String _USERDATA = "USER_DATA";
  static const String _NOTIFICATION_ID = "NOTIFICATION_ID";

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

  static Future<String> getLastNotificationID() async {
    final prefs = await SharedPreferences.getInstance();
    String notificationID = prefs.getString(_NOTIFICATION_ID);
    return notificationID;
  }

  static Future<void> setLastNotificationID(String notificationID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_NOTIFICATION_ID, notificationID);
  }

  static Stream<void> clear() {
    return Stream.fromFuture(SharedPreferences.getInstance()).map((prefs) {
      return prefs.clear();
    });
  }
}
