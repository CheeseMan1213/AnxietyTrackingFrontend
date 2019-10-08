import 'dart:async';
import 'dart:convert';

import 'package:anxiety_tracking_front_end/today_was.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'anxiety_entry_entity.dart';

///This is the anxiety entry route. It take a date for the previous route, the calender page.
///It is a stateful widget.
///
class AnxietyEntryPage extends StatefulWidget {
  final DateTime date;

  AnxietyEntryPage({Key key, @required this.date}) : super(key: key);

  @override
  _AnxietyEntryPageState createState() => _AnxietyEntryPageState();
}

class _AnxietyEntryPageState extends State<AnxietyEntryPage> {
  AnxietyTrackingEntity _anxEntry = AnxietyTrackingEntity(null, 'No entry given.', TodayWas.NotSelectedYet);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _anxEntryController = TextEditingController();
  int groupValue;
  //final String url = 'http://localhost:60000/test/test';
  List data;

  @override
  void initState() {
    this.getJsonData('http://localhost:60000/test/test');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnxietyTrackingEntity anxEntry = _anxEntry;
    _anxEntry.setDate(widget.date);

    return Scaffold(
      appBar: AppBar(
        title: Text('Anxiety Entry'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
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
              child: Builder(
                builder: (context) => Form(
                  key: this._formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            child: Text(
                              displayDate(anxEntry.getDate()) + ':',
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
                            value: 1,// When matches 'groupValue' the radio button gets selected.
                            groupValue: this.groupValue,

                          ),
                          Text('Awesome'),
                          Radio(
                            // For Good
                            onChanged: (int e) => selectThisRadioButton(e),
                            activeColor: Colors.black,
                            value: 2,// When matches 'groupValue' the radio button gets selected.
                            groupValue: this.groupValue,
                          ),
                          Text('Good'),
                          Radio(
                            // For Fine
                            onChanged: (int e) => selectThisRadioButton(e),
                            activeColor: Colors.black,
                            value: 3,// When matches 'groupValue' the radio button gets selected.
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
                            value: 4,// When matches 'groupValue' the radio button gets selected.
                            groupValue: this.groupValue,
                          ),
                          Text('Not so good'),
                          Radio(
                            // For Terrible
                            onChanged: (int e) => selectThisRadioButton(e),
                            activeColor: Colors.black,
                            value: 5,// When matches 'groupValue' the radio button gets selected.
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
                                form.save();//save data to local variables.
                                //postJsonData();
                                FocusScope.of(context).requestFocus(FocusNode());
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
                      asyncDataTextWidget(),
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
          ),
        ),
      ),
    );
  }
///This function is used by the radio buttons. It is how the "change which one is selected"
  ///functionality works. When the 'group value' and the 'value' are the same, then that radio
  ///button get selected.
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
  ///Take the DateTime object and displays only the date
  ///in month/day/year format.
  String displayDate(DateTime date) {
    return date.month.toString() +
        '/' +
        date.day.toString() +
        '/' +
        date.year.toString();
  }
  Future<String> getJsonData(url) async {
    var response  = await http.get(
      //Encode the url
        Uri.encodeFull(url),
        //only accept json response
        headers: {"Accept": "application/json"}
    );
    setState(() {
      var convertDataToJson = json.decode(response.body);
      //data = convertDataToJson['results'];
      this.data = convertDataToJson;
    });
    return 'Success';
  }
  Future<String> postJsonData(url) async {
    var response  = await http.post(
      //Encode the url
        Uri.encodeFull(url),
        //only accept json response
        headers: {"Accept": "application/json"}
    );
    setState(() {
      var convertDataToJson = json.decode(response.body);
      //data = convertDataToJson['results'];
      this.data = convertDataToJson;
    });
    return 'Success';
  }
  Text asyncDataTextWidget() {
    if(this.data == null){
    return Text('LOADING.....');
    } else {
    return Text(this.data[0]['firstName'] +' '+ this.data[0]['lastName'] +' '+ this.data[0]['ttime']);
    }
  }
}
