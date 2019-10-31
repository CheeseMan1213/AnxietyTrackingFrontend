import 'package:flutter/material.dart';
import '../api_services/anxiety_entity_service/anxiety_service.dart';
import '../static_server_ip/static_server_ip.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/anxiety_model/scoped_anxiety.dart';
import '../today_was.dart';

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final DateTime _date;
  static const String serverIP = StaticServerIP.serverIP;
  final TextEditingController _anxEntryController;

  SubmitButton(this._date, this._formKey, this._anxEntryController);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ScopedAnxiety>(
        builder: (context, child, model) =>
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
                    await AnxietyService.postAnxiety('http://' + serverIP + '/anxieties', _date.toIso8601String(), _anxEntryController.text, selectThisRadioButton(model.anxietyBabyClass.groupValue, model));
                    await model.getData(this._date.toIso8601String());
                    print("Did a post.");
                    Scaffold.of(context).showSnackBar(SnackBar(duration: const Duration(seconds: 1), content: Text('Created new entry.')));
                    //This line fixes a bug where if the user picks a date with no entry in the database,
                    // it will continue to create new entries, instead of create once, then update.
                    /*await AnxietyService.getAnxietyByDate('http://' + serverIP + '/anxieties/' + date.toIso8601String()).then((data) {
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
                      selectThisRadioButton(model.anxietyBabyClass.data[0].getTodayWasAsInteger(), model);
                      /*setState(() {
                                        //
                                      });*/
                    }
                  }
                  //else update the existing one.
                  else {
                    model.anxietyBabyClass.data[0].setAnxEntry(_anxEntryController.text);
                    model.anxietyBabyClass.data[0].setTodayWas(selectThisRadioButton(model.anxietyBabyClass.groupValue, model).toString());
                    await AnxietyService.putAnxiety('http://' + serverIP + '/anxieties', model.anxietyBabyClass.data[0]);
                    await model.getData(this._date.toIso8601String());
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
            ));
  }
  String selectThisRadioButton(int e, ScopedAnxiety model) {

    switch (e) {
      case 1:
        model.updateGradientColor(1);
        //this.groupValue = 1;
        //setState(() {});
        return TodayWas.Awesome.toString();
        break;
      case 2:
        model.updateGradientColor(2);
        //this.groupValue = 2;
        //setState(() {});
        return TodayWas.Good.toString();
        break;
      case 3:
        model.updateGradientColor(3);
        //this.groupValue = 3;
        //setState(() {});
        return TodayWas.Fine.toString();
        break;
      case 4:
        model.updateGradientColor(4);
        //this.groupValue = 4;
        //setState(() {});
        return TodayWas.NotSoGood.toString();
        break;
      case 5:
        model.updateGradientColor(5);
        //this.groupValue = 5;
        //setState(() {});
        return TodayWas.Terrible.toString();
        break;
      default:
        model.updateGradientColor(0);
        //this.groupValue = 0;
        //setState(() {});
        return TodayWas.NotSelectedYet.toString();
        break;
    }
  }
}