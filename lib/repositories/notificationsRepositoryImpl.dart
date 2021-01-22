import 'package:post/di/injection.dart';
import 'package:post/models/notificationModel.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/notificationsRepository.dart';
import 'package:post/services/connectionChecker.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final _remote = Injector().notificationsRepositoryRemote;
  final _local =
      Injector().notificationsRepositoryLocal as NotificationsRepository;
  @override
  Stream<Map<NotificationModel, User>> getNotifications() async* {
    if (await _isConnected())
      yield* _remote.getNotifications();
    else
      yield* _local.getNotifications();
  }

  @override
  Stream<bool> markAsSeen() {
    return _remote.markAsSeen().flatMap((_) => _local.markAsSeen());
  }

  Future<bool> _isConnected() async =>
      await ConnectionChecker().checkConnection();

  @override
  void dispose() {
    _remote.dispose();
    _local.dispose();
  }
}
