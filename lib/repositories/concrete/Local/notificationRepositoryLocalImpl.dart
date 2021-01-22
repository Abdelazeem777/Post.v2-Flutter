import 'package:hive/hive.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/notificationModel.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/baseLocalRepository.dart';
import 'package:post/repositories/abstract/notificationsRepository.dart';

import 'hiveBoxesConstants.dart';

class NotificationsRepositoryLocalImpl
    implements BaseLocalRepository, NotificationsRepository {
  LazyBox<Map> _notificationsBox;
  final _hiveHelper = Injector().hiveHelper;
  //TODO: get users from usersBox
  @override
  Stream<Map<NotificationModel, User>> getNotifications() async* {
    _notificationsBox = await _hiveHelper.getLazyBox(NOTIFICATIONS_BOX);

    for (int i = 0; i < 30; i++) {
      var notificationMap = await _notificationsBox.getAt(i);
      if (notificationMap == null) continue;
      notificationMap = Map<String, dynamic>.from(notificationMap);
      final notification = NotificationModel.fromMap(notificationMap);
      yield {notification: null};
    }
  }

  @override
  Stream<bool> markAsSeen() {
    // TODO: implement markAsSeen
    throw UnimplementedError();
  }

  @override
  Stream<void> updateLocalFromRemote(newNotification) async* {
    _notificationsBox = await _hiveHelper.getLazyBox(NOTIFICATIONS_BOX);
    final notificationID = newNotification['notificationID'];
    if (!_notificationsBox.containsKey(notificationID))
      await _notificationsBox.put(notificationID, newNotification);
    await _deleteOldestNotification();
  }

  ///The limit of Notification Box is 30 notification
  ///
  ///so if the box limits exceed that number we will just remove oldest one.
  Future _deleteOldestNotification() async {
    if (_notificationsBox.length > 30) await _notificationsBox.deleteAt(0);
  }

  @override
  Future<void> dispose() async {
    var result = await _hiveHelper.closeBox(NOTIFICATIONS_BOX);
    if (result)
      return;
    else
      throw Exception('Couldn\'t close the Users Hive box.');
  }
}
