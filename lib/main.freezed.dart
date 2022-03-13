// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OpeningHoursTearOff {
  const _$OpeningHoursTearOff();

  AllDayOpeningHours allDay() {
    return const AllDayOpeningHours();
  }

  RangeOpeningHours range(TimeOfDay start, TimeOfDay end) {
    return RangeOpeningHours(
      start,
      end,
    );
  }
}

/// @nodoc
const $OpeningHours = _$OpeningHoursTearOff();

/// @nodoc
mixin _$OpeningHours {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() allDay,
    required TResult Function(TimeOfDay start, TimeOfDay end) range,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(TimeOfDay start, TimeOfDay end)? range,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(TimeOfDay start, TimeOfDay end)? range,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllDayOpeningHours value) allDay,
    required TResult Function(RangeOpeningHours value) range,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpeningHoursCopyWith<$Res> {
  factory $OpeningHoursCopyWith(
          OpeningHours value, $Res Function(OpeningHours) then) =
      _$OpeningHoursCopyWithImpl<$Res>;
}

/// @nodoc
class _$OpeningHoursCopyWithImpl<$Res> implements $OpeningHoursCopyWith<$Res> {
  _$OpeningHoursCopyWithImpl(this._value, this._then);

  final OpeningHours _value;
  // ignore: unused_field
  final $Res Function(OpeningHours) _then;
}

/// @nodoc
abstract class $AllDayOpeningHoursCopyWith<$Res> {
  factory $AllDayOpeningHoursCopyWith(
          AllDayOpeningHours value, $Res Function(AllDayOpeningHours) then) =
      _$AllDayOpeningHoursCopyWithImpl<$Res>;
}

/// @nodoc
class _$AllDayOpeningHoursCopyWithImpl<$Res>
    extends _$OpeningHoursCopyWithImpl<$Res>
    implements $AllDayOpeningHoursCopyWith<$Res> {
  _$AllDayOpeningHoursCopyWithImpl(
      AllDayOpeningHours _value, $Res Function(AllDayOpeningHours) _then)
      : super(_value, (v) => _then(v as AllDayOpeningHours));

  @override
  AllDayOpeningHours get _value => super._value as AllDayOpeningHours;
}

/// @nodoc

class _$AllDayOpeningHours implements AllDayOpeningHours {
  const _$AllDayOpeningHours();

  @override
  String toString() {
    return 'OpeningHours.allDay()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AllDayOpeningHours);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() allDay,
    required TResult Function(TimeOfDay start, TimeOfDay end) range,
  }) {
    return allDay();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(TimeOfDay start, TimeOfDay end)? range,
  }) {
    return allDay?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(TimeOfDay start, TimeOfDay end)? range,
    required TResult orElse(),
  }) {
    if (allDay != null) {
      return allDay();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllDayOpeningHours value) allDay,
    required TResult Function(RangeOpeningHours value) range,
  }) {
    return allDay(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
  }) {
    return allDay?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    required TResult orElse(),
  }) {
    if (allDay != null) {
      return allDay(this);
    }
    return orElse();
  }
}

abstract class AllDayOpeningHours implements OpeningHours {
  const factory AllDayOpeningHours() = _$AllDayOpeningHours;
}

/// @nodoc
abstract class $RangeOpeningHoursCopyWith<$Res> {
  factory $RangeOpeningHoursCopyWith(
          RangeOpeningHours value, $Res Function(RangeOpeningHours) then) =
      _$RangeOpeningHoursCopyWithImpl<$Res>;
  $Res call({TimeOfDay start, TimeOfDay end});
}

/// @nodoc
class _$RangeOpeningHoursCopyWithImpl<$Res>
    extends _$OpeningHoursCopyWithImpl<$Res>
    implements $RangeOpeningHoursCopyWith<$Res> {
  _$RangeOpeningHoursCopyWithImpl(
      RangeOpeningHours _value, $Res Function(RangeOpeningHours) _then)
      : super(_value, (v) => _then(v as RangeOpeningHours));

  @override
  RangeOpeningHours get _value => super._value as RangeOpeningHours;

  @override
  $Res call({
    Object? start = freezed,
    Object? end = freezed,
  }) {
    return _then(RangeOpeningHours(
      start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
    ));
  }
}

/// @nodoc

class _$RangeOpeningHours implements RangeOpeningHours {
  const _$RangeOpeningHours(this.start, this.end);

  @override
  final TimeOfDay start;
  @override
  final TimeOfDay end;

  @override
  String toString() {
    return 'OpeningHours.range(start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RangeOpeningHours &&
            const DeepCollectionEquality().equals(other.start, start) &&
            const DeepCollectionEquality().equals(other.end, end));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(start),
      const DeepCollectionEquality().hash(end));

  @JsonKey(ignore: true)
  @override
  $RangeOpeningHoursCopyWith<RangeOpeningHours> get copyWith =>
      _$RangeOpeningHoursCopyWithImpl<RangeOpeningHours>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() allDay,
    required TResult Function(TimeOfDay start, TimeOfDay end) range,
  }) {
    return range(start, end);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(TimeOfDay start, TimeOfDay end)? range,
  }) {
    return range?.call(start, end);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(TimeOfDay start, TimeOfDay end)? range,
    required TResult orElse(),
  }) {
    if (range != null) {
      return range(start, end);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllDayOpeningHours value) allDay,
    required TResult Function(RangeOpeningHours value) range,
  }) {
    return range(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
  }) {
    return range?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    required TResult orElse(),
  }) {
    if (range != null) {
      return range(this);
    }
    return orElse();
  }
}

abstract class RangeOpeningHours implements OpeningHours {
  const factory RangeOpeningHours(TimeOfDay start, TimeOfDay end) =
      _$RangeOpeningHours;

  TimeOfDay get start;
  TimeOfDay get end;
  @JsonKey(ignore: true)
  $RangeOpeningHoursCopyWith<RangeOpeningHours> get copyWith =>
      throw _privateConstructorUsedError;
}
