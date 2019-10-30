import 'package:flutter/material.dart';
import '../api_services/anxiety_entity_service/anxiety_service.dart';
import '../static_server_ip/static_server_ip.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/anxiety_model/scoped_anxiety.dart';

class DeleteButton extends StatelessWidget {
  final String _date;
  static const String serverIP = StaticServerIP.serverIP;

  DeleteButton(this._date);

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
                if (model.anxietyBabyClass.data != null && model.anxietyBabyClass.data.isNotEmpty) {
                  await AnxietyService.deleteAnxiety('http://' + serverIP + '/deleteAnxiety', model.anxietyBabyClass.data[0]).then((data) async {
                    print("Did a delete.");
                    Scaffold.of(context).showSnackBar(SnackBar(duration: const Duration(seconds: 1), content: Text('Deleted this entry.')));
                  });
                  //Gives 1 second for the user to be able to see the message from the SnackBar.
                  await Future.delayed(Duration(seconds: 1));
                  //Automatically goes back to the calendar page.
                  Navigator.of(context).pop();
                }
                //FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Text('Delete'),
            ));
  }
}
