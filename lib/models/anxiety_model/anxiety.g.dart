// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anxiety.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Anxiety _$AnxietyFromJson(Map<String, dynamic> json) {
  return Anxiety(
    json['date'] as String,
    json['anxEntry'] as String,
    json['todayWas'] as String,
  )..id = json['_id'] as String;
}

Map<String, dynamic> _$AnxietyToJson(Anxiety instance) => <String, dynamic>{
      '_id': instance.id,
      'date': instance.date,
      'anxEntry': instance.anxEntry,
      'todayWas': instance.todayWas,
    };
