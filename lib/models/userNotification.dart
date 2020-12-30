import 'package:enum_to_string/enum_to_string.dart';
import 'package:post/enums/notificationTypeEnum.dart';
import 'package:post/enums/reactTypeEnum.dart';

class UserNotification {
  int notificationID;
  int fromUserID;
  String fromUser;
  String fromUserProfilePicURL;
  String notificationContent;
  NotificationType notificationType;
  ReactType reactType;
  int timestamp;
  bool seen;

  UserNotification(
      {this.notificationID,
      this.fromUserID,
      this.fromUser,
      this.fromUserProfilePicURL = "defaultProfileAvatar",
      this.notificationContent,
      this.notificationType,
      this.reactType,
      this.timestamp,
      this.seen = false});

  UserNotification.fromMap(Map<String, dynamic> json) {
    notificationID = json['notificationID'];
    fromUserID = json['fromUserID'];
    fromUser = json['fromUser'];
    fromUserProfilePicURL = json['fromUserProfilePicURL'];
    notificationContent = json['notificationContent'];
    notificationType = EnumToString.fromString(
        NotificationType.values, json['notificationType']);
    reactType = json['reactType'];
    timestamp = json['timestamp'];
    seen = json['seen'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationID'] = this.notificationID;
    data['fromUserID'] = this.fromUserID;
    data['fromUser'] = this.fromUser;
    data['fromUserProfilePicURL'] = this.fromUserProfilePicURL;
    data['notificationContent'] = this.notificationContent;
    data['notificationType'] =
        EnumToString.convertToString(this.notificationType);
    data['reactType'] = this.reactType;
    data['timestamp'] = this.timestamp;
    data['seen'] = this.seen;
    return data;
  }
}
