import 'package:flutter/material.dart';

///This widget gets displayed if you try to navigate to an incorrect route.
class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Error Page.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 36.0,
        ),
      ),
    );
  }
}