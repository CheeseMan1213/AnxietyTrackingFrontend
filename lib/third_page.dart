/***
 * Work Cited:
 * https://flutter.institute/run-async-operation-on-widget-creation/
 */

import 'package:anxiety_tracking_front_end/today_was.dart';
import 'package:flutter/material.dart';

import 'api_services/anxiety_entity_service/anxiety_service.dart';
import 'my_widgets/delete_button.dart';

import 'static_server_ip/static_server_ip.dart';
import 'package:scoped_model/scoped_model.dart';
import 'my_widgets/loading_screen.dart';
import 'models/anxiety_model/scoped_anxiety.dart';

///This is the anxiety entry route. It take a date for the previous route, the calender page.
///It is a stateful widget.
class AnxietyEntryPage extends StatefulWidget {
  final DateTime date;

  AnxietyEntryPage({Key key, @required this.date}) : super(key: key);

  @override
  _AnxietyEntryPageState createState() => _AnxietyEntryPageState();
}

class _AnxietyEntryPageState extends State<AnxietyEntryPage> {
  static const String serverIP = StaticServerIP.serverIP;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _anxEntryController = TextEditingController();
  //Sets the initial color to be the green gradient.
  int groupValue = 1;
  var _data;
  final ScopedAnxiety scopedAnxiety = ScopedAnxiety();// ScopedModel that allows for state management.

  @override
  void initState() {
    AnxietyService.getAnxietyByDate('http://' + serverIP + ':60000/anxieties/' + widget.date.toIso8601String()).then((data) {
      setState(() {
        this._data = data;
        if(this._data == null || this._data.isEmpty) {
          _anxEntryController.text = "";//No entry yet.
          setState(() {
            //
          });
        }
        else {
          //Populates text for field with date from database if it is there.
          _anxEntryController.text = this._data[0].getAnxEntry();
          //sets state of radio button from database.
          selectThisRadioButton(this._data[0].getTodayWasAsInteger());setState(() {
            //
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //This page gets the date the user chose from the previous page.

    //check for before the async call has returned. This is the loading screen.
    if(_data == null) {
      return LoadingScreen();
    }
    return ScopedModel<ScopedAnxiety>(
      model: scopedAnxiety,
      child: Scaffold(
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
                    //colors: [Colors.green[800], Colors.green[600], Colors.green[400], Colors.green[200],],
                    //colors: gradientArray[4],
                    colors: getGradient(),
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
                                displayDate(widget.date.toIso8601String()) + ':',
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
                          //The controller adds additional functionality and data retrieval to the TextFormField()
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
                            labelText: 'Anxiety Entry:',
                            hintText: "No entry yet.",
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
                            if(this.groupValue == null || this.groupValue == 0) {
                              return 'Please select how your day was.';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              //_anxEntry.setAnxEntry(val);
                              //_data[0].setAnxEntry(val);
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            DeleteButton(widget.date.toIso8601String(), this._data),
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
                              onPressed: () async {
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();//save data to local variables.
                                  //If there is no entry, add a new one once.
                                  if(this._data == null || this._data.isEmpty) {
                                    await AnxietyService.postAnxiety('http://' + serverIP + ':60000/anxieties', widget.date.toIso8601String(), _anxEntryController.text, selectThisRadioButton(this.groupValue));
                                    print("Did a post.");
                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Created new entry.')));
                                    //This line fixes a bug where if the user picks a date with no entry in the database,
                                    // it will continue to create new entries, instead of create once, then update.
                                    await AnxietyService.getAnxietyByDate('http://' + serverIP + ':60000/anxieties/' + widget.date.toIso8601String()).then((data) {
                                      setState(() {
                                        this._data = data;
                                      });
                                    });
                                    //if it is still null or empty after the post.
                                    if(this._data == null || this._data.isEmpty) {
                                      _anxEntryController.text = "There was an error with the post.";
                                      setState(() {
                                        //
                                      });
                                    }
                                    else {
                                      //Populates text for field with date from database if it is there.
                                      _anxEntryController.text = this._data[0].getAnxEntry();
                                      //sets state of radio button from database.
                                      selectThisRadioButton(this._data[0].getTodayWasAsInteger());setState(() {
                                        //
                                      });
                                    }
                                  }
                                  //else update the existing one.
                                  else {
                                    print('made it to the else.');
                                    this._data[0].setAnxEntry(_anxEntryController.text);
                                    this._data[0].setTodayWas(selectThisRadioButton(this.groupValue).toString());
                                    await AnxietyService.putAnxiety('http://' + serverIP + ':60000/anxieties', this._data[0]);
                                    print("Did a put.");
                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Updated this entry.')));
                                    print(this._data);
                                  }
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  setState(() {
                                    //
                                  });
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
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
      ),
    );
  }
  ///This function is used by the radio buttons. It is how the "change which one is selected"
  ///functionality works. When the 'group value' and the 'value' are the same, then that radio
  ///button get selected. This function also returns a string for what 'todayWas' is for use by the post method.
  String selectThisRadioButton(int e) {

    switch (e) {
      case 1:
        this.groupValue = 1;
        setState(() {});
        return TodayWas.Awesome.toString();
        break;
      case 2:
        this.groupValue = 2;
        setState(() {});
        return TodayWas.Good.toString();
        break;
      case 3:
        this.groupValue = 3;
        setState(() {});
        return TodayWas.Fine.toString();
        break;
      case 4:
        this.groupValue = 4;
        setState(() {});
        return TodayWas.NotSoGood.toString();
        break;
      case 5:
        this.groupValue = 5;
        setState(() {});
        return TodayWas.Terrible.toString();
        break;
      default:
        this.groupValue = 0;
        setState(() {});
        return TodayWas.NotSelectedYet.toString();
        break;
    }
  }
  ///Take the DateTime object and displays only the date
  ///in month/day/year format.
  String displayDate(String date) {
    DateTime castedDate = DateTime.parse(date);
    return castedDate.month.toString() +
        '/' +
        castedDate.day.toString() +
        '/' +
        castedDate.year.toString();
  }
  ///This method uses the state of the radio buttons to also adjust the background color.
  List getGradient() {
    var gradientWhite = [Colors.white, Colors.white, Colors.white, Colors.white];
    var gradientGreen = [Colors.green[800], Colors.green[600], Colors.green[400], Colors.green[200]];
    var gradientLightGreen = [Colors.lightGreen[800], Colors.lightGreen[600], Colors.lightGreen[400], Colors.lightGreen[200]];
    var gradientYellow = [Colors.yellow[800], Colors.yellow[600], Colors.yellow[400], Colors.yellow[200]];
    var gradientOrange = [Colors.orange[800], Colors.orange[600], Colors.orange[400], Colors.orange[200]];
    var gradientRed = [Colors.red[800], Colors.red[600], Colors.red[400], Colors.red[200]];
    var gradientArray = new List(6);

    gradientArray[0] = gradientWhite;
    gradientArray[1] = gradientGreen;
    gradientArray[2] = gradientLightGreen;
    gradientArray[3] = gradientYellow;
    gradientArray[4] = gradientOrange;
    gradientArray[5] = gradientRed;

    return gradientArray[this.groupValue];
  }
  /*///Takes a URL with a date added to the end, and sends it off to get one object back from the database.
  Future getAnxietyByDate(url) async {
    var response  = await http.get(
      //Encode the url
        Uri.encodeFull(url),
        //only accept json response
        headers: {"Accept": "application/json"});
    int statusCode = response.statusCode;
    //Checks status code.
    if (statusCode == 200) {
      print('Successful Get.');
      var convertDataToJson2 = json.decode(response.body);
      var responses = convertDataToJson2.map((j) => Anxiety.fromJson(j)).toList();
      if(responses == null || responses.isEmpty) {
        this._anxEntryController.text = "No entry for this date.";
      }
      else {
        //Populates text for field with date from database if it is there.
        this._anxEntryController.text = responses[0].getAnxEntry();
        //sets state of radio button from database.
        selectThisRadioButton(responses[0].getTodayWasAsInteger());
      }
      setState(() {
        //
      });
      return responses;
    } else {
      print('Failed Get. Status code: ' + statusCode.toString());
      print(url);
      return null;
    }
  }*/
}
