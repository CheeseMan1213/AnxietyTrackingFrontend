import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/anxiety_model/scoped_anxiety.dart';
import '../today_was.dart';

class RadioButton extends StatelessWidget {
  final int value;

  RadioButton(this.value);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ScopedAnxiety>(
        builder: (context, child, model) =>
            Radio(
              onChanged: (int e) => selectThisRadioButton(e, model),
              activeColor: Colors.black,
              value: this.value,// When matches 'groupValue' the radio button gets selected.
              groupValue: model.anxietyBabyClass.groupValue,
            ),
    );
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