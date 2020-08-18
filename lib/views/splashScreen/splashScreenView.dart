import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:post/resource/values/sizeConfig.dart';
import 'package:post/utils/preferences.dart';
import 'package:post/views/home/homeView.dart';
import 'package:post/views/login/loginView.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splashTimeout();
  }

  _splashTimeout() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, _navigationPage);
  }

  void _navigationPage() async {
    String currentUser = await Preferences.getUserData();
    if (null == currentUser || currentUser.isEmpty)
      Navigator.of(context).pushReplacementNamed(Login.routeName);
    else
      Navigator.of(context).pushReplacementNamed(Home.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Hero(
      tag: 'logo',
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(48),
        child: Image.asset("lib/assets/post_main_logo.png"),
      ),
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        final Hero toHero = toHeroContext.widget;
        return ScaleTransition(
          scale: animation.drive(
            Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(
                curve: Interval(0.0, 1.0, curve: PeakQuadraticCurve()),
              ),
            ),
          ),
          child: toHero.child,
        );
      },
    ));
  }
}

class PeakQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return -15 * pow(t, 2) + 15 * t + 1;
  }
}
