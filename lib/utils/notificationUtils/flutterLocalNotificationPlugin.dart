import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

///Not allowed to use this plugin class directly from here,
///
///use [LocalNotification] class instead.
class FlutterLocalNotificationPlugin {
  BuildContext context;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Future<void> init(BuildContext context) async {
    this.context = context;
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('post_logo');
    final initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final initializationSettingsMacOS = MacOSInitializationSettings();
    final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future _onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    runApp(MyApp());
  }

  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    runApp(MyApp());
  }

  Future<void> showNotification({
    @required int id,
    @required String title,
    @required String body,
    @required Map payload,
  }) async {
    const groupKey = 'com.android.example.WORK_EMAIL';
    const groupChannelId = 'grouped channel id';
    const groupChannelName = 'grouped channel name';
    const groupChannelDescription = 'grouped channel description';

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        groupChannelId, groupChannelName, groupChannelDescription,
        importance: Importance.max,
        priority: Priority.max,
        showWhen: false,
        groupKey: groupKey);
    const iosPlatformChannelSpecifics = IOSNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload.toString(),
    );
  }
}
