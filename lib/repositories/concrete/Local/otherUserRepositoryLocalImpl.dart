import 'package:hive/hive.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/baseLocalRepository.dart';
import 'package:post/repositories/abstract/otherUsersRepository.dart';
import 'package:post/repositories/concrete/Local/hiveBoxesConstants.dart';
import 'package:post/services/currentUser.dart';

class OtherUsersRepositoryLocalImpl
    implements OtherUsersRepository, BaseLocalRepository {
  LazyBox<Map> _usersBox;
  final _hiveHelper = Injector().hiveHelper;

  @override
  Stream<User> loadFollowersUsers(String userID) async* {
    _usersBox = await _hiveHelper.getLazyBox(USERS_BOX);
    for (var userID in CurrentUser().followersList) {
      var userMap = await _usersBox.get(userID);
      if (userMap == null) continue;
      userMap = Map<String, dynamic>.from(userMap);
      final user = User.fromMap(userMap);
      yield user;
    }
  }

  @override
  Stream<User> loadFollowingUsers(String userID) async* {
    _usersBox = await _hiveHelper.getLazyBox(USERS_BOX);
    for (var userID in CurrentUser().followingRankedList) {
      var userMap = await _usersBox.get(userID);
      if (userMap == null) continue;
      userMap = Map<String, dynamic>.from(userMap);
      final user = User.fromMap(userMap);
      yield user;
    }
  }

  @override
  Stream<void> updateLocalFromRemote(userMap) async* {
    _usersBox = await _hiveHelper.getLazyBox(USERS_BOX);
    String userID = userMap['userID'];
    if (!_usersBox.containsKey(userID)) await _usersBox.put(userID, userMap);
  }

  @override
  Stream<User> searchForUsers(String userName) => throw UnimplementedError();

  @override
  Future<void> dispose() async {
    var result = await _hiveHelper.closeBox(USERS_BOX);
    if (result)
      return;
    else
      throw Exception('Couldn\'t close the Users Hive box.');
  }
}
