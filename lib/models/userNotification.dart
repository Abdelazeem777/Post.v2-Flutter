enum NotificationType { React, Comment, Share, Follow }
enum ReactType { Like, Love, Happy, Sad, Angry, none }

class UserNotification {
  int notificationId;
  int fromUserId;
  String fromUser;
  String fromUserProfilePicURL;
  String notificationContent;
  NotificationType notificationType;
  ReactType reactType;
  DateTime dateTime;
  bool seen;

  UserNotification(
      {this.notificationId,
      this.fromUserId,
      this.fromUser,
      this.fromUserProfilePicURL = "defaultProfileAvatar",
      this.notificationContent,
      this.notificationType,
      this.reactType,
      this.dateTime,
      this.seen = false});

  UserNotification.fromJson(Map<String, dynamic> json) {
    notificationId = json['notificationId'];
    fromUserId = json['fromUserId'];
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
    data['notificationId'] = this.notificationId;
    data['fromUserId'] = this.fromUserId;
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
