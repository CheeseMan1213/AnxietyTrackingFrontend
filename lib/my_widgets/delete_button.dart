import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/*class DeleteButton extends StatelessWidget {
  String _date;

  DeleteButton(this._date);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
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
        if(this._data != null && this._data.isNotEmpty) {
          await AnxietyService.deleteAnxiety('http://localhost:60000/deleteAnxiety', this._data[0]);
          print("Did a delete.");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Deleted this entry.')));
          await this.getAnxietyByDate('http://localhost:60000/anxieties/' + _date).then((data) {
            setState(() {
              this._data = data;
            });
          });
        }
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          //
        });
      },
      child: Text('Delete'),
    );
  }
  ///Takes a URL with a date added to the end, and sends it off to get one object back from the database.
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
        _anxEntryController.text = "No entry for this date.";
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
  }
}*/
