import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'abstract/otherUsersRepository.dart';

class OtherUsersRepositoryImpl extends OtherUsersRepository {
  OtherUsersRepository _remote;
  OtherUsersRepositoryImpl() {
    _remote = Injector().otherUsersRepositoryRemote;
  }
  @override
  Stream<List<User>> searchForUsers(String userName) {
    return _remote.searchForUsers(userName);
  }

  @override
  Stream<List<User>> loadFollowersList(String userID) {
    return _remote.loadFollowersList(userID);
  }

  @override
  Stream<List<User>> loadFollowingList(String userID) {
    return _remote.loadFollowingList(userID);
  }

  @override
  void dispose() {
    _remote.dispose();
  }
}
