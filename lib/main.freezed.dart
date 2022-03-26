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

OpeningHours _$OpeningHoursFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'allDay':
      return AllDayOpeningHours.fromJson(json);
    case 'range':
      return RangeOpeningHours.fromJson(json);
    case 'closed':
      return ClosedOpeningHours.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'OpeningHours',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
class _$OpeningHoursTearOff {
  const _$OpeningHoursTearOff();

  AllDayOpeningHours allDay() {
    return const AllDayOpeningHours();
  }

  RangeOpeningHours range(@CustomTimeOfDayConverter() TimeOfDay start,
      @CustomTimeOfDayConverter() TimeOfDay end) {
    return RangeOpeningHours(
      start,
      end,
    );
  }

  ClosedOpeningHours closed() {
    return const ClosedOpeningHours();
  }

  OpeningHours fromJson(Map<String, Object?> json) {
    return OpeningHours.fromJson(json);
  }
}

/// @nodoc
const $OpeningHours = _$OpeningHoursTearOff();

/// @nodoc
mixin _$OpeningHours {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() allDay,
    required TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)
        range,
    required TResult Function() closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)?
        range,
    TResult Function()? closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)?
        range,
    TResult Function()? closed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllDayOpeningHours value) allDay,
    required TResult Function(RangeOpeningHours value) range,
    required TResult Function(ClosedOpeningHours value) closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    TResult Function(ClosedOpeningHours value)? closed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    TResult Function(ClosedOpeningHours value)? closed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
@JsonSerializable()
class _$AllDayOpeningHours implements AllDayOpeningHours {
  const _$AllDayOpeningHours({String? $type}) : $type = $type ?? 'allDay';

  factory _$AllDayOpeningHours.fromJson(Map<String, dynamic> json) =>
      _$$AllDayOpeningHoursFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

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
    required TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)
        range,
    required TResult Function() closed,
  }) {
    return allDay();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)?
        range,
    TResult Function()? closed,
  }) {
    return allDay?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)?
        range,
    TResult Function()? closed,
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
    required TResult Function(ClosedOpeningHours value) closed,
  }) {
    return allDay(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    TResult Function(ClosedOpeningHours value)? closed,
  }) {
    return allDay?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    TResult Function(ClosedOpeningHours value)? closed,
    required TResult orElse(),
  }) {
    if (allDay != null) {
      return allDay(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AllDayOpeningHoursToJson(this);
  }
}

abstract class AllDayOpeningHours implements OpeningHours {
  const factory AllDayOpeningHours() = _$AllDayOpeningHours;

  factory AllDayOpeningHours.fromJson(Map<String, dynamic> json) =
      _$AllDayOpeningHours.fromJson;
}

/// @nodoc
abstract class $RangeOpeningHoursCopyWith<$Res> {
  factory $RangeOpeningHoursCopyWith(
          RangeOpeningHours value, $Res Function(RangeOpeningHours) then) =
      _$RangeOpeningHoursCopyWithImpl<$Res>;
  $Res call(
      {@CustomTimeOfDayConverter() TimeOfDay start,
      @CustomTimeOfDayConverter() TimeOfDay end});
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
@JsonSerializable()
class _$RangeOpeningHours implements RangeOpeningHours {
  const _$RangeOpeningHours(@CustomTimeOfDayConverter() this.start,
      @CustomTimeOfDayConverter() this.end,
      {String? $type})
      : $type = $type ?? 'range';

  factory _$RangeOpeningHours.fromJson(Map<String, dynamic> json) =>
      _$$RangeOpeningHoursFromJson(json);

  @override
  @CustomTimeOfDayConverter()
  final TimeOfDay start;
  @override
  @CustomTimeOfDayConverter()
  final TimeOfDay end;

  @JsonKey(name: 'runtimeType')
  final String $type;

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
    required TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)
        range,
    required TResult Function() closed,
  }) {
    return range(start, end);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)?
        range,
    TResult Function()? closed,
  }) {
    return range?.call(start, end);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)?
        range,
    TResult Function()? closed,
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
    required TResult Function(ClosedOpeningHours value) closed,
  }) {
    return range(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    TResult Function(ClosedOpeningHours value)? closed,
  }) {
    return range?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    TResult Function(ClosedOpeningHours value)? closed,
    required TResult orElse(),
  }) {
    if (range != null) {
      return range(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RangeOpeningHoursToJson(this);
  }
}

abstract class RangeOpeningHours implements OpeningHours {
  const factory RangeOpeningHours(@CustomTimeOfDayConverter() TimeOfDay start,
      @CustomTimeOfDayConverter() TimeOfDay end) = _$RangeOpeningHours;

  factory RangeOpeningHours.fromJson(Map<String, dynamic> json) =
      _$RangeOpeningHours.fromJson;

  @CustomTimeOfDayConverter()
  TimeOfDay get start;
  @CustomTimeOfDayConverter()
  TimeOfDay get end;
  @JsonKey(ignore: true)
  $RangeOpeningHoursCopyWith<RangeOpeningHours> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClosedOpeningHoursCopyWith<$Res> {
  factory $ClosedOpeningHoursCopyWith(
          ClosedOpeningHours value, $Res Function(ClosedOpeningHours) then) =
      _$ClosedOpeningHoursCopyWithImpl<$Res>;
}

/// @nodoc
class _$ClosedOpeningHoursCopyWithImpl<$Res>
    extends _$OpeningHoursCopyWithImpl<$Res>
    implements $ClosedOpeningHoursCopyWith<$Res> {
  _$ClosedOpeningHoursCopyWithImpl(
      ClosedOpeningHours _value, $Res Function(ClosedOpeningHours) _then)
      : super(_value, (v) => _then(v as ClosedOpeningHours));

  @override
  ClosedOpeningHours get _value => super._value as ClosedOpeningHours;
}

/// @nodoc
@JsonSerializable()
class _$ClosedOpeningHours implements ClosedOpeningHours {
  const _$ClosedOpeningHours({String? $type}) : $type = $type ?? 'closed';

  factory _$ClosedOpeningHours.fromJson(Map<String, dynamic> json) =>
      _$$ClosedOpeningHoursFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'OpeningHours.closed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ClosedOpeningHours);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() allDay,
    required TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)
        range,
    required TResult Function() closed,
  }) {
    return closed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)?
        range,
    TResult Function()? closed,
  }) {
    return closed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allDay,
    TResult Function(@CustomTimeOfDayConverter() TimeOfDay start,
            @CustomTimeOfDayConverter() TimeOfDay end)?
        range,
    TResult Function()? closed,
    required TResult orElse(),
  }) {
    if (closed != null) {
      return closed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllDayOpeningHours value) allDay,
    required TResult Function(RangeOpeningHours value) range,
    required TResult Function(ClosedOpeningHours value) closed,
  }) {
    return closed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    TResult Function(ClosedOpeningHours value)? closed,
  }) {
    return closed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllDayOpeningHours value)? allDay,
    TResult Function(RangeOpeningHours value)? range,
    TResult Function(ClosedOpeningHours value)? closed,
    required TResult orElse(),
  }) {
    if (closed != null) {
      return closed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ClosedOpeningHoursToJson(this);
  }
}

abstract class ClosedOpeningHours implements OpeningHours {
  const factory ClosedOpeningHours() = _$ClosedOpeningHours;

  factory ClosedOpeningHours.fromJson(Map<String, dynamic> json) =
      _$ClosedOpeningHours.fromJson;
}

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

  HomeAppState home() {
    return const HomeAppState();
  }

  StartingSearchAppState startingSearch() {
    return const StartingSearchAppState();
  }

  KeywordSearchAppState keywordSearch() {
    return const KeywordSearchAppState();
  }

  FilterSearchAppState filterSearch() {
    return const FilterSearchAppState();
  }

  FilterResultsAppState filterResults({required OpeningHours openingHours}) {
    return FilterResultsAppState(
      openingHours: openingHours,
    );
  }
}

/// @nodoc
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function() startingSearch,
    required TResult Function() keywordSearch,
    required TResult Function() filterSearch,
    required TResult Function(OpeningHours openingHours) filterResults,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeAppState value) home,
    required TResult Function(StartingSearchAppState value) startingSearch,
    required TResult Function(KeywordSearchAppState value) keywordSearch,
    required TResult Function(FilterSearchAppState value) filterSearch,
    required TResult Function(FilterResultsAppState value) filterResults,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;
}

/// @nodoc
abstract class $HomeAppStateCopyWith<$Res> {
  factory $HomeAppStateCopyWith(
          HomeAppState value, $Res Function(HomeAppState) then) =
      _$HomeAppStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$HomeAppStateCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements $HomeAppStateCopyWith<$Res> {
  _$HomeAppStateCopyWithImpl(
      HomeAppState _value, $Res Function(HomeAppState) _then)
      : super(_value, (v) => _then(v as HomeAppState));

  @override
  HomeAppState get _value => super._value as HomeAppState;
}

/// @nodoc

class _$HomeAppState implements HomeAppState {
  const _$HomeAppState();

  @override
  String toString() {
    return 'AppState.home()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HomeAppState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function() startingSearch,
    required TResult Function() keywordSearch,
    required TResult Function() filterSearch,
    required TResult Function(OpeningHours openingHours) filterResults,
  }) {
    return home();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
  }) {
    return home?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
    required TResult orElse(),
  }) {
    if (home != null) {
      return home();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeAppState value) home,
    required TResult Function(StartingSearchAppState value) startingSearch,
    required TResult Function(KeywordSearchAppState value) keywordSearch,
    required TResult Function(FilterSearchAppState value) filterSearch,
    required TResult Function(FilterResultsAppState value) filterResults,
  }) {
    return home(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
  }) {
    return home?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
    required TResult orElse(),
  }) {
    if (home != null) {
      return home(this);
    }
    return orElse();
  }
}

abstract class HomeAppState implements AppState {
  const factory HomeAppState() = _$HomeAppState;
}

/// @nodoc
abstract class $StartingSearchAppStateCopyWith<$Res> {
  factory $StartingSearchAppStateCopyWith(StartingSearchAppState value,
          $Res Function(StartingSearchAppState) then) =
      _$StartingSearchAppStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$StartingSearchAppStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res>
    implements $StartingSearchAppStateCopyWith<$Res> {
  _$StartingSearchAppStateCopyWithImpl(StartingSearchAppState _value,
      $Res Function(StartingSearchAppState) _then)
      : super(_value, (v) => _then(v as StartingSearchAppState));

  @override
  StartingSearchAppState get _value => super._value as StartingSearchAppState;
}

/// @nodoc

class _$StartingSearchAppState implements StartingSearchAppState {
  const _$StartingSearchAppState();

  @override
  String toString() {
    return 'AppState.startingSearch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StartingSearchAppState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function() startingSearch,
    required TResult Function() keywordSearch,
    required TResult Function() filterSearch,
    required TResult Function(OpeningHours openingHours) filterResults,
  }) {
    return startingSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
  }) {
    return startingSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
    required TResult orElse(),
  }) {
    if (startingSearch != null) {
      return startingSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeAppState value) home,
    required TResult Function(StartingSearchAppState value) startingSearch,
    required TResult Function(KeywordSearchAppState value) keywordSearch,
    required TResult Function(FilterSearchAppState value) filterSearch,
    required TResult Function(FilterResultsAppState value) filterResults,
  }) {
    return startingSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
  }) {
    return startingSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
    required TResult orElse(),
  }) {
    if (startingSearch != null) {
      return startingSearch(this);
    }
    return orElse();
  }
}

abstract class StartingSearchAppState implements AppState {
  const factory StartingSearchAppState() = _$StartingSearchAppState;
}

/// @nodoc
abstract class $KeywordSearchAppStateCopyWith<$Res> {
  factory $KeywordSearchAppStateCopyWith(KeywordSearchAppState value,
          $Res Function(KeywordSearchAppState) then) =
      _$KeywordSearchAppStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$KeywordSearchAppStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res>
    implements $KeywordSearchAppStateCopyWith<$Res> {
  _$KeywordSearchAppStateCopyWithImpl(
      KeywordSearchAppState _value, $Res Function(KeywordSearchAppState) _then)
      : super(_value, (v) => _then(v as KeywordSearchAppState));

  @override
  KeywordSearchAppState get _value => super._value as KeywordSearchAppState;
}

/// @nodoc

class _$KeywordSearchAppState implements KeywordSearchAppState {
  const _$KeywordSearchAppState();

  @override
  String toString() {
    return 'AppState.keywordSearch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is KeywordSearchAppState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function() startingSearch,
    required TResult Function() keywordSearch,
    required TResult Function() filterSearch,
    required TResult Function(OpeningHours openingHours) filterResults,
  }) {
    return keywordSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
  }) {
    return keywordSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
    required TResult orElse(),
  }) {
    if (keywordSearch != null) {
      return keywordSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeAppState value) home,
    required TResult Function(StartingSearchAppState value) startingSearch,
    required TResult Function(KeywordSearchAppState value) keywordSearch,
    required TResult Function(FilterSearchAppState value) filterSearch,
    required TResult Function(FilterResultsAppState value) filterResults,
  }) {
    return keywordSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
  }) {
    return keywordSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
    required TResult orElse(),
  }) {
    if (keywordSearch != null) {
      return keywordSearch(this);
    }
    return orElse();
  }
}

abstract class KeywordSearchAppState implements AppState {
  const factory KeywordSearchAppState() = _$KeywordSearchAppState;
}

/// @nodoc
abstract class $FilterSearchAppStateCopyWith<$Res> {
  factory $FilterSearchAppStateCopyWith(FilterSearchAppState value,
          $Res Function(FilterSearchAppState) then) =
      _$FilterSearchAppStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$FilterSearchAppStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res>
    implements $FilterSearchAppStateCopyWith<$Res> {
  _$FilterSearchAppStateCopyWithImpl(
      FilterSearchAppState _value, $Res Function(FilterSearchAppState) _then)
      : super(_value, (v) => _then(v as FilterSearchAppState));

  @override
  FilterSearchAppState get _value => super._value as FilterSearchAppState;
}

/// @nodoc

class _$FilterSearchAppState implements FilterSearchAppState {
  const _$FilterSearchAppState();

  @override
  String toString() {
    return 'AppState.filterSearch()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FilterSearchAppState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function() startingSearch,
    required TResult Function() keywordSearch,
    required TResult Function() filterSearch,
    required TResult Function(OpeningHours openingHours) filterResults,
  }) {
    return filterSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
  }) {
    return filterSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
    required TResult orElse(),
  }) {
    if (filterSearch != null) {
      return filterSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeAppState value) home,
    required TResult Function(StartingSearchAppState value) startingSearch,
    required TResult Function(KeywordSearchAppState value) keywordSearch,
    required TResult Function(FilterSearchAppState value) filterSearch,
    required TResult Function(FilterResultsAppState value) filterResults,
  }) {
    return filterSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
  }) {
    return filterSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
    required TResult orElse(),
  }) {
    if (filterSearch != null) {
      return filterSearch(this);
    }
    return orElse();
  }
}

abstract class FilterSearchAppState implements AppState {
  const factory FilterSearchAppState() = _$FilterSearchAppState;
}

/// @nodoc
abstract class $FilterResultsAppStateCopyWith<$Res> {
  factory $FilterResultsAppStateCopyWith(FilterResultsAppState value,
          $Res Function(FilterResultsAppState) then) =
      _$FilterResultsAppStateCopyWithImpl<$Res>;
  $Res call({OpeningHours openingHours});

  $OpeningHoursCopyWith<$Res> get openingHours;
}

/// @nodoc
class _$FilterResultsAppStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res>
    implements $FilterResultsAppStateCopyWith<$Res> {
  _$FilterResultsAppStateCopyWithImpl(
      FilterResultsAppState _value, $Res Function(FilterResultsAppState) _then)
      : super(_value, (v) => _then(v as FilterResultsAppState));

  @override
  FilterResultsAppState get _value => super._value as FilterResultsAppState;

  @override
  $Res call({
    Object? openingHours = freezed,
  }) {
    return _then(FilterResultsAppState(
      openingHours: openingHours == freezed
          ? _value.openingHours
          : openingHours // ignore: cast_nullable_to_non_nullable
              as OpeningHours,
    ));
  }

  @override
  $OpeningHoursCopyWith<$Res> get openingHours {
    return $OpeningHoursCopyWith<$Res>(_value.openingHours, (value) {
      return _then(_value.copyWith(openingHours: value));
    });
  }
}

/// @nodoc

class _$FilterResultsAppState implements FilterResultsAppState {
  const _$FilterResultsAppState({required this.openingHours});

  @override
  final OpeningHours openingHours;

  @override
  String toString() {
    return 'AppState.filterResults(openingHours: $openingHours)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FilterResultsAppState &&
            const DeepCollectionEquality()
                .equals(other.openingHours, openingHours));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(openingHours));

  @JsonKey(ignore: true)
  @override
  $FilterResultsAppStateCopyWith<FilterResultsAppState> get copyWith =>
      _$FilterResultsAppStateCopyWithImpl<FilterResultsAppState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
    required TResult Function() startingSearch,
    required TResult Function() keywordSearch,
    required TResult Function() filterSearch,
    required TResult Function(OpeningHours openingHours) filterResults,
  }) {
    return filterResults(openingHours);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
  }) {
    return filterResults?.call(openingHours);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    TResult Function()? startingSearch,
    TResult Function()? keywordSearch,
    TResult Function()? filterSearch,
    TResult Function(OpeningHours openingHours)? filterResults,
    required TResult orElse(),
  }) {
    if (filterResults != null) {
      return filterResults(openingHours);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeAppState value) home,
    required TResult Function(StartingSearchAppState value) startingSearch,
    required TResult Function(KeywordSearchAppState value) keywordSearch,
    required TResult Function(FilterSearchAppState value) filterSearch,
    required TResult Function(FilterResultsAppState value) filterResults,
  }) {
    return filterResults(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
  }) {
    return filterResults?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeAppState value)? home,
    TResult Function(StartingSearchAppState value)? startingSearch,
    TResult Function(KeywordSearchAppState value)? keywordSearch,
    TResult Function(FilterSearchAppState value)? filterSearch,
    TResult Function(FilterResultsAppState value)? filterResults,
    required TResult orElse(),
  }) {
    if (filterResults != null) {
      return filterResults(this);
    }
    return orElse();
  }
}

abstract class FilterResultsAppState implements AppState {
  const factory FilterResultsAppState({required OpeningHours openingHours}) =
      _$FilterResultsAppState;

  OpeningHours get openingHours;
  @JsonKey(ignore: true)
  $FilterResultsAppStateCopyWith<FilterResultsAppState> get copyWith =>
      throw _privateConstructorUsedError;
}
