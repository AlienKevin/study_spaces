import 'package:flutter/material.dart';

import 'main.dart';

/// Check if [queryHours] is during the [duringHours].
bool isOpenDuring(OpeningHours queryHours, OpeningHours duringHours) {
  return duringHours.when(
      closed: () => false,
      allDay: () => true,
      range: (TimeOfDay duringStart, TimeOfDay duringEnd) => queryHours.when(
          closed: () => false,
          allDay: () => false,
          range: (TimeOfDay queryStart, TimeOfDay queryEnd) {
            // print("queryStart: " + queryStart.toString());
            // print("queryEnd: " + queryEnd.toString());
            // print("duringStart: " + duringStart.toString());
            // print("duringEnd: " + duringEnd.toString());
            return timeOfDayLessThanEqual(duringStart, queryStart) &&
                timeOfDayLessThanEqual(queryEnd, duringEnd);
          }));
}

/// Convert [OpeningHours] to [String] for display.
String openingHoursToString(OpeningHours hours) {
  return hours.when(
      closed: () => "Closed",
      allDay: () => "24H",
      range: (start, end) =>
          timeOfDayToString(start) + " - " + timeOfDayToString(end));
}

/// Convert [TimeOfDay] to [String] for display.
/// Truncates ":00" if minute is 0
String timeOfDayToString(TimeOfDay time) {
  String _addLeadingZeroIfNeeded(int value) {
    if (value < 10) return '0$value';
    return value.toString();
  }

  if (time.hour > 12) {
    return (time.hour - 12).toString() +
        (time.minute == 0 ? "" : ":" + _addLeadingZeroIfNeeded(time.minute)) +
        "PM";
  } else {
    return time.hour.toString() +
        (time.minute == 0 ? "" : ":" + _addLeadingZeroIfNeeded(time.minute)) +
        "AM";
  }
}

String weekdayToString(int weekday) {
  switch (weekday) {
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    case 7:
      return "Sunday";
    default:
      throw "Invalid weekday $weekday.";
  }
}

/// Convert an [int] to a [TimeOfDay]
TimeOfDay intToTimeOfDay(int n) => TimeOfDay(hour: n ~/ 100, minute: n % 100);

/// Convert a [TimeOfDay] to an [int]
int timeOfDayToInt(TimeOfDay time) => time.hour * 100 + time.minute;

bool timeOfDayLessThanEqual(TimeOfDay t1, TimeOfDay t2) =>
    timeOfDayToDouble(t1) <= timeOfDayToDouble(t2);

double timeOfDayToDouble(TimeOfDay myTime) =>
    myTime.hour + myTime.minute / 60.0;
