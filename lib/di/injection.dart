import 'package:post/repositories/abstract/currentUserRepository.dart';
import 'package:post/repositories/abstract/otherUsersRepository.dart';
import 'package:post/repositories/abstract/postsRepository.dart';
import 'package:post/repositories/concrete/Remote/currentUserRepositoryRemoteImpl.dart';
import 'package:post/repositories/concrete/Remote/otherUsersRepositoryRemoteImpl.dart';
import 'package:post/repositories/concrete/Remote/postsRepositoryRemoteImpl.dart';
import 'package:post/repositories/currentUserRepositoryImpl.dart';
import 'package:post/repositories/otherUsersRepositoryImpl.dart';
import 'package:post/repositories/postsRepositoryImpl.dart';
import 'package:post/services/alternativeLoginHandler.dart';
import 'package:post/services/facebookLoginHelper.dart';
import 'package:post/services/googleLoginHandler.dart';
import 'package:post/services/networkService.dart';
import 'package:post/utils/GalleryPicker.dart';

///Implementing
///
///[Flyweight] design pattern
///
///to save specific objects from redundancy
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

  CurrentUserRepository get currentUserRepositoryRemote =>
      CurrentUserRepositoryRemoteImpl();

  OtherUsersRepository get otherUsersRepositoryRemote =>
      OtherUsersRepositoryRemoteImpl();

  PostsRepository get postsRepositoryRemote => PostsRepositoryRemoteImpl();

  NetworkService get networkService => NetworkService();

  AlternateLoginHandler get facebookLoginHandler => FaceBookLoginHandler();

  AlternateLoginHandler get googleLoginHandler => GoogleLoginHandler();

  GalleryPicker get galleryImagePicker => GalleryImagePickerImpl();

  void dispose() {
    //release objects from flyWeight map
    _flyweightMap.clear();
  }
}
