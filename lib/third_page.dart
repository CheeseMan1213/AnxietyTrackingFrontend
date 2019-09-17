import 'package:flutter/material.dart';

class AnxietyEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnxietyEntryPage'),
      ),
      body: Column(
        children: <Widget>[
          Text('Routing 3'),
          RaisedButton(
            child: Text('Return to homepage'),
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
