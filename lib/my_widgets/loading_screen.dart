import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Colors.green[800],
                Colors.green[600],
                Colors.green[400],
                Colors.green[200],
              ],
              //tileMode: TileMode.clamp
            ),
          ),
          child: Center(
            child: Text(
              'Loading....',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
              ),
            ),
          ),
        ),
      ),
    );
  }
}