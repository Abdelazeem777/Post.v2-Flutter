import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/currentUserRepository.dart';
import 'package:rxdart/rxdart.dart';

class CurrentUserRepositoryImpl implements CurrentUserRepository {
  final _remote = Injector().currentUserRepositoryRemote;
  final _local = Injector().currentUserRepositoryLocal as CurrentUserRepository;

  @override
  Stream<void> login(String email, String password) {
    return _remote.login(email, password);
  }

  @override
  Stream<void> singup(User user) {
    return _remote.singup(user);
  }

  @override
  Stream<void> alternateLogin(User user) {
    return _remote.alternateLogin(user);
  }

  @override
  Stream<void> uploadProfilePic(Map<String, String> imageMap) {
    return _remote.uploadProfilePic(imageMap);
  }

  @override
  Stream<String> updateProfileData(String newUserName, String newBio) {
    return _remote.updateProfileData(newUserName, newBio);
  }

  @override
  Stream<String> updateRank(
      String currentUserID, String targetUserID, int oldRank, int newRank) {
    return _remote.updateRank(currentUserID, targetUserID, oldRank, newRank);
  }

  @override
  Stream<void> follow(String currentUserID, String targetUserID, int rank) {
    return _remote.follow(currentUserID, targetUserID, rank);
  }

  @override
  Stream<void> unFollow(String currentUserID, String targetUserID, int rank) {
    return _remote.unFollow(currentUserID, targetUserID, rank);
  }

  @override
  Stream<String> deleteAccount(String email) {
    return _remote.deleteAccount(email);
  }

  @override
  Stream<void> logout() {
    return _remote.logout().flatMap((_) => _local.logout());
  }

  @override
  void dispose() {
    _remote.dispose();
  }
}
