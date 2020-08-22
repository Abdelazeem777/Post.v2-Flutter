import 'package:flutter/material.dart';

class OrLineSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Divider(
            color: Colors.grey[350],
            thickness: 2,
          ),
        ),
        Text(
          "or",
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }
}
