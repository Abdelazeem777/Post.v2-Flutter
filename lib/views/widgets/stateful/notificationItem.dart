import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/models/userNotification.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/dateTimeFormatHandler.dart';
import 'package:post/utils/iconHandler.dart';
import 'package:post/utils/sizeConfig.dart';

import 'UserProfilePicture.dart';

class NotificationItem extends StatefulWidget {
  final UserNotification _notification;
  NotificationItem(this._notification);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        color: this.widget._notification.seen
            ? Theme.of(context).canvasColor
            : Color(0x77afe782),
        child: Row(
          children: [
            _createNotificationUserProfileAndIcon(),
            _createNotificationText(),
          ],
        ));
  }

  Widget _createNotificationUserProfileAndIcon() {
    return SizedBox(
      child: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical * 10,
            width: SizeConfig.blockSizeVertical * 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.SECONDARY_COLOR, width: .5),
            ),
            child: UserProfilePicture(
                imageURL: this.widget._notification.fromUserProfilePicURL,
                active: false),
          ),
          _createNotificationIcon(
              notificationType: this.widget._notification.notificationType,
              reactType: this.widget._notification.reactType),
        ],
      ),
    );
  }

  Widget _createNotificationIcon({
    NotificationType notificationType,
    ReactType reactType = ReactType.none,
  }) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: IconHandler.getIcon(notificationType, reactType),
    );
  }

  Widget _createNotificationText() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.widget._notification.fromUser,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _notificationTextBasedOnType(
                this.widget._notification.notificationType),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
                DateTimeFormatHandler.getTime(
                    this.widget._notification.dateTime),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.PRIMARY_COLOR,
                )),
          ),
        ],
      ),
    );
  }

  String _notificationTextBasedOnType(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.React:
        return "Reacted to your post";
        break;
      case NotificationType.Comment:
        return "Commented into your post";
        break;
      case NotificationType.Share:
        return "Shared your post";
        break;
      case NotificationType.Follow:
        return "Started following you";
        break;
      default:
        throw Exception("undefined notification type");
    }
  }
}
