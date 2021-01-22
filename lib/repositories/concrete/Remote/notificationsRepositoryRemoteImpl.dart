import 'dart:async';

import 'package:post/apiEndpoint.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/notificationModel.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/baseLocalRepository.dart';
import 'package:post/repositories/abstract/notificationsRepository.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';
import 'package:post/utils/notificationUtils/abstract/localNotification.dart';
import 'package:post/utils/requestException.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsRepositoryRemoteImpl implements NotificationsRepository {
  final _notificationStream = StreamController<Map<NotificationModel, User>>();
  final _networkService = Injector().networkService;

  NotificationsRepositoryRemoteImpl() {
    SocketService()..onNotification = this.onNotification;
  }
  @override
  Stream<Map<NotificationModel, User>> getNotifications() {
    return _getNotificationFromAPI().concatWith([_notificationStream.stream]);
  }

  Stream<Map<NotificationModel, User>> _getNotificationFromAPI() {
    String userIDParam = '/${CurrentUser().userID}';
    return Stream.fromFuture(
            _networkService.get(ApiEndPoint.GET_NOTIFICATIONS + userIDParam))
        .flatMap((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        var notificationsListOfMap = responseMap['notificationsList'] as List;
        var usersListOfMap = responseMap['usersList'] as List;
        var apiNotificationsStream = _getNotificationsAndThereUsersFromMapList(
            notificationsListOfMap, usersListOfMap);
        _addNotificationToLocal(notificationsListOfMap);
        return apiNotificationsStream;
      }
    });
  }

  Stream<Map<NotificationModel, User>>
      _getNotificationsAndThereUsersFromMapList(
          List notificationsListOfMap, List usersListOfMap) async* {
    for (var notificationMap in notificationsListOfMap) {
      final notification = NotificationModel.fromMap(notificationMap);
      final userMap = usersListOfMap.firstWhere(
          (userMap) => userMap['userID'] == notification.fromUserID);
      final user = User.fromMap(userMap);
      yield {notification: user};
    }
  }

  @override
  Stream<bool> markAsSeen() {
    // TODO: implement markAsSeen
    throw UnimplementedError();
  }

  ///The parameter is a Map {NotificationMap:UserMap}
  void onNotification(data) {
    var notificationMap = data.first;
    var userMap = data.last;
    print(data);
    _pushNotification(notificationMap);
    _addNotificationToNotificationStream(notificationMap, userMap);
    _addNotificationToLocal(notificationMap);
  }

  void _pushNotification(notificationMap) {
    final notificationModel = NotificationModel.fromMap(notificationMap);
    final notification = LocalNotification.from(notificationModel);
    notification.notify();
  }

  void _addNotificationToNotificationStream(notificationMap, userMap) {
    final notificationModel = NotificationModel.fromMap(notificationMap);
    final user = User.fromMap(userMap);
    _notificationStream.add({notificationModel: user});
  }

  void _addNotificationToLocal(data) {
    final BaseLocalRepository _local = Injector().notificationsRepositoryLocal;
    if (data is Map)
      _local.updateLocalFromRemote(data).listen((_) {});
    else
      for (var notificationMap in data) {
        _local.updateLocalFromRemote(notificationMap).listen((_) {});
      }
  }

  void dispose() {
    _notificationStream.close();
  }
}
