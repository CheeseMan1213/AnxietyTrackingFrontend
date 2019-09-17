import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Your Anxiety'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/home_page_background.JPG'),
                    fit: BoxFit.fill)),
          ),
          Column(
            children: <Widget>[
              Text('Home Page'),
              RaisedButton(
                child: Text('Calendar'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/calendar_page');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
