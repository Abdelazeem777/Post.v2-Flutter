import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("SplashScreen page"),
      ),
    );
  }
}
