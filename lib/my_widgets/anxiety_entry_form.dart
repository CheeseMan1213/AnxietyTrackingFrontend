import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/anxiety_model/scoped_anxiety.dart';

class AnxietyEntryForm extends StatelessWidget {
  final TextEditingController _anxEntryController;
  //var2

  AnxietyEntryForm(this._anxEntryController);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ScopedAnxiety>(
      builder: (context, child, model) =>
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
              if(model.anxietyBabyClass.groupValue == null || model.anxietyBabyClass.groupValue == 0) {
                return 'Please select how your day was.';
              }
              return null;
            },
            onSaved: (val) {
              //
            },
          ),
    );
  }
}