import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/connectionChecker.dart';
import 'abstract/otherUsersRepository.dart';

class OtherUsersRepositoryImpl extends OtherUsersRepository {
  final _remote = Injector().otherUsersRepositoryRemote;
  final _local = Injector().otherUsersRepositoryLocal as OtherUsersRepository;
  @override
  Stream<User> searchForUsers(String userName) async* {
    if (await _isConnected()) yield* _remote.searchForUsers(userName);
  }

  Future<bool> _isConnected() async =>
      await ConnectionChecker().checkConnection();

  @override
  Stream<User> loadFollowersUsers(String userID) async* {
    if (await _isConnected())
      yield* _remote.loadFollowersUsers(userID);
    else
      yield* _local.loadFollowersUsers(userID);
  }

  @override
  Stream<User> loadFollowingUsers(String userID) async* {
    if (await _isConnected())
      yield* _remote.loadFollowingUsers(userID);
    else
      yield* _local.loadFollowingUsers(userID);
  }

  @override
  void dispose() {
    _remote.dispose();
    _local.dispose();
  }
}
