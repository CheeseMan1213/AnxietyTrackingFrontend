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
        title: Text('Anxiety Entry'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        //color: Colors.g,
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
        child: Builder(
          builder: (context) => Form(
            key: this._formKey,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Text(
                        displayDate(anxEntry.getDate()) + ':',
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  //width: 200,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Today was:',
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  // Row 1
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      // For Awesome
                      onChanged: (int e) => selectThisRadioButton(e),
                      activeColor: Colors.black,
                      value: 1,
                      groupValue: this.groupValue,
                    ),
                    Text('Awesome'),
                    Radio(
                      // For Good
                      onChanged: (int e) => selectThisRadioButton(e),
                      activeColor: Colors.black,
                      value: 2,
                      groupValue: this.groupValue,
                    ),
                    Text('Good'),
                    Radio(
                      // For Fine
                      onChanged: (int e) => selectThisRadioButton(e),
                      activeColor: Colors.black,
                      value: 3,
                      groupValue: this.groupValue,
                    ),
                    Text('Fine'),
                  ],
                ),
                Row(
                  // Row 2
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      // For NotSoGood
                      onChanged: (int e) => selectThisRadioButton(e),
                      activeColor: Colors.black,
                      value: 4,
                      groupValue: this.groupValue,
                    ),
                    Text('Not so good'),
                    Radio(
                      // For Terrible
                      onChanged: (int e) => selectThisRadioButton(e),
                      activeColor: Colors.black,
                      value: 5,
                      groupValue: this.groupValue,
                    ),
                    Text('Terrible'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Because:',
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 36.0,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: this._anxEntryController,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.white,
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 5,
                  maxLength: 194,
                  maxLengthEnforced: true,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    //labelText: 'Anxiety Entry:',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),

                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.white,
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          style: BorderStyle.solid,
                          width: 5.0,
                          color: Colors.purple
                        ),
                      ),
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
                  ],
                ),
                //Data to later save to database.
                Text(anxEntry.getAnxEntry()),
                Text(displayDate(anxEntry.getDate())),
                Text(anxEntry.getTodayWas().toString()),
                RaisedButton(
                  child: Text('Return to homepage'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectThisRadioButton(int e) {
    setState(() {
      if (e == 1) {
        this.groupValue = 1;
      }
      switch (e) {
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

  String displayDate(DateTime date) {
    return date.month.toString() +
        '/' +
        date.day.toString() +
        '/' +
        date.year.toString();
  }
}
