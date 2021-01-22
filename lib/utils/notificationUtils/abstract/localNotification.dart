import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/enums/notificationTypeEnum.dart';
import 'package:post/models/notificationModel.dart';
import 'package:post/utils/notificationUtils/notificationIDHelper.dart';

import '../localNotificationImpl.dart';

abstract class LocalNotification {
  LocalNotification({
    this.title = 'Post',
    @required this.body,
    @required this.payload,
  });

  String title;
  String body;
  Map payload;

  final _flutterLocalNotificationPlugin =
      Injector().flutterLocalNotificationPlugin;

  Future<void> notify() async {
    int id = await NotificationIDHelper().notificationID;
    return _flutterLocalNotificationPlugin.showNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
    );
  }

  factory LocalNotification.from(NotificationModel notification) {
    String body = notification.notificationContent;
    Map payload = notification.payload;
    LocalNotification localNotification;
    switch (notification.notificationType) {
      case NotificationType.Follow:
        localNotification = FollowNotification(body, payload);
        break;
      case NotificationType.React:
        localNotification = ReactNotification();
        break;
      case NotificationType.Comment:
        localNotification = CommentNotification();
        break;
      case NotificationType.Share:
        localNotification = ShareNotification();
        break;
      default:
        throw Exception('Undefined Notification type');
        break;
    }
    return localNotification;
  }
}
