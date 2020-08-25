import 'package:flutter/material.dart';
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
    _notificationsList = [
      UserNotification(
          notificationId: 1,
          fromUserId: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Like,
          dateTime: DateTime.now(),
          fromUserProfilePicURL:
              "https://homepages.cae.wisc.edu/~ece533/images/cat.png",
          seen: true),
      UserNotification(
          notificationId: 1,
          fromUserId: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Love,
          dateTime: DateTime.now(),
          fromUserProfilePicURL:
              "https://homepages.cae.wisc.edu/~ece533/images/cat.png",
          seen: false),
      UserNotification(
          notificationId: 1,
          fromUserId: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Angry,
          dateTime: DateTime.now(),
          fromUserProfilePicURL:
              "https://homepages.cae.wisc.edu/~ece533/images/cat.png",
          seen: false),
      UserNotification(
          notificationId: 1,
          fromUserId: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Sad,
          dateTime: DateTime.now(),
          seen: true),
      UserNotification(
          notificationId: 1,
          fromUserId: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Happy,
          dateTime: DateTime.now()),
      UserNotification(
          notificationId: 1,
          fromUserId: 3,
          fromUser: "Abdelazeem Kuratem",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Like,
          dateTime: DateTime.now()),
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
