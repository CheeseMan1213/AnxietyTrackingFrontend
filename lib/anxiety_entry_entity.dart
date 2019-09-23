import 'package:anxiety_tracking_front_end/today_was.dart';

class AnxietyTrackingEntity {
  final DateTime _date;
  final String _anxEntry;
  final TodayWas _todayWas;

  AnxietyTrackingEntity(this._date, this._anxEntry, this._todayWas);
}