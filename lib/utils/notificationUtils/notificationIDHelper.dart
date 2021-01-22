import 'package:post/utils/preferences.dart';

class NotificationIDHelper {
  int _notificationID;
  static final _notificationIDSingleton = NotificationIDHelper._internal();

  NotificationIDHelper._internal();

  factory NotificationIDHelper() => _notificationIDSingleton;

  Future<int> get notificationID async {
    if (_notificationID == null)
      _notificationID = await _getLastNotificationIDFromPrefs() ?? 0;

    _notificationID++;
    return _notificationID;
  }

  Future<int> _getLastNotificationIDFromPrefs() async {
    String lastNotificationID = await Preferences?.getLastNotificationID();
    if (lastNotificationID == null) return null;
    return int.parse(lastNotificationID);
  }

  Future<void> dispose() async {
    await Preferences.setLastNotificationID(this._notificationID.toString());
  }
}
