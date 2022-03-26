// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpeningDateAndHours _$OpeningDateAndHoursFromJson(Map<String, dynamic> json) =>
    OpeningDateAndHours(
      id: json['id'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      hoursByDayOfWeek: (json['hoursByDayOfWeek'] as List<dynamic>)
          .map((e) => OpeningHours.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpeningDateAndHoursToJson(
        OpeningDateAndHours instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'hoursByDayOfWeek':
          instance.hoursByDayOfWeek.map((e) => e.toJson()).toList(),
    };

_$AllDayOpeningHours _$$AllDayOpeningHoursFromJson(Map<String, dynamic> json) =>
    _$AllDayOpeningHours(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AllDayOpeningHoursToJson(
        _$AllDayOpeningHours instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$RangeOpeningHours _$$RangeOpeningHoursFromJson(Map<String, dynamic> json) =>
    _$RangeOpeningHours(
      const CustomTimeOfDayConverter().fromJson(json['start'] as int),
      const CustomTimeOfDayConverter().fromJson(json['end'] as int),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RangeOpeningHoursToJson(_$RangeOpeningHours instance) =>
    <String, dynamic>{
      'start': const CustomTimeOfDayConverter().toJson(instance.start),
      'end': const CustomTimeOfDayConverter().toJson(instance.end),
      'runtimeType': instance.$type,
    };

_$ClosedOpeningHours _$$ClosedOpeningHoursFromJson(Map<String, dynamic> json) =>
    _$ClosedOpeningHours(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ClosedOpeningHoursToJson(
        _$ClosedOpeningHours instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
