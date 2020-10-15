import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';

import 'loadingAnimation.dart';

// ignore: must_be_immutable
class SubmitButton extends StatefulWidget {
  bool busy;
  final Function onPressed;
  final String text;

  SubmitButton({
    Key key,
    @required this.text,
    @required this.busy,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        curve: Curves.easeInOutBack,
        margin: EdgeInsets.fromLTRB(
          16,
          SizeConfig.safeBlockVertical * 3,
          16,
          SizeConfig.safeBlockVertical * 1.8,
        ),
        width: widget.busy ? 50 : 150,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.PRIMARY_COLOR, AppColors.SECONDARY_COLOR],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 2.0), //(x,y)
              blurRadius: 5.0,
            ),
          ],
        ),
        child: widget.busy ? createLoadingAnimation() : createFlatButton(),
        duration: Duration(milliseconds: 300));
  }

  Widget createFlatButton() {
    return FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.fromLTRB(34, 13, 34, 13),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              this.widget.text,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Hero(
              tag: "submit",
              child: Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
          ],
        ),
        onPressed: widget
            .onPressed //TODO: Don't foget it should be--> widget.onPressed,

        );
  }

  Widget createLoadingAnimation() {
    return Hero(
      tag: "submit",
      child: SizedBox(
        height: 25,
        width: 25,
        child: LoadingAnimation(
          colors: [Colors.white],
          strokeWidth: 3,
        ),
      ),
    );
  }
}
