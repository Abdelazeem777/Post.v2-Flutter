import 'package:post/apiEndpoint.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/post.dart';
import 'package:post/services/networkService.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket socket;
  NetworkService _networkService = Injector().networkService;

  createSocketConnection() {
    socket = IO.io(ApiEndPoint.REQUEST_URL, <String, dynamic>{
      'transports': ['websocket'],
    });

    this.socket.on("connect", (_) => print('Connected'));
    this.socket.on("disconnect", (_) => print('Disconnected'));
  }

  sendPost(Post newPost) {
    var newPostMap = newPost.toJson();
    var newPostJson = _networkService.convertMapToJson(newPostMap);
    socket.emit('newPost', newPostJson);
  }
}
