import 'abstract/localNotification.dart';

class FollowNotification extends LocalNotification {
  FollowNotification(String body, Map payload)
      : super(body: body, payload: payload);
}

class ReactNotification extends LocalNotification {
  ReactNotification() {
    throw UnimplementedError();
  }
}

class CommentNotification extends LocalNotification {
  CommentNotification() {
    throw UnimplementedError();
  }
}

class ShareNotification extends LocalNotification {
  ShareNotification() {
    throw UnimplementedError();
  }
}
