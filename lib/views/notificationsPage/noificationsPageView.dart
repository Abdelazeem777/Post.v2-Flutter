import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  static const String routeName = '/Notifications';
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Notifications page"),
      ),
    );
  }
}
