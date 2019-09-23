import 'package:anxiety_tracking_front_end/today_was.dart';
import 'package:flutter/material.dart';

class AnxietyEntryPage extends StatefulWidget {
  DateTime date;

  AnxietyEntryPage({Key key, @required this.date}) : super(key: key);

  @override
  _AnxietyEntryPageState createState() => _AnxietyEntryPageState();
}

class _AnxietyEntryPageState extends State<AnxietyEntryPage> {
  String _anxEntry = 'No entry given.';

  TodayWas todayWas;

  final TextEditingController _anxEntryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnxietyEntryPage'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text('Routing 3'),
            RaisedButton(
              child: Text('Return to homepage'),
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
            Text(widget.date.month.toString() +
                '/' +
                widget.date.day.toString() +
                '/' +
                widget.date.year.toString()),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: TextFormField(
                controller: this._anxEntryController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                maxLength: 194,
                maxLengthEnforced: true,
                decoration: InputDecoration(
                  //border: InputBorder.none,
                  hintText: 'Cats Rule',
                ),
                autofocus: true,
                autocorrect: true,
                cursorWidth: 5.0,
                cursorColor: Colors.black,
                onFieldSubmitted: (String str) {
                  setState(() {
                    this._anxEntry = str;
                  });
                },
              ),
            ),
            FlatButton(
              onPressed: () {
                Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
              },
              child: const Text('Submit'),
            ),
            Text(this._anxEntry),
          ],
        ),
      ),
    );
  }
}
