import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/models/userNotification.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/dateTimeFormatHandler.dart';
import 'package:post/utils/iconHandler.dart';
import 'package:post/utils/sizeConfig.dart';

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
            : Colors.green[50],
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
            child: ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                useOldImageOnUrlChange: true,
                imageUrl: this.widget._notification.fromUserProfilePicURL,
                placeholder: (context, url) => Container(
                  color: Colors.green[100],
                  child: Icon(
                    Icons.person,
                    size: SizeConfig.blockSizeVertical * 8,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
            ),
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
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: this.widget._notification.fromUser + "\n",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
              text: this.widget._notification.notificationType.toString() +
                  " your post\n"),
          TextSpan(
              text: DateTimeFormatHandler.getTime(
                  this.widget._notification.dateTime),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.PRIMARY_COLOR,
              )),
        ]),
      ),
    );
  }
}
