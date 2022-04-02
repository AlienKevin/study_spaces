import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'utils.dart';

class StudySpacePage extends StatelessWidget {
  const StudySpacePage({Key? key, required this.studySpace}) : super(key: key);

  final StudySpace studySpace;

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<Widget> hoursList = [];
    hoursList.addAll(studySpace.openingHours.mapIndexed((index, hours) {
      var day = today.add(Duration(days: index));
      return Container(
          decoration: BoxDecoration(
            border: index == 0
                ? Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  )
                : null,
          ),
          padding: index == 0
              ? const EdgeInsets.all(8)
              : const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(children: [
            Expanded(
                flex: 1, // 20%
                child: Text("${day.month}/${day.day}",
                    style: Theme.of(context).textTheme.titleLarge)),
            Expanded(
                flex: 1, // 20%
                child: Text(weekdayToString(day.weekday),
                    style: Theme.of(context).textTheme.titleLarge)),
            Expanded(
                flex: 2, // 20%
                child: Text(openingHoursToString(hours),
                    style: Theme.of(context).textTheme.titleLarge)),
          ]));
    }));
    return Scaffold(
      appBar: AppBar(
        title: Text(studySpace.title),
      ),
      body: Padding(
        padding:
            EdgeInsets.all(Theme.of(context).textTheme.titleMedium!.fontSize!),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: hoursList.length,
          itemBuilder: (BuildContext context, int index) {
            return hoursList[index];
          },
          separatorBuilder: (context, index) => SizedBox(
            height: Theme.of(context).textTheme.bodySmall!.fontSize! / 2,
          ),
          // itemExtent: 100,
        ),
      ),
    );
  }
}
