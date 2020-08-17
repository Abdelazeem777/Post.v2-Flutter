import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  static const String routeName = '/NewPost';
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("NewPost page"),
      ),
    );
  }
}
