import 'package:flutter/material.dart';
import '../api_services/anxiety_entity_service/anxiety_service.dart';
import '../static_server_ip/static_server_ip.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/anxiety_model/scoped_anxiety.dart';

class DeleteButton extends StatelessWidget {
  final String _date;
  var _data;
  static const String serverIP = StaticServerIP.serverIP;

  DeleteButton(this._date, this._data);

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
                if (this._data != null && this._data.isNotEmpty) {
                  await AnxietyService.deleteAnxiety('http://' + serverIP + ':60000/deleteAnxiety', this._data[0]);
                  await model.getData(this._date);
                  print("Did a delete.");
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Deleted this entry.')));
                }
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Text('Delete'),
            ));
  }
}
