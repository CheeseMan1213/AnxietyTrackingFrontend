import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/anxiety_model/scoped_anxiety.dart';
import '../api_services/anxiety_entity_service/other_methods.dart';

class EntryFromDatabase extends StatelessWidget {
  //var1
  //var2

  EntryFromDatabase(ScopedAnxiety scopedAnxiety) {
    if(scopedAnxiety.anxietyBabyClass.data.isEmpty) {
      scopedAnxiety.anxietyBabyClass.readOnly.text = "No entry yet.";
      //Sets the initial color to be the green gradient.
      //scopedAnxiety.updateGradientColor(1);
      //print("hello 1");
    }
    else {
      //Populates text for field with date from database if it is there.
      scopedAnxiety.anxietyBabyClass.readOnly.text = scopedAnxiety.anxietyBabyClass.data[0].getAnxEntry();
      //sets state of radio button from database.
      //OtherMethods.selectThisRadioButton(scopedAnxiety.anxietyBabyClass.data[0].getTodayWasAsInteger(), scopedAnxiety);
      //print("hello 2");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ScopedAnxiety>(
        builder: (context, child, model) =>
            Text(
              model.anxietyBabyClass.readOnly.text,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ));
  }
}