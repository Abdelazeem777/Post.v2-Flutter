import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/otherUsersRepository.dart';

class OtherUsersRepositoryLocalImpl implements OtherUsersRepository {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Stream<List<User>> loadFollowersList(String userID) {
    // TODO: implement loadFollowersList
  }

  @override
  Stream<List<User>> loadFollowingList(String userID) {
    // TODO: implement loadFollowingList
  }

  @override
  Stream<List<User>> searchForUsers(String userName) {
    // TODO: implement searchForUsers
  }
}
