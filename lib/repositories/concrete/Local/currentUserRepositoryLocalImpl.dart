import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/baseLocalRepository.dart';
import 'package:post/repositories/abstract/currentUserRepository.dart';

class CurrentUserRepositoryLocalImpl
    implements BaseLocalRepository, CurrentUserRepository {
  final _hiveHelper = Injector().hiveHelper;

  @override
  Stream<void> singup(User user) => throw UnimplementedError();

  @override
  Stream<void> unFollow(String currentUserID, String targetUserID, int rank) =>
      throw UnimplementedError();

  @override
  Stream<String> updateProfileData(String newUserName, String newBio) =>
      throw UnimplementedError();

  @override
  Stream<String> updateRank(String currentUserID, String targetUserID,
          int oldRank, int newRank) =>
      throw UnimplementedError();

  @override
  Stream<void> uploadProfilePic(Map<String, String> imageMap) =>
      throw UnimplementedError();

  @override
  Stream<void> alternateLogin(User user) => throw UnimplementedError();

  @override
  Stream<String> deleteAccount(String email) => throw UnimplementedError();

  @override
  Stream<void> follow(String currentUserID, String targetUserID, int rank) =>
      throw UnimplementedError();

  @override
  Stream<void> login(String email, String password) =>
      throw UnimplementedError();

  @override
  Stream<void> logout() => Stream.fromFuture(_hiveHelper.deleteAllDB());

  @override
  Stream<void> updateLocalFromRemote(data) => throw UnimplementedError();

  @override
  void dispose() => throw UnimplementedError();
}
