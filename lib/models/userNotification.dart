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
  DateTime dateTime;
  bool seen;

  UserNotification(
      {this.notificationID,
      this.fromUserID,
      this.fromUser,
      this.fromUserProfilePicURL = "defaultProfileAvatar",
      this.notificationContent,
      this.notificationType,
      this.reactType,
      this.dateTime,
      this.seen = false});

  UserNotification.fromJson(Map<String, dynamic> json) {
    notificationID = json['notificationID'];
    fromUserID = json['fromUserID'];
    fromUser = json['fromUser'];
    fromUserProfilePicURL = json['fromUserProfilePicURL'];
    notificationContent = json['notificationContent'];
    notificationType = json['notificationType'];
    reactType = json['reactType'];
    dateTime = json['dateTime'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationID'] = this.notificationID;
    data['fromUserID'] = this.fromUserID;
    data['fromUser'] = this.fromUser;
    data['fromUserProfilePicURL'] = this.fromUserProfilePicURL;
    data['notificationContent'] = this.notificationContent;
    data['notificationType'] = this.notificationType;
    data['reactType'] = this.reactType;
    data['dateTime'] = this.dateTime;
    data['seen'] = this.seen;
    return data;
  }
}
