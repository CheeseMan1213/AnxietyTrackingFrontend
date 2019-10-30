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
class AnxietyEntryPage extends StatelessWidget {

  final DateTime date;

  static const String serverIP = StaticServerIP.serverIP;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _anxEntryController = TextEditingController();
  //var _data;
  final ScopedAnxiety scopedAnxiety = ScopedAnxiety();// ScopedModel that allows for state management.
  //int groupValue;//= scopedAnxiety.anxietyBabyClass.groupValue;

  AnxietyEntryPage({Key key, @required this.date})
      : super(key: key){
          /*scopedAnxiety.getData(this.date.toIso8601String()).then((data) {
            //I intentionally do not use data here because I am just trying to get let the http call
            //finish.
            print("From constructor = " + scopedAnxiety.anxietyBabyClass.data[0].getAnxEntry());
          });*/

          //Sets the initial color to be the green gradient.
          scopedAnxiety.updateGradientColor(1);
  }

  @override
  Widget build(BuildContext context) {
    //scopedAnxiety.getData(this.date.toIso8601String());
    //This page gets the date the user chose from the previous page.
    /*scopedAnxiety.getData(this.date.toIso8601String()).then((data) {
      //I intentionally do not use data here because I am just trying to get let the http call
      //finish.

    });*/

    //check for before the async call has returned. This is the loading screen.
    if(scopedAnxiety.anxietyBabyClass.data == null) {
      scopedAnxiety.getData(this.date.toIso8601String()).then((data) {
        //I intentionally do not use data here because I am just trying to get let the http call
        //finish.
        //print("From loading if statement = " + scopedAnxiety.anxietyBabyClass.data.toString());
        if(scopedAnxiety.anxietyBabyClass.data == null || scopedAnxiety.anxietyBabyClass.data.isEmpty) {
          _anxEntryController.text = "";//No entry yet.
          /*setState(() {
            //
          });*/
        }
        else {
          //Populates text for field with date from database if it is there.
          _anxEntryController.text = scopedAnxiety.anxietyBabyClass.data[0].getAnxEntry();
          //sets state of radio button from database.
          selectThisRadioButton(scopedAnxiety.anxietyBabyClass.data[0].getTodayWasAsInteger());
          /*setState(() {
            //
          });*/
        }
      });
      //return LoadingScreen();
      return ScopedModel<ScopedAnxiety>(
        model: scopedAnxiety,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Anxiety Entry'),
          ),
          body: ScopedModelDescendant<ScopedAnxiety>(
            builder: (context, child, model) =>
                GestureDetector(
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
                                        displayDate(date.toIso8601String()) + ':',
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
                                      groupValue: scopedAnxiety.anxietyBabyClass.groupValue,
                                    ),
                                    Text('Awesome'),
                                    Radio(
                                      // For Good
                                      onChanged: (int e) => selectThisRadioButton(e),
                                      activeColor: Colors.black,
                                      value: 2,// When matches 'groupValue' the radio button gets selected.
                                      groupValue: scopedAnxiety.anxietyBabyClass.groupValue,
                                    ),
                                    Text('Good'),
                                    Radio(
                                      // For Fine
                                      onChanged: (int e) => selectThisRadioButton(e),
                                      activeColor: Colors.black,
                                      value: 3,// When matches 'groupValue' the radio button gets selected.
                                      groupValue: scopedAnxiety.anxietyBabyClass.groupValue,
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
                                      groupValue: scopedAnxiety.anxietyBabyClass.groupValue,
                                    ),
                                    Text('Not so good'),
                                    Radio(
                                      // For Terrible
                                      onChanged: (int e) => selectThisRadioButton(e),
                                      activeColor: Colors.black,
                                      value: 5,// When matches 'groupValue' the radio button gets selected.
                                      groupValue: scopedAnxiety.anxietyBabyClass.groupValue,
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
                                    if(scopedAnxiety.anxietyBabyClass.groupValue == null || scopedAnxiety.anxietyBabyClass.groupValue == 0) {
                                      return 'Please select how your day was.';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    /*setState(() {
                              _anxEntry.setAnxEntry(val);
                              _data[0].setAnxEntry(val);
                            });*/
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    DeleteButton(date.toIso8601String()),
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
                                          if(model.anxietyBabyClass.data == null || model.anxietyBabyClass.data.isEmpty) {
                                            await AnxietyService.postAnxiety('http://' + serverIP + '/anxieties', date.toIso8601String(), _anxEntryController.text, selectThisRadioButton(scopedAnxiety.anxietyBabyClass.groupValue));
                                            await model.getData(this.date.toIso8601String());
                                            print("Did a post.");
                                            Scaffold.of(context).showSnackBar(SnackBar(duration: const Duration(seconds: 1), content: Text('Created new entry.')));
                                            //This line fixes a bug where if the user picks a date with no entry in the database,
                                            // it will continue to create new entries, instead of create once, then update.
                                            /*await AnxietyService.getAnxietyByDate('http://' + serverIP + ':60000/anxieties/' + date.toIso8601String()).then((data) {
                                      setState(() {
                                        this._data = data;
                                      });
                                    });*/
                                            //if it is still null or empty after the post.
                                            if(model.anxietyBabyClass.data == null || model.anxietyBabyClass.data.isEmpty) {
                                              _anxEntryController.text = "There was an error with the post.";
                                              /*setState(() {
                                        //
                                      });*/
                                            }
                                            else {
                                              //Populates text for field with date from database if it is there.
                                              _anxEntryController.text = model.anxietyBabyClass.data[0].getAnxEntry();
                                              //sets state of radio button from database.
                                              selectThisRadioButton(model.anxietyBabyClass.data[0].getTodayWasAsInteger());
                                              /*setState(() {
                                        //
                                      });*/
                                            }
                                          }
                                          //else update the existing one.
                                          else {
                                            print('made it to the else.');
                                            model.anxietyBabyClass.data[0].setAnxEntry(_anxEntryController.text);
                                            model.anxietyBabyClass.data[0].setTodayWas(selectThisRadioButton(scopedAnxiety.anxietyBabyClass.groupValue).toString());
                                            await AnxietyService.putAnxiety('http://' + serverIP + '/anxieties', model.anxietyBabyClass.data[0]);
                                            await model.getData(this.date.toIso8601String());
                                            print("Did a put.");
                                            Scaffold.of(context).showSnackBar(SnackBar(duration: const Duration(seconds: 1), content: Text('Updated this entry.')));
                                            print(model.anxietyBabyClass.data);
                                          }
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          /*setState(() {
                                    //
                                  });*/
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
        ),
      );
    }

  }
  ///This function is used by the radio buttons. It is how the "change which one is selected"
  ///functionality works. When the 'group value' and the 'value' are the same, then that radio
  ///button get selected. This function also returns a string for what 'todayWas' is for use by the post method.
  String selectThisRadioButton(int e) {

    switch (e) {
      case 1:
        scopedAnxiety.updateGradientColor(1);
        //this.groupValue = 1;
        //setState(() {});
        return TodayWas.Awesome.toString();
        break;
      case 2:
        scopedAnxiety.updateGradientColor(2);
        //this.groupValue = 2;
        //setState(() {});
        return TodayWas.Good.toString();
        break;
      case 3:
        scopedAnxiety.updateGradientColor(3);
        //this.groupValue = 3;
        //setState(() {});
        return TodayWas.Fine.toString();
        break;
      case 4:
        scopedAnxiety.updateGradientColor(4);
        //this.groupValue = 4;
        //setState(() {});
        return TodayWas.NotSoGood.toString();
        break;
      case 5:
        scopedAnxiety.updateGradientColor(5);
        //this.groupValue = 5;
        //setState(() {});
        return TodayWas.Terrible.toString();
        break;
      default:
        scopedAnxiety.updateGradientColor(0);
        //this.groupValue = 0;
        //setState(() {});
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

    return gradientArray[scopedAnxiety.anxietyBabyClass.groupValue];
  }

}
