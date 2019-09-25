import 'package:anxiety_tracking_front_end/today_was.dart';

class AnxietyTrackingEntity {
  DateTime _date;
  String _anxEntry;
  TodayWas _todayWas;

  AnxietyTrackingEntity(this._date, this._anxEntry, this._todayWas);

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