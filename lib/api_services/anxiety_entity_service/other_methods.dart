import '../../models/anxiety_model/scoped_anxiety.dart';
import '../../today_was.dart';

class OtherMethods {

  ///This function is used by the radio buttons. It is how the "change which one is selected"
  ///functionality works. When the 'group value' and the 'value' are the same, then that radio
  ///button gets selected. This function also returns a string for what 'todayWas' is for use by the post method.
  static TodayWas selectThisRadioButton(int e, ScopedAnxiety model) {

    switch (e) {
      case 1:
        model.updateGradientColor(1);
        return TodayWas.Awesome;
        break;
      case 2:
        model.updateGradientColor(2);
        return TodayWas.Good;
        break;
      case 3:
        model.updateGradientColor(3);
        return TodayWas.Fine;
        break;
      case 4:
        model.updateGradientColor(4);
        return TodayWas.NotSoGood;
        break;
      case 5:
        model.updateGradientColor(5);
        return TodayWas.Terrible;
        break;
      default:
        model.updateGradientColor(0);
        return TodayWas.NotSelectedYet;
        break;
    }
  }
}