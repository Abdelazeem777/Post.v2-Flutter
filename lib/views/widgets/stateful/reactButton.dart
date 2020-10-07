import 'dart:async';

import 'package:flutter/material.dart';

import 'package:post/enums/reactTypeEnum.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/iconHandler.dart';
import 'package:post/utils/sizeConfig.dart';

class ReactButton extends StatefulWidget {
  ReactType initialReactType;
  //TODO: add initialReactType parameter inside constractor
  ReactButton({
    this.initialReactType,
  });

  @override
  _ReactButtonState createState() => _ReactButtonState();
}

class _ReactButtonState extends State<ReactButton>
    with TickerProviderStateMixin {
  int durationAnimationBox = 500;
  int durationAnimationBtnLongPress = 150;
  int durationAnimationBtnShortPress = 500;
  int durationAnimationIconWhenDrag = 150;
  int durationAnimationIconWhenRelease = 1000;

  // For long press btn
  AnimationController animControlBtnLongPress, animControlBox;
  Animation zoomIconLikeInBtn, tiltIconLikeInBtn, zoomTextLikeInBtn;
  Animation fadeInBox;
  Animation moveRightGroupIcon;
  Animation pushIconLikeUp,
      pushIconLoveUp,
      pushIconHahaUp,
      pushIconSadUp,
      pushIconAngryUp;
  Animation zoomIconLike,
      zoomIconLove,
      zoomIconHaha,
      zoomIconSad,
      zoomIconAngry;

  // For short press btn
  AnimationController animControlBtnShortPress;
  Animation zoomIconLikeInBtn2, tiltIconLikeInBtn2;

  // For zoom icon when drag
  AnimationController animControlIconWhenDrag;
  AnimationController animControlIconWhenDragInside;
  AnimationController animControlIconWhenDragOutside;
  AnimationController animControlBoxWhenDragOutside;
  Animation zoomIconChosen, zoomIconNotChosen;
  Animation zoomIconWhenDragOutside;
  Animation zoomIconWhenDragInside;
  Animation zoomBoxWhenDragOutside;
  Animation zoomBoxIcon;

  // For jump icon when release
  AnimationController animControlIconWhenRelease;
  Animation zoomIconWhenRelease, moveUpIconWhenRelease;
  Animation moveLeftIconLikeWhenRelease,
      moveLeftIconLoveWhenRelease,
      moveLeftIconHahaWhenRelease,
      moveLeftIconSadWhenRelease,
      moveLeftIconAngryWhenRelease;

  Duration durationLongPress = Duration(milliseconds: 250);
  Timer holdTimer;
  bool isLongPress = false;
  bool isLiked = false;

  // 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = sad, 5 = angry
  int whichIconUserChoose = 0;

  // 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = sad, 5 = angry
  int currentIconFocus = 0;
  int previousIconFocus = 0;
  bool isDragging = false;
  bool isDraggingOutside = false;
  bool isJustDragInside = true;

  @override
  void initState() {
    super.initState();

    // Button Like
    initAnimationBtnLike();

    // Box and Icons
    initAnimationBoxAndIcons();

    // Icon when drag
    initAnimationIconWhenDrag();

    // Icon when drag outside
    initAnimationIconWhenDragOutside();

    // Box when drag outside
    initAnimationBoxWhenDragOutside();

    // Icon when first drag
    initAnimationIconWhenDragInside();

    // Icon when release
    initAnimationIconWhenRelease();
  }

  initAnimationBtnLike() {
    // long press
    animControlBtnLongPress = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationBtnLongPress));
    zoomIconLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);
    tiltIconLikeInBtn =
        Tween(begin: 0.0, end: 0.2).animate(animControlBtnLongPress);
    zoomTextLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);

    zoomIconLikeInBtn.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn.addListener(() {
      setState(() {});
    });
    zoomTextLikeInBtn.addListener(() {
      setState(() {});
    });

    // short press
    animControlBtnShortPress = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationBtnShortPress));
    zoomIconLikeInBtn2 =
        Tween(begin: 1.0, end: 0.2).animate(animControlBtnShortPress);
    tiltIconLikeInBtn2 =
        Tween(begin: 0.0, end: 0.8).animate(animControlBtnShortPress);

    zoomIconLikeInBtn2.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn2.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxAndIcons() {
    animControlBox = AnimationController(
        vsync: this, duration: Duration(milliseconds: durationAnimationBox));

    // General
    moveRightGroupIcon = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 1.0)),
    );
    moveRightGroupIcon.addListener(() {
      setState(() {});
    });

    // Box
    fadeInBox = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.7, 1.0)),
    );
    fadeInBox.addListener(() {
      setState(() {});
    });

    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.45, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.45, 1.0)),
    );

    pushIconLikeUp.addListener(() {
      setState(() {});
    });
    zoomIconLike.addListener(() {
      setState(() {});
    });
    pushIconLoveUp.addListener(() {
      setState(() {});
    });
    zoomIconLove.addListener(() {
      setState(() {});
    });
    pushIconHahaUp.addListener(() {
      setState(() {});
    });
    zoomIconHaha.addListener(() {
      setState(() {});
    });
    pushIconSadUp.addListener(() {
      setState(() {});
    });
    zoomIconSad.addListener(() {
      setState(() {});
    });
    pushIconAngryUp.addListener(() {
      setState(() {});
    });
    zoomIconAngry.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDrag() {
    animControlIconWhenDrag = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));

    zoomIconChosen =
        Tween(begin: 1.0, end: 1.8).animate(animControlIconWhenDrag);
    zoomIconNotChosen =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDrag);
    zoomBoxIcon =
        Tween(begin: 50.0, end: 40.0).animate(animControlIconWhenDrag);

    zoomIconChosen.addListener(() {
      setState(() {});
    });
    zoomIconNotChosen.addListener(() {
      setState(() {});
    });
    zoomBoxIcon.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragOutside() {
    animControlIconWhenDragOutside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragOutside =
        Tween(begin: 0.8, end: 1.0).animate(animControlIconWhenDragOutside);
    zoomIconWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxWhenDragOutside() {
    animControlBoxWhenDragOutside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomBoxWhenDragOutside =
        Tween(begin: 40.0, end: 50.0).animate(animControlBoxWhenDragOutside);
    zoomBoxWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragInside() {
    animControlIconWhenDragInside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragInside =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDragInside);
    zoomIconWhenDragInside.addListener(() {
      setState(() {});
    });
    animControlIconWhenDragInside.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isJustDragInside = false;
      }
    });
  }

  initAnimationIconWhenRelease() {
    animControlIconWhenRelease = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenRelease));

    zoomIconWhenRelease = Tween(begin: 1.8, end: 0.0).animate(CurvedAnimation(
        parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveUpIconWhenRelease = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveLeftIconLikeWhenRelease = Tween(begin: 20.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconLoveWhenRelease = Tween(begin: 68.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconHahaWhenRelease = Tween(begin: 116.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconSadWhenRelease = Tween(begin: 164.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconAngryWhenRelease = Tween(begin: 212.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));

    zoomIconWhenRelease.addListener(() {
      setState(() {});
    });
    moveUpIconWhenRelease.addListener(() {
      setState(() {});
    });

    moveLeftIconLikeWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconLoveWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconHahaWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconSadWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconAngryWhenRelease.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    animControlBtnLongPress.dispose();
    animControlBox.dispose();
    animControlIconWhenDrag.dispose();
    animControlIconWhenDragInside.dispose();
    animControlIconWhenDragOutside.dispose();
    animControlBoxWhenDragOutside.dispose();
    animControlIconWhenRelease.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: SizeConfig.screenWidth,
      child: GestureDetector(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
            ),
            Container(
              child: Stack(
                children: [
                  Stack(
                    children: [
                      renderBox(),
                      renderIcons(),
                    ],
                    alignment: Alignment.bottomCenter,
                  ),
                  renderReactButton(),

                  //Icons when jump
                  //Icon like
                  whichIconUserChoose == 1 && !isDragging
                      ? Container(
                          child: Transform.scale(
                            child: IconHandler.getReactIcon(ReactType.Like),
                            scale: this.zoomIconWhenRelease.value,
                          ),
                          margin: EdgeInsets.only(
                            top: processTopPosition(
                                this.moveUpIconWhenRelease.value),
                            left: this.moveLeftIconLikeWhenRelease.value,
                          ),
                        )
                      : Container(),

                  // Icon love
                  whichIconUserChoose == 2 && !isDragging
                      ? Container(
                          child: Transform.scale(
                            child: IconHandler.getReactIcon(ReactType.Love),
                            scale: this.zoomIconWhenRelease.value,
                          ),
                          margin: EdgeInsets.only(
                            top: processTopPosition(
                                this.moveUpIconWhenRelease.value),
                            left: this.moveLeftIconLoveWhenRelease.value,
                          ),
                        )
                      : Container(),

                  // Icon haha
                  whichIconUserChoose == 3 && !isDragging
                      ? Container(
                          child: Transform.scale(
                            child: IconHandler.getReactIcon(ReactType.Haha),
                            scale: this.zoomIconWhenRelease.value,
                          ),
                          margin: EdgeInsets.only(
                            top: processTopPosition(
                                this.moveUpIconWhenRelease.value),
                            left: this.moveLeftIconHahaWhenRelease.value,
                          ),
                        )
                      : Container(),

                  // Icon sad
                  whichIconUserChoose == 4 && !isDragging
                      ? Container(
                          child: Transform.scale(
                            child: IconHandler.getReactIcon(ReactType.Sad),
                            scale: this.zoomIconWhenRelease.value,
                          ),
                          margin: EdgeInsets.only(
                            top: processTopPosition(
                                this.moveUpIconWhenRelease.value),
                            left: this.moveLeftIconSadWhenRelease.value,
                          ),
                        )
                      : Container(),

                  // Icon angry
                  whichIconUserChoose == 5 && !isDragging
                      ? Container(
                          child: Transform.scale(
                            child: IconHandler.getReactIcon(ReactType.Angry),
                            scale: this.zoomIconWhenRelease.value,
                          ),
                          margin: EdgeInsets.only(
                            top: processTopPosition(
                                this.moveUpIconWhenRelease.value),
                            left: this.moveLeftIconAngryWhenRelease.value,
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
        onHorizontalDragEnd: onHorizontalDragEndBoxIcon,
        onHorizontalDragUpdate: onHorizontalDragUpdateBoxIcon,
      ),
    );
  }

  Widget renderIcons() {
    return Container(
      child: Row(
        children: <Widget>[
          // icon like
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 1
                      ? Container(
                          child: Text(
                            'Like',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  IconHandler.getReactIcon(ReactType.Like, size: 27)
                ],
              ),
              margin: EdgeInsets.only(bottom: pushIconLikeUp.value),
              width: 40.0,
              height: currentIconFocus == 1 ? 70.0 : 40.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 1
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 1
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconLike.value,
          ),

          // icon love
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 2
                      ? Container(
                          child: Text(
                            'Love',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  IconHandler.getReactIcon(ReactType.Love, size: 27),
                ],
              ),
              margin: EdgeInsets.only(bottom: pushIconLoveUp.value),
              width: 40.0,
              height: currentIconFocus == 2 ? 70.0 : 40.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 2
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 2
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconLove.value,
          ),

          // icon haha
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 3
                      ? Container(
                          child: Text(
                            'Haha',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  IconHandler.getReactIcon(ReactType.Haha, size: 27),
                ],
              ),
              margin: EdgeInsets.only(bottom: pushIconHahaUp.value),
              width: 40.0,
              height: currentIconFocus == 3 ? 70.0 : 40.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 3
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 3
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconHaha.value,
          ),

          // icon sad
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 4
                      ? Container(
                          child: Text(
                            'Sad',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  IconHandler.getReactIcon(ReactType.Sad, size: 27),
                ],
              ),
              margin: EdgeInsets.only(bottom: pushIconSadUp.value),
              width: 40.0,
              height: currentIconFocus == 4 ? 70.0 : 40.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 4
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 4
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconSad.value,
          ),

          // icon angry
          Transform.scale(
            child: Container(
              child: Column(
                children: <Widget>[
                  currentIconFocus == 5
                      ? Container(
                          child: Text(
                            'Angry',
                            style:
                                TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black.withOpacity(0.3)),
                          padding: EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                        )
                      : Container(),
                  IconHandler.getReactIcon(ReactType.Angry, size: 27),
                ],
              ),
              margin: EdgeInsets.only(bottom: pushIconAngryUp.value),
              width: 40.0,
              height: currentIconFocus == 5 ? 70.0 : 40.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 5
                    ? this.zoomIconChosen.value
                    : (previousIconFocus == 5
                        ? this.zoomIconNotChosen.value
                        : isJustDragInside
                            ? this.zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? this.zoomIconWhenDragOutside.value
                    : this.zoomIconAngry.value,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      width: SizeConfig.screenWidth,
      height: 250.0,
      margin: EdgeInsets.only(left: this.moveRightGroupIcon.value, top: 50.0),
      // uncomment here to see area of draggable
      //color: Colors.amber.withOpacity(0.5),
    );
  }

  Widget renderBox() {
    return Opacity(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey[300], width: 0.3),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                // LTRB
                offset: Offset.lerp(Offset(0.0, 0.0), Offset(0.0, 0.5), 10.0)),
          ],
        ),
        width: 320.0,
        height: isDragging
            ? (previousIconFocus == 0 ? this.zoomBoxIcon.value : 45.0)
            : isDraggingOutside
                ? this.zoomBoxWhenDragOutside.value
                : 55.0,
        margin: EdgeInsets.only(bottom: 130.0, left: 10.0),
      ),
      opacity: this.fadeInBox.value,
    );
  }

  Widget renderReactButton() {
    return Container(
      child: GestureDetector(
        onTapDown: onTapDownBtn,
        onTapUp: onTapUpBtn,
        onTap: onTapBtn,
        child: Container(
          child: Row(
            children: <Widget>[
              // Icon like
              Transform.scale(
                child: Transform.rotate(
                  child: Container(
                    child: getIconBtn(),
                    width: 25.0,
                    height: 25.0,
                  ),
                  angle: !isLongPress
                      ? handleOutputRangeTiltIconLike(tiltIconLikeInBtn2.value)
                      : tiltIconLikeInBtn.value,
                ),
                scale: !isLongPress
                    ? handleOutputRangeZoomInIconLike(zoomIconLikeInBtn2.value)
                    : zoomIconLikeInBtn.value,
              ),

              // Text like
              Transform.scale(
                child: Text(
                  getTextBtn(),
                  style: TextStyle(
                    color: getColorTextBtn(),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                scale: !isLongPress
                    ? handleOutputRangeZoomInIconLike(zoomIconLikeInBtn2.value)
                    : zoomTextLikeInBtn.value,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          padding: EdgeInsets.all(10.0),
          color: Colors.transparent,
        ),
      ),
      width: 100.0,
      margin: EdgeInsets.only(top: 190.0),
    );
  }

  String getTextBtn() {
    if (isDragging) {
      return 'Like';
    }
    switch (whichIconUserChoose) {
      case 1:
        return 'Like';
      case 2:
        return 'Love';
      case 3:
        return 'Haha';
      case 4:
        return 'Sad';
      case 5:
        return 'Angry';
      default:
        return 'Like';
    }
  }

  Color getColorTextBtn() {
    if ((!isLongPress && isLiked)) {
      return AppColors.SECONDARY_COLOR;
    } else if (!isDragging) {
      switch (whichIconUserChoose) {
        case 1:
          return AppColors.SECONDARY_COLOR;
        case 2:
          return Color(0xffED5167);
        case 3:
        case 4:
          return Color(0xffFFD96A);
        case 5:
          return Color(0xffF6876B);
        default:
          return Colors.grey;
      }
    } else {
      return Colors.grey;
    }
  }

  double processTopPosition(double value) {
    // margin top 100 -> 40 -> 160 (value from 180 -> 0)
    if (value >= 120.0) {
      return value - 80.0;
    } else {
      return 160.0 - value;
    }
  }

  void onTapDownBtn(TapDownDetails tapDownDetail) {
    holdTimer = Timer(durationLongPress, showBox);
  }

  void onTapUpBtn(TapUpDetails tapUpDetail) {
    Timer(Duration(milliseconds: durationAnimationBox), () {
      isLongPress = false;
    });

    holdTimer.cancel();

    animControlBtnLongPress.reverse();

    setReverseValue();
    animControlBox.reverse();

    animControlIconWhenRelease.reset();
    animControlIconWhenRelease.forward();
  }

  void onTapBtn() {
    if (!isLongPress) {
      if (whichIconUserChoose == 0) {
        isLiked = !isLiked;
      } else {
        whichIconUserChoose = 0;
      }
      if (isLiked) {
        animControlBtnShortPress.forward();
      } else {
        animControlBtnShortPress.reverse();
      }
    }
  }

  double handleOutputRangeZoomInIconLike(double value) {
    if (value >= 0.8) {
      return value;
    } else if (value >= 0.4) {
      return 1.6 - value;
    } else {
      return 0.8 + value;
    }
  }

  double handleOutputRangeTiltIconLike(double value) {
    if (value <= 0.2) {
      return value;
    } else if (value <= 0.6) {
      return 0.4 - value;
    } else {
      return -(0.8 - value);
    }
  }

  void showBox() {
    isLongPress = true;

    animControlBtnLongPress.forward();

    setForwardValue();
    animControlBox.forward();
  }

  // We need to set the value for reverse because if not
  // the angry-icon will be pulled down first, not the like-icon
  void setReverseValue() {
    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.15, 0.65)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.15, 0.65)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.55)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.55)),
    );
  }

  // When set the reverse value, we need set value to normal for the forward
  void setForwardValue() {
    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.35, 0.85)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.35, 0.85)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
  }

  void onHorizontalDragEndBoxIcon(DragEndDetails dragEndDetail) {
    isDragging = false;
    isDraggingOutside = false;
    isJustDragInside = true;
    previousIconFocus = 0;
    currentIconFocus = 0;

    onTapUpBtn(null);
  }

  void onHorizontalDragUpdateBoxIcon(DragUpdateDetails dragUpdateDetail) {
    // return if the drag is drag without press button
    if (!isLongPress) return;

    // the margin top the box is 150
    // and plus the height of toolbar and the status bar
    // so the range we check is about 200 -> 500

    if (dragUpdateDetail.localPosition.dy >= 100 &&
        dragUpdateDetail.localPosition.dy <= 350) {
      isDragging = true;
      isDraggingOutside = false;

      if (isJustDragInside && !animControlIconWhenDragInside.isAnimating) {
        animControlIconWhenDragInside.reset();
        animControlIconWhenDragInside.forward();
      }

      if (dragUpdateDetail.globalPosition.dx >= 20 &&
          dragUpdateDetail.globalPosition.dx < 95.5) {
        if (currentIconFocus != 1) {
          handleWhenDragBetweenIcon(1);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 95.5 &&
          dragUpdateDetail.globalPosition.dx < 161.2) {
        if (currentIconFocus != 2) {
          handleWhenDragBetweenIcon(2);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 161.2 &&
          dragUpdateDetail.globalPosition.dx < 217.8) {
        if (currentIconFocus != 3) {
          handleWhenDragBetweenIcon(3);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 217.8 &&
          dragUpdateDetail.globalPosition.dx < 283.4) {
        if (currentIconFocus != 4) {
          handleWhenDragBetweenIcon(4);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 283.4 &&
          dragUpdateDetail.globalPosition.dx < 349) {
        if (currentIconFocus != 5) {
          handleWhenDragBetweenIcon(5);
        }
      }
    } else {
      whichIconUserChoose = 0;
      previousIconFocus = 0;
      currentIconFocus = 0;
      isJustDragInside = true;

      if (isDragging && !isDraggingOutside) {
        isDragging = false;
        isDraggingOutside = true;
        animControlIconWhenDragOutside.reset();
        animControlIconWhenDragOutside.forward();
        animControlBoxWhenDragOutside.reset();
        animControlBoxWhenDragOutside.forward();
      }
    }
  }

  void handleWhenDragBetweenIcon(int currentIcon) {
    whichIconUserChoose = currentIcon;
    previousIconFocus = currentIconFocus;
    currentIconFocus = currentIcon;
    animControlIconWhenDrag.reset();
    animControlIconWhenDrag.forward();
  }

  Widget getIconBtn() {
    if (!isLongPress && isLiked) {
      return IconHandler.getReactIcon(ReactType.Like);
    } else if (!isDragging) {
      switch (whichIconUserChoose) {
        case 1:
          return IconHandler.getReactIcon(ReactType.Like);
        case 2:
          return IconHandler.getReactIcon(ReactType.Love);
        case 3:
          return IconHandler.getReactIcon(ReactType.Haha);
        case 4:
          return IconHandler.getReactIcon(ReactType.Sad);
        case 5:
          return IconHandler.getReactIcon(ReactType.Angry);
        default:
          return IconHandler.getReactIcon(ReactType.none);
      }
    } else {
      return IconHandler.getReactIcon(ReactType.none);
    }
  }
}
