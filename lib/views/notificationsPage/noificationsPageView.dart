import 'package:flutter/material.dart';
import 'package:post/models/enums/notificationTypeEnum.dart';
import 'package:post/models/enums/reactTypeEnum.dart';
import 'package:post/models/notificationModel.dart';
import 'package:post/models/user.dart';
import 'package:post/style/appColors.dart';
import 'package:post/views/widgets/stateful/notificationItem.dart';

class Notifications extends StatefulWidget {
  static const String routeName = '/Notifications';
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<NotificationModel> _notificationsList;
  List<User> _usersList;
  @override
  void initState() {
    super.initState();
    //test data
    _notificationsList = [
      NotificationModel(
          notificationID: "1",
          fromUserID: "3",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Like,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch,
          seen: true),
      NotificationModel(
          notificationID: "1",
          fromUserID: "3",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Love,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch,
          seen: false),
      NotificationModel(
          notificationID: "1",
          fromUserID: "3",
          notificationContent: "react love your post",
          notificationType: NotificationType.Follow,
          reactType: ReactType.none,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch),
      NotificationModel(
          notificationID: "1",
          fromUserID: "3",
          notificationContent: "react love your post",
          notificationType: NotificationType.Share,
          reactType: ReactType.none,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch),
      NotificationModel(
          notificationID: "1",
          fromUserID: "3",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Angry,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch,
          seen: false),
      NotificationModel(
          notificationID: "1",
          fromUserID: "3",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Sad,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch,
          seen: true),
      NotificationModel(
          notificationID: "1",
          fromUserID: "3",
          notificationContent: "react love your post",
          notificationType: NotificationType.React,
          reactType: ReactType.Haha,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch),
      NotificationModel(
          notificationID: "1",
          fromUserID: "3",
          notificationContent: "react love your post",
          notificationType: NotificationType.Comment,
          reactType: ReactType.none,
          timestamp: DateTime.now()
              .subtract(Duration(seconds: 5))
              .millisecondsSinceEpoch),
    ];
    _usersList = [];
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
        final notification = _notificationsList[position];
        //final user = _usersList[position];
        final user = User(userName: "test", userProfilePicURL: "default");
        return NotificationItem(notification, user);
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
