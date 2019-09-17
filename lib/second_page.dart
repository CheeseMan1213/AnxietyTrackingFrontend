import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Page'),
      ),
      body: Column(
        children: <Widget>[
          Text('Routing 2'),
          RaisedButton(
            child: Text('Anxiety Entry'),
            onPressed: () {
              Navigator.of(context).pushNamed('/anxiety_entry');
            },
          ),
        ],
      ),
    );
  }
}
