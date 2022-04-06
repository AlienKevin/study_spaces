import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'MaterialIconsSelected.dart';
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
                flex: 25,
                child: Text("${day.month}/${day.day}",
                    style: Theme.of(context).textTheme.titleLarge)),
            Expanded(
                flex: 20,
                child: Text(weekdayToString(day.weekday),
                    style: Theme.of(context).textTheme.titleLarge)),
            Expanded(
                flex: 55,
                child: Text(openingHoursToString(hours),
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleLarge)),
          ]));
    }));
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: const Icon(MaterialIconsSelected.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        )),
        body: Padding(
          padding:
              EdgeInsets.all(Theme.of(context).textTheme.bodyLarge!.fontSize!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(studySpace.title,
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(
                  height:
                      Theme.of(context).textTheme.headlineSmall!.fontSize! / 2),
              Card(
                  child: Padding(
                      padding: EdgeInsets.all(
                          Theme.of(context).textTheme.bodyLarge!.fontSize!),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Opening Hours",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            SizedBox(
                                height: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .fontSize! /
                                    2),
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: hoursList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return hoursList[index];
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .fontSize! /
                                    2,
                              ),

                              // itemExtent: 100,
                            )
                          ]))),
            ],
          ),
        ));
  }
}
