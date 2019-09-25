import 'package:anxiety_tracking_front_end/today_was.dart';
import 'package:flutter/material.dart';
import 'anxiety_entry_entity.dart';

class AnxietyEntryPage extends StatefulWidget {
  final DateTime date;

  AnxietyEntryPage({Key key, @required this.date}) : super(key: key);

  @override
  _AnxietyEntryPageState createState() => _AnxietyEntryPageState();
}

class _AnxietyEntryPageState extends State<AnxietyEntryPage> {
  AnxietyTrackingEntity _anxEntry =
      AnxietyTrackingEntity(null, 'No entry given.', TodayWas.NotSelectedYet);

  //AnxietyTrackingEntity _anxEntry = AnxietyTrackingEntity(widget.date, 'No entry given.', TodayWas.NotSelectedYet);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _anxEntryController = TextEditingController();
  int groupValue;

  @override
  Widget build(BuildContext context) {
    //AnxietyTrackingEntity anxEntry = AnxietyTrackingEntity(widget.date, 'No entry given.', TodayWas.NotSelectedYet);
    AnxietyTrackingEntity anxEntry = _anxEntry;
    _anxEntry.setDate(widget.date);

    return Scaffold(
      appBar: AppBar(
        title: Text('AnxietyEntryPage'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.lightGreen,
        child: Builder(
          builder: (context) => Form(
            key: this._formKey,
            child: Column(
              children: <Widget>[
                Text('Routing 3'),
                RaisedButton(
                  child: Text('Return to homepage'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                ),
                Text(anxEntry.getDate().month.toString() +
                    '/' +
                    anxEntry.getDate().day.toString() +
                    '/' +
                    anxEntry.getDate().year.toString()),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    controller: this._anxEntryController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    maxLength: 194,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      labelText: 'Anxiety Entry:',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please make you anxiety entry.';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      setState(() {
                        anxEntry.setAnxEntry(val);
                      });
                    },
                    //onSaved: (val) => setState()
                    //setState(() => anxEntry.setAnxEntry(val.toString())),
                  ),
                ),
                Text('How was your day?'),
                Row(// Row 1
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(// For Awesome
                      onChanged: (int e) => selectThisRadioButton(e),
                      activeColor: Colors.black,
                      value: 1,
                      groupValue: this.groupValue,
                    ),
                    Text('Awesome'),
                    Radio(// For Good
                      onChanged: (int e) => selectThisRadioButton(e),
                      activeColor: Colors.black,
                      value: 2,
                      groupValue: this.groupValue,
                    ),
                    Text('Good'),
                    Radio(// For Fine
                      onChanged: (int e) => selectThisRadioButton(e),
                      activeColor: Colors.black,
                      value: 3,
                      groupValue: this.groupValue,
                    ),
                    Text('Fine'),
                  ],
                ),
                Row(// Row 2
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(// For NotSoGood
                      onChanged: (int e) => selectThisRadioButton(e),
                      activeColor: Colors.black,
                      value: 4,
                      groupValue: this.groupValue,
                    ),
                    Text('Not so good'),
                    Radio(// For Terrible
                      onChanged: (int e) => selectThisRadioButton(e),
                      activeColor: Colors.black,
                      value: 5,
                      groupValue: this.groupValue,
                    ),
                    Text('Terrible'),
                  ],
                ),
                /*RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  splashColor: Colors.redAccent,
                  child: Text(TodayWas.Awesome.toString()),
                  onPressed: () {
                    anxEntry.setTodayWas(TodayWas.Awesome);
                    *//*setState(() {
                      anxEntry.setTodayWas(TodayWas.Awesome);
                    });*//*
                  },
                ),*/
                FlatButton(
                  color: Colors.black,
                  textColor: Colors.green,
                  splashColor: Colors.redAccent,
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                    }
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  },
                  child: Text('Submit'),
                ),
                Text(anxEntry.getAnxEntry()),
                Text(anxEntry.getDate().month.toString() +
                    '/' +
                    anxEntry.getDate().day.toString() +
                    '/' +
                    anxEntry.getDate().year.toString()),
                Text(anxEntry.getTodayWas().toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void selectThisRadioButton(int e) {
    setState(() {
      if(e == 1) {
        this.groupValue = 1;
      }
      switch(e) {
        case 1:
          this.groupValue = 1;
          this._anxEntry.setTodayWas(TodayWas.Awesome);
          break;
        case 2:
          this.groupValue = 2;
          this._anxEntry.setTodayWas(TodayWas.Good);
          break;
        case 3:
          this.groupValue = 3;
          this._anxEntry.setTodayWas(TodayWas.Fine);
          break;
        case 4:
          this.groupValue = 4;
          this._anxEntry.setTodayWas(TodayWas.NotSoGood);
          break;
        case 5:
          this.groupValue = 5;
          this._anxEntry.setTodayWas(TodayWas.Terrible);
          break;
        default:
          this.groupValue = 0;
          this._anxEntry.setTodayWas(TodayWas.NotSelectedYet);
          break;
      }
    });
  }
}
