// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anxiety.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Anxiety _$AnxietyFromJson(Map<String, dynamic> json) {
  return Anxiety(
    json['date'] as String,
    json['anxEntry'] as String,
    _$enumDecodeNullable(_$TodayWasEnumMap, json['todayWas']),
  )..id = json['_id'] as String;
}

Map<String, dynamic> _$AnxietyToJson(Anxiety instance) => <String, dynamic>{
      '_id': instance.id,
      'date': instance.date,
      'anxEntry': instance.anxEntry,
      'todayWas': _$TodayWasEnumMap[instance.todayWas],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TodayWasEnumMap = {
  TodayWas.NotSelectedYet: 'NotSelectedYet',
  TodayWas.Awesome: 'Awesome',
  TodayWas.Good: 'Good',
  TodayWas.Fine: 'Fine',
  TodayWas.NotSoGood: 'NotSoGood',
  TodayWas.Terrible: 'Terrible',
};
