/***
 * Work Cited:
 * https://flutter.institute/run-async-operation-on-widget-creation/
 */

import 'package:flutter/material.dart';

import 'my_widgets/delete_button.dart';
import 'my_widgets/radio_button.dart';
import 'my_widgets/submit_button.dart';
import 'my_widgets/anxiety_entry_form.dart';

import 'static_server_ip/static_server_ip.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/anxiety_model/scoped_anxiety.dart';
import 'api_services/anxiety_entity_service/other_methods.dart';

///This is the anxiety entry route. It take a date for the previous route, the calender page.
///It is a stateful widget.
class AnxietyEntryPage extends StatelessWidget {

  final DateTime date;

  static const String serverIP = StaticServerIP.serverIP;
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _anxEntryController = TextEditingController();//The controller adds additional functionality and data retrieval to the TextFormField()
  final ScopedAnxiety scopedAnxiety = ScopedAnxiety();// ScopedModel that allows for state management.

  AnxietyEntryPage({Key key, @required this.date})
      : super(key: key){
          //Sets the initial color to be the green gradient.
          scopedAnxiety.updateGradientColor(1);
  }

  @override
  Widget build(BuildContext context) {
    //This page gets the date the user chose from the previous page.

    //check for before the async call has returned. This is the loading screen.
    if(scopedAnxiety.anxietyBabyClass.data == null) {
      scopedAnxiety.getData(this.date.toIso8601String()).then((data) {
        //I intentionally do not use data here because I am just trying to get let the http call
        //finish.
        //print("From loading if statement = " + scopedAnxiety.anxietyBabyClass.data.toString());
        if(scopedAnxiety.anxietyBabyClass.data == null || scopedAnxiety.anxietyBabyClass.data.isEmpty) {
          _anxEntryController.text = "";//No entry yet.
        }
        else {
          //Populates text for field with date from database if it is there.
          _anxEntryController.text = scopedAnxiety.anxietyBabyClass.data[0].getAnxEntry();
          //sets state of radio button from database.
          OtherMethods.selectThisRadioButton(scopedAnxiety.anxietyBabyClass.data[0].getTodayWasAsInteger(), scopedAnxiety);
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
                            colors: getGradient(),
                          ),
                        ),
                        child: Builder(
                          builder: (context) => Form(
                            key: _formKey,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Today was:',
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
                                    RadioButton(1),
                                    Text('Awesome'),
                                    RadioButton(2),
                                    Text('Good'),
                                    RadioButton(3),
                                    Text('Fine'),
                                  ],
                                ),
                                Row(
                                  // Row 2
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RadioButton(4),
                                    Text('Not so good'),
                                    RadioButton(5),
                                    Text('Terrible'),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Because:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 36.0,
                                      ),
                                    ),
                                  ],
                                ),
                                AnxietyEntryForm(_anxEntryController),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    DeleteButton(date.toIso8601String()),
                                    SubmitButton(date, _formKey, _anxEntryController),
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
