/***
 * IMPORTANT: If you make changes to this file, you must run this command
 * without the outer most quotes
 * from the Terminal from the this projects root directory.
 * command = 'flutter pub run build_runner build'
 */
import 'package:anxiety_tracking_front_end/today_was.dart';
import 'package:json_annotation/json_annotation.dart';
part 'anxiety.g.dart';

///This is my entity(for MySQL people)/collection(for MongoDB people)
///for the anxiety entry.
@JsonSerializable(explicitToJson: true)
class Anxiety {

  //Member variables.
  @JsonKey(name: "_id")
  String id;
  String date;//Date that will be passed form the calendar page.
  String anxEntry;//The anxiety entry text.
  String todayWas;//For the radio buttons.

  //Constructor.
  //I do not include the id in the constructor because I want MongoDB to handle the
  //auto generation of the primary key.
  Anxiety(this.date, this.anxEntry, this.todayWas);

  factory Anxiety.fromJson(Map<String, dynamic> json) => _$AnxietyFromJson(json);
  Map<String, dynamic> toJson() => _$AnxietyToJson(this);

  //Getters and setters.
  String getId() {
    return id;
  }
  String getDate() {
    return date;
  }
  String getAnxEntry() {
    return anxEntry;
  }
  String getTodayWas() {
    return todayWas;
  }
  void setId(id) {
    this.id = id;
  }
  void setDate(date) {
    this.date = date;
  }
  void setAnxEntry(anxEntry) {
    this.anxEntry = anxEntry;
  }
  void setTodayWas(todayWas) {
    this.todayWas = todayWas;
  }

}