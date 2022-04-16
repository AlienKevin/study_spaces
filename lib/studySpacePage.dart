import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'MaterialIconsSelected.dart';
import 'main.dart';
import 'utils.dart';

class OpeningHourCard extends StatelessWidget {
  const OpeningHourCard({Key? key, required this.openingHours})
      : super(key: key);

  final List<OpeningHours> openingHours;

  @override
  Widget build(BuildContext context) {
    List<Widget> hoursList = [];
    DateTime today = DateTime.now();
    hoursList.addAll(openingHours.mapIndexed((index, hours) {
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
    return Card(
        margin: EdgeInsets.zero,
        child: Padding(
            padding: EdgeInsets.all(
                Theme.of(context).textTheme.bodyLarge!.fontSize!),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Opening Hours",
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(
                  height:
                      Theme.of(context).textTheme.headlineSmall!.fontSize! / 2),
              ListView.separated(
                shrinkWrap: true,
                itemCount: hoursList.length,
                itemBuilder: (BuildContext context, int index) {
                  return hoursList[index];
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: Theme.of(context).textTheme.bodySmall!.fontSize! / 2,
                ),

                // itemExtent: 100,
              )
            ])));
  }
}

class AreasCard extends StatelessWidget {
  const AreasCard({Key? key, required this.areas}) : super(key: key);

  final List<Area> areas;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: areas.length,
        itemBuilder: (BuildContext context, int index) => Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: EdgeInsets.all(
                  Theme.of(context).textTheme.bodyLarge!.fontSize!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    areas[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                      height:
                          Theme.of(context).textTheme.bodyMedium!.fontSize! /
                              2),
                  Text(
                    "Floor: ${areas[index].floor}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                      height:
                          Theme.of(context).textTheme.headlineSmall!.fontSize! /
                              2),
                  Image.asset(
                    areas[index].pictureUrl,
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            )),
        separatorBuilder: (context, index) => SizedBox(
          width: Theme.of(context).textTheme.bodySmall!.fontSize! / 2,
        ),
      ),
    );
  }
}

class StudySpacePage extends StatelessWidget {
  const StudySpacePage({Key? key, required this.studySpace}) : super(key: key);

  final StudySpace studySpace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: TextButton.icon(
            icon: const Icon(MaterialIconsSelected.arrow_back_ios_new),
            label: Text(
              "Back",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize!),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          leadingWidth: 100,
        ),
        body: Padding(
          padding:
              EdgeInsets.all(Theme.of(context).textTheme.bodyLarge!.fontSize!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                studySpace.title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height:
                      Theme.of(context).textTheme.headlineSmall!.fontSize! / 2),
              OpeningHourCard(openingHours: studySpace.openingHours),
              SizedBox(
                  height:
                      Theme.of(context).textTheme.headlineSmall!.fontSize! / 2),
              Visibility(
                visible: studySpace.areas.isNotEmpty,
                child: Text(
                  "Areas",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.start,
                ),
              ),
              Visibility(
                visible: studySpace.areas.isNotEmpty,
                child: SizedBox(
                    height:
                        Theme.of(context).textTheme.headlineSmall!.fontSize! /
                            2),
              ),
              Visibility(
                  visible: studySpace.areas.isNotEmpty,
                  child: AreasCard(areas: studySpace.areas)),
            ],
          ),
        ));
  }
}
