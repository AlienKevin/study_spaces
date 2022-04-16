import 'package:flutter/material.dart';
import 'package:mstudy/utils.dart';
import 'package:test/test.dart';

void main() {
  test('timeOfDayToString', () {
    expect(timeOfDayToString(const TimeOfDay(hour: 0, minute: 0)), "12AM");
    expect(timeOfDayToString(const TimeOfDay(hour: 0, minute: 59)), "12:59AM");

    expect(timeOfDayToString(const TimeOfDay(hour: 1, minute: 0)), "1AM");
    expect(timeOfDayToString(const TimeOfDay(hour: 8, minute: 0)), "8AM");
    expect(timeOfDayToString(const TimeOfDay(hour: 9, minute: 30)), "9:30AM");
    expect(timeOfDayToString(const TimeOfDay(hour: 11, minute: 59)), "11:59AM");

    expect(timeOfDayToString(const TimeOfDay(hour: 12, minute: 0)), "12PM");
    expect(timeOfDayToString(const TimeOfDay(hour: 12, minute: 59)), "12:59PM");

    expect(timeOfDayToString(const TimeOfDay(hour: 13, minute: 0)), "1PM");
    expect(timeOfDayToString(const TimeOfDay(hour: 14, minute: 30)), "2:30PM");
    expect(timeOfDayToString(const TimeOfDay(hour: 20, minute: 0)), "8PM");
    expect(timeOfDayToString(const TimeOfDay(hour: 22, minute: 59)), "10:59PM");
    expect(timeOfDayToString(const TimeOfDay(hour: 23, minute: 59)), "11:59PM");
  });
}
