import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String routeName = '/Home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("home page"),
      ),
    );
  }
}
