import 'package:flutter/material.dart';
import '../api_services/anxiety_entity_service/anxiety_service.dart';

class DeleteButton extends StatelessWidget {
  String _date;
  var _data;
  String serverIP;

  DeleteButton(this._date, this._data, this.serverIP);

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
          await AnxietyService.deleteAnxiety('http://' + serverIP + ':60000/deleteAnxiety', this._data[0]);
          print("Did a delete.");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Deleted this entry.')));
        }
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Text('Delete'),
    );
  }
}
