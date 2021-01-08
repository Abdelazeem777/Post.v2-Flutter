import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/connectionChecker.dart';
import 'abstract/otherUsersRepository.dart';

class OtherUsersRepositoryImpl extends OtherUsersRepository {
  final _remote = Injector().otherUsersRepositoryRemote;
  final _local = Injector().otherUsersRepositoryLocal;
  @override
  Stream<User> searchForUsers(String userName) async* {
    if (await _isConnected())
      await for (var user in _remote.searchForUsers(userName)) {
        yield user;
      }
    else
      await for (var user in _local.searchForUsers(userName)) {
        yield user;
      }
  }

  Future<bool> _isConnected() async =>
      await ConnectionChecker().checkConnection();

  @override
  Stream<User> loadFollowersUsers(String userID) async* {
    if (await _isConnected())
      await for (var user in _remote.loadFollowersUsers(userID)) {
        yield user;
      }
    else
      await for (var user in _local.loadFollowersUsers(userID)) {
        yield user;
      }
  }

  @override
  Stream<User> loadFollowingUsers(String userID) async* {
    if (await _isConnected())
      await for (var user in _remote.loadFollowingUsers(userID)) {
        yield user;
      }
    else
      await for (var user in _local.loadFollowingUsers(userID)) {
        yield user;
      }
  }

  @override
  void dispose() {
    _remote.dispose();
    _local.dispose();
  }
}
