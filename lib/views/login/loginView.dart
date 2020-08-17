import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const String routeName = '/Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Login page"),
      ),
    );
  }
}
