import 'dart:async';

import 'package:flutter/material.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/utils/logoAnimation.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/utils/preferences.dart';
import 'package:post/views/home/homeView.dart';
import 'package:post/views/login/loginView.dart';
import 'package:post/views/signUp/signUpView.dart';
import 'package:post/views/splashScreen/splashScreenViewModel.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = SplashScreenViewModel();
    _splashTimeout();
  }

  _splashTimeout() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, _navigationPage);
  }

  void _navigationPage() async {
    //TODO: don't forget to uncomment these lines!
    User currentUser = await CurrentUser().loadCurrentUserDataFromPreference();
    if (null == currentUser || currentUser.userName == null)
      Navigator.of(context).pushReplacementNamed(SignUp.routeName);
    else
      Navigator.of(context).pushReplacementNamed(Home.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'logo',
          child: Material(
            type: MaterialType.transparency,
            child: Image.asset(
              "lib/assets/post_main_logo.png",
              scale: 2.8,
            ),
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
        ),
      ),
    );
  }
}
