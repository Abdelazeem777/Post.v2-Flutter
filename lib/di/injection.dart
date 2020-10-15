import 'package:post/repositories/userRepository.dart';
import 'package:post/services/networkService.dart';

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  UserRepository get usersRepository {
    return new UserRepositoryImpl();
  }

  NetworkService get networkService {
    return new NetworkService();
  }
}
