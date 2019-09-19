import 'package:flutter/material.dart';

class AnxietyEntryPage extends StatelessWidget {
  final String data;

  AnxietyEntryPage({Key key, @required this.data}) : super(key: key);

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
          Text(data.toString()),
        ],
      ),
    );
  }
}
