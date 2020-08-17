import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("SignUp page"),
      ),
    );
  }
}
