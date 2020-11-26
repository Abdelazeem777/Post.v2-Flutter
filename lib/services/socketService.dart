import 'package:post/apiEndpoint.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/post.dart';
import 'package:post/services/networkService.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'currentUser.dart';

class SocketService {
  static const New_USER_CONNECT_EVENT = 'newUserConnect';
  static const USER_DISCONNECTING_EVENT = 'userDisconnecting';
  static const FOLLOW_EVENT = 'follow';
  static const UNFOLLOW_EVENT = 'unFollow';
  static const NEW_POST_EVENT = 'newPost';

  Function _onNewUserConnect;
  Function _onDisconnect;
  Function _onFollow;
  Function _onUnFollow;

  set onNewUserConnect(Function onNewUserConnect) =>
      _onNewUserConnect = onNewUserConnect;
  set onDisconnect(Function onDisconnect) => _onDisconnect = onDisconnect;
  set onFollow(Function onFollow) => _onFollow = onFollow;
  set onUnFollow(Function onUnFollow) => _onUnFollow = onUnFollow;

  IO.Socket socket;

  NetworkService _networkService = Injector().networkService;
  static SocketService _singletone;

  factory SocketService() {
    if (_singletone == null) {
      _singletone = SocketService._internal();
    }
    return _singletone;
  }
  SocketService._internal() {
    if (_singletone != null) {
      throw Exception(
          "Trying to instantiate one more object from \"SocketService\".");
    }
  }
  connect() {
    if (isConnected()) {
      socket = IO.io(ApiEndPoint.REQUEST_URL, <String, dynamic>{
        'transports': ['websocket'],
        'query': {'userID': CurrentUser().userID},
      });
      socket.connect();
    } else
      reconnect();
    this.socket.on(New_USER_CONNECT_EVENT, _onNewUserConnect);
    this.socket.on(USER_DISCONNECTING_EVENT, _onDisconnect);

    this.socket.on(FOLLOW_EVENT, _onFollow);
    this.socket.on(UNFOLLOW_EVENT, _onUnFollow);
  }

  bool isConnected() => socket == null || !socket?.connected;

  reconnect() {
    disconnect();
    connect();
  }

  Future<void> follow(
      String currentUserID, String targetUserID, int rank) async {
    final data = {
      'currentUserID': currentUserID,
      'targetUserID': targetUserID,
      'rank': rank
    };
    socket.emit(FOLLOW_EVENT, data);
  }

  Future<void> unFollow(
      String currentUserID, String targetUserID, int rank) async {
    final data = {
      'currentUserID': currentUserID,
      'targetUserID': targetUserID,
      'rank': rank
    };

    socket.emit(UNFOLLOW_EVENT, data);
  }

  Future<void> sendPost(Post newPost) async {
    var newPostMap = newPost.toMap();
    var newPostJson = _networkService.convertMapToJson(newPostMap);
    socket.emit(NEW_POST_EVENT, newPostJson);
  }

  disconnect() {
    if (socket != null)
      socket
        ..emit(USER_DISCONNECTING_EVENT, CurrentUser().userID)
        ..dispose();
    socket = null;

    CurrentUser()
      ..active = false
      ..notify();
  }
}
