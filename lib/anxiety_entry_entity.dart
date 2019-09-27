import 'package:anxiety_tracking_front_end/today_was.dart';

///This is my entity(for MySQL people)/collection(for MongoDB people)
///for the anxiety entry.
class AnxietyTrackingEntity {

  //Member variables.
  DateTime _date;//Date that will be passed form the calendar page.
  String _anxEntry;//The anxiety entry text.
  TodayWas _todayWas;//For the radio buttons.

  //Constructor.
  AnxietyTrackingEntity(this._date, this._anxEntry, this._todayWas);

  //Getters and setters.
  DateTime getDate() {
    return _date;
  }
  String getAnxEntry() {
    return _anxEntry;
  }
  TodayWas getTodayWas() {
    return _todayWas;
  }
  void setDate(date) {
    this._date = date;
  }
  void setAnxEntry(anxEntry) {
    this._anxEntry = anxEntry;
  }
  void setTodayWas(todayWas) {
    this._todayWas = todayWas;
  }

}