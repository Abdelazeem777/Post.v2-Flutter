import 'package:post/models/notificationModel.dart';
import 'package:post/models/user.dart';

abstract class NotificationsRepository {
  Stream<Map<NotificationModel, User>> getNotifications();
  Stream<bool> markAsSeen();
  void dispose() {}
}
