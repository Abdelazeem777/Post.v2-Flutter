import 'package:flutter/material.dart';
import 'package:post/enums/notificationTypeEnum.dart';
import 'package:post/enums/reactTypeEnum.dart';
import 'package:post/models/userNotification.dart';
import 'package:post/style/appColors.dart';
import 'package:post/views/widgets/stateful/notificationItem.dart';

class Notifications extends StatefulWidget {
  static const String routeName = '/Notifications';
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<UserNotification> _notificationsList;
  @override
  void initState() {
    super.initState();
    //test data
    _notificationsList = [
      UserNotification(
          notificationID: 1,
          fromUserID: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Like,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch,
          fromUserProfilePicURL:
              "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=IcR2YHTf8hAAX-WZLXa&_nc_oc=AQn5Ppu-T8UZf0D9Ne-2uxQq3DPhRTa5AY739QhLYyKwYvJaANUY2VMPmUwybfLPbPY&_nc_ht=scontent.faly3-1.fna&oh=8d5a1ac72b74646168943f9c1ad7e17d&oe=5F6C14E4",
          seen: true),
      UserNotification(
          notificationID: 1,
          fromUserID: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Love,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch,
          fromUserProfilePicURL:
              "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=IcR2YHTf8hAAX-WZLXa&_nc_oc=AQn5Ppu-T8UZf0D9Ne-2uxQq3DPhRTa5AY739QhLYyKwYvJaANUY2VMPmUwybfLPbPY&_nc_ht=scontent.faly3-1.fna&oh=8d5a1ac72b74646168943f9c1ad7e17d&oe=5F6C14E4",
          seen: false),
      UserNotification(
          notificationID: 1,
          fromUserID: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.Follow,
          reactType: ReactType.none,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch),
      UserNotification(
          notificationID: 1,
          fromUserID: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.Share,
          reactType: ReactType.none,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch),
      UserNotification(
          notificationID: 1,
          fromUserID: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Angry,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch,
          fromUserProfilePicURL:
              "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=IcR2YHTf8hAAX-WZLXa&_nc_oc=AQn5Ppu-T8UZf0D9Ne-2uxQq3DPhRTa5AY739QhLYyKwYvJaANUY2VMPmUwybfLPbPY&_nc_ht=scontent.faly3-1.fna&oh=8d5a1ac72b74646168943f9c1ad7e17d&oe=5F6C14E4",
          seen: false),
      UserNotification(
          notificationID: 1,
          fromUserID: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Sad,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch,
          seen: true),
      UserNotification(
          notificationID: 1,
          fromUserID: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Haha,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch),
      UserNotification(
          notificationID: 1,
          fromUserID: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.Comment,
          reactType: ReactType.none,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch),
    ];
  }

  Widget _createAppBar() {
    return AppBar(
      shadowColor: AppColors.SECONDARY_COLOR,
      title: Text(
        "Notifications",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      iconTheme: IconThemeData(color: AppColors.PRIMARY_COLOR),
    );
  }

  Widget _createNotificationsBody() {
    return ListView.builder(
      itemCount: _notificationsList.length,
      itemBuilder: (context, position) {
        return NotificationItem(_notificationsList[position]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: SafeArea(
        child: _createNotificationsBody(),
      ),
    );
  }
}
