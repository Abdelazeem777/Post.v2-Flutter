import 'package:post/repositories/abstract/currentUserRepository.dart';
import 'package:post/repositories/abstract/notificationsRepository.dart';
import 'package:post/repositories/abstract/otherUsersRepository.dart';
import 'package:post/repositories/abstract/postsRepository.dart';
import 'package:post/repositories/concrete/Local/currentUserRepositoryLocalImpl.dart';
import 'package:post/repositories/concrete/Local/notificationRepositoryLocalImpl.dart';
import 'package:post/repositories/concrete/Local/otherUserRepositoryLocalImpl.dart';
import 'package:post/repositories/concrete/Local/postsRepositoryLocalImpl.dart';
import 'package:post/repositories/concrete/Remote/currentUserRepositoryRemoteImpl.dart';
import 'package:post/repositories/concrete/Remote/notificationsRepositoryRemoteImpl.dart';
import 'package:post/repositories/concrete/Remote/otherUsersRepositoryRemoteImpl.dart';
import 'package:post/repositories/concrete/Remote/postsRepositoryRemoteImpl.dart';
import 'package:post/repositories/currentUserRepositoryImpl.dart';
import 'package:post/repositories/notificationsRepositoryImpl.dart';
import 'package:post/repositories/otherUsersRepositoryImpl.dart';
import 'package:post/repositories/postsRepositoryImpl.dart';
import 'package:post/services/abstract/hiveHelper.dart';
import 'package:post/services/alternativeLoginHandler.dart';
import 'package:post/services/facebookLoginHelper.dart';
import 'package:post/utils/notificationUtils/flutterLocalNotificationPlugin.dart';
import 'package:post/services/googleLoginHandler.dart';
import 'package:post/services/hiveHelperImpl.dart';
import 'package:post/services/networkService.dart';
import 'package:post/utils/GalleryPicker.dart';

///Implementing
///
///[Flyweight] design pattern
///
///to save specific objects from recreation
class Injector {
  static final _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();
  static final _flyweightMap = <String, dynamic>{};

  CurrentUserRepository get currentUserRepository {
    var currentUserRepository = _flyweightMap['currentUserRepository'];
    if (currentUserRepository == null) {
      currentUserRepository = CurrentUserRepositoryImpl();
      _flyweightMap..addAll({'currentUserRepository': currentUserRepository});
    }
    return currentUserRepository;
  }

  OtherUsersRepository get otherUsersRepository {
    var otherUsersRepository = _flyweightMap['otherUsersRepository'];
    if (otherUsersRepository == null) {
      otherUsersRepository = OtherUsersRepositoryImpl();
      _flyweightMap..addAll({'otherUsersRepository': otherUsersRepository});
    }
    return otherUsersRepository;
  }

  PostsRepository get postsRepository {
    var postsRepository = _flyweightMap['postsRepository'];
    if (postsRepository == null) {
      postsRepository = PostsRepositoryImpl();
      _flyweightMap..addAll({'postsRepository': postsRepository});
    }
    return postsRepository;
  }

  NotificationsRepository get notificationsRepository {
    var notificationsRepository = _flyweightMap['notificationsRepository'];
    if (notificationsRepository == null) {
      notificationsRepository = NotificationsRepositoryImpl();
      _flyweightMap
        ..addAll({'notificationsRepository': notificationsRepository});
    }
    return notificationsRepository;
  }

  //Remote repositories
  CurrentUserRepository get currentUserRepositoryRemote {
    var currentUserRepositoryRemote =
        _flyweightMap['currentUserRepositoryRemote'];
    if (currentUserRepositoryRemote == null) {
      currentUserRepositoryRemote = CurrentUserRepositoryRemoteImpl();
      _flyweightMap
        ..addAll({'currentUserRepositoryRemote': currentUserRepositoryRemote});
    }
    return currentUserRepositoryRemote;
  }

  OtherUsersRepository get otherUsersRepositoryRemote {
    var otherUsersRepositoryRemote =
        _flyweightMap['otherUsersRepositoryRemote'];
    if (otherUsersRepositoryRemote == null) {
      otherUsersRepositoryRemote = OtherUsersRepositoryRemoteImpl();
      _flyweightMap
        ..addAll({'otherUsersRepositoryRemote': otherUsersRepositoryRemote});
    }
    return otherUsersRepositoryRemote;
  }

  PostsRepository get postsRepositoryRemote {
    var postsRepositoryRemote = _flyweightMap['postsRepositoryRemote'];
    if (postsRepositoryRemote == null) {
      postsRepositoryRemote = PostsRepositoryRemoteImpl();
      _flyweightMap..addAll({'postsRepositoryRemote': postsRepositoryRemote});
    }
    return postsRepositoryRemote;
  }

  NotificationsRepository get notificationsRepositoryRemote {
    var notificationsRepositoryRemote =
        _flyweightMap['notificationsRepositoryRemote'];
    if (notificationsRepositoryRemote == null) {
      notificationsRepositoryRemote = NotificationsRepositoryRemoteImpl();
      _flyweightMap
        ..addAll(
            {'notificationsRepositoryRemote': notificationsRepositoryRemote});
    }
    return notificationsRepositoryRemote;
  }

  //Local repositories
  get currentUserRepositoryLocal {
    var currentUserRepositoryLocal =
        _flyweightMap['currentUserRepositoryLocal'];
    if (currentUserRepositoryLocal == null) {
      currentUserRepositoryLocal = CurrentUserRepositoryLocalImpl();
      _flyweightMap
        ..addAll({'currentUserRepositoryLocal': currentUserRepositoryLocal});
    }
    return currentUserRepositoryLocal;
  }

  get otherUsersRepositoryLocal {
    var otherUsersRepositoryLocal = _flyweightMap['otherUsersRepositoryLocal'];
    if (otherUsersRepositoryLocal == null) {
      otherUsersRepositoryLocal = OtherUsersRepositoryLocalImpl();
      _flyweightMap
        ..addAll({'otherUsersRepositoryLocal': otherUsersRepositoryLocal});
    }
    return otherUsersRepositoryLocal;
  }

  get postsRepositoryLocal {
    var postsRepositoryLocal = _flyweightMap['postsRepositoryLocal'];
    if (postsRepositoryLocal == null) {
      postsRepositoryLocal = PostsRepositoryLocalImpl();
      _flyweightMap..addAll({'postsRepositoryLocal': postsRepositoryLocal});
    }
    return postsRepositoryLocal;
  }

  get notificationsRepositoryLocal {
    var notificationsRepositoryLocal =
        _flyweightMap['notificationsRepositoryLocal'];
    if (notificationsRepositoryLocal == null) {
      notificationsRepositoryLocal = NotificationsRepositoryLocalImpl();
      _flyweightMap
        ..addAll(
            {'notificationsRepositoryLocal': notificationsRepositoryLocal});
    }
    return notificationsRepositoryLocal;
  }

  //Flutter local notification plugin
  FlutterLocalNotificationPlugin get flutterLocalNotificationPlugin {
    var flutterLocalNotificationPlugin =
        _flyweightMap['flutterLocalNotificationPlugin'];
    if (flutterLocalNotificationPlugin == null) {
      flutterLocalNotificationPlugin = FlutterLocalNotificationPlugin();
      _flyweightMap
        ..addAll(
            {'flutterLocalNotificationPlugin': flutterLocalNotificationPlugin});
    }
    return flutterLocalNotificationPlugin;
  }

  //Alternatives for login process
  AlternateLoginHandler get facebookLoginHandler => FaceBookLoginHandler();
  AlternateLoginHandler get googleLoginHandler => GoogleLoginHandler();

  //Other services
  GalleryPicker get galleryImagePicker => GalleryImagePickerImpl();
  NetworkService get networkService => NetworkService();
  HiveHelper get hiveHelper => HiveHelperImpl();

  void dispose() {
    //release objects from flyWeight map
    _flyweightMap.clear();
  }
}
