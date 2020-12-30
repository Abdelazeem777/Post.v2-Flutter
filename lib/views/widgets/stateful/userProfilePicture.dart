import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//TODO: add onPressed to move to the user profile
class UserProfilePicture extends StatefulWidget {
  final String imageURL;
  final bool active;
  final double activeIndicatorSize;
  UserProfilePicture(
      {this.imageURL = "Default",
      this.active = false,
      this.activeIndicatorSize = 15});
  @override
  _UserProfilePictureState createState() => _UserProfilePictureState();
}

class _UserProfilePictureState extends State<UserProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: widget.imageURL != 'Default'
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  useOldImageOnUrlChange: true,
                  imageUrl: widget.imageURL,
                  placeholder: (context, url) => _createPlaceHolder(context),
                )
              : _createPlaceHolder(context),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: widget.activeIndicatorSize,
              width: widget.activeIndicatorSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    this.widget.active ? Colors.green[400] : Colors.transparent,
              ),
            ))
      ],
    );
  }

  Widget _createPlaceHolder(BuildContext context) {
    return Container(
      color: Colors.green[100],
      constraints: BoxConstraints.expand(),
      child: FittedBox(
        child: Icon(
          Icons.person,
          color: Theme.of(context).canvasColor,
        ),
      ),
    );
  }
}
