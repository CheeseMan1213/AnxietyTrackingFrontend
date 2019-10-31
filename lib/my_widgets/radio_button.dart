import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/anxiety_model/scoped_anxiety.dart';
import '../api_services/anxiety_entity_service/other_methods.dart';

class RadioButton extends StatelessWidget {
  final int value;

  RadioButton(this.value);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ScopedAnxiety>(
        builder: (context, child, model) =>
            Radio(
              onChanged: (int e) => OtherMethods.selectThisRadioButton(e, model),
              activeColor: Colors.black,
              value: this.value,// When matches 'groupValue' the radio button gets selected.
              groupValue: model.anxietyBabyClass.groupValue,
            ),
    );
  }
}