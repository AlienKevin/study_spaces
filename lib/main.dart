import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:time_range_picker/time_range_picker.dart';

part 'main.freezed.dart';

@freezed
class OpeningHours with _$OpeningHours {
  const factory OpeningHours.allDay() = AllDayOpeningHours;
  const factory OpeningHours.range(TimeOfDay start, TimeOfDay end) =
      RangeOpeningHours;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study spaces',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          )),
      home: MyHomePage(title: 'Opening Now'),
    );
  }
}

class StudySpace {
  final String name;
  final OpeningHours openingHours;
  final String pictureUrl;

  StudySpace(
      {required this.name,
      required this.openingHours,
      required this.pictureUrl});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum AppState {
  home,
  startingSearch,
  keywordSearch,
  filterSearch,
}

class _MyHomePageState extends State<MyHomePage> {
  String queryName = "";
  AppState appState = AppState.home;
  final queryController = TextEditingController();
  final FocusNode queryFocusNode = FocusNode();

  final List<StudySpace> studySpaces = [
    StudySpace(
        name: "Art, Architecture, and Engineering Library",
        openingHours: const OpeningHours.range(
            TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 22, minute: 0)),
        pictureUrl:
            "https://www.lib.umich.edu/static/542b6db6cb4cb1f683c44314617cebf8/fddf6/duderstadt2-june2019_edited.jpg"),
    StudySpace(
        name: "Hatcher Library",
        openingHours: const OpeningHours.range(
            TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 19, minute: 0)),
        pictureUrl:
            "https://www.lib.umich.edu/static/db8149c1851a919702b5eeda601def8e/fddf6/hatcher-5-june2019_edited.jpg"),
    StudySpace(
        name: "Shapiro Library",
        openingHours: const OpeningHours.allDay(),
        pictureUrl:
            "https://www.lib.umich.edu/static/a702abfd347b4a1f3591d9f4ad572594/f9008/shapiro-4-june2019_edited.jpg"),
    StudySpace(
        name: "Asian Library",
        openingHours: const OpeningHours.range(
            TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 17, minute: 0)),
        pictureUrl:
            "https://www.lib.umich.edu/static/50a94f6a1ea2e98354f34892825c57d0/fddf6/AsiaLibrary.jpg"),
    StudySpace(
        name: "Taubman Health Sciences Library",
        openingHours: const OpeningHours.range(
            TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0)),
        pictureUrl:
            "https://www.lib.umich.edu/static/ba2f579811238c27e92075de164c5c65/fddf6/taubman-3-june2019_edited.jpg"),
    StudySpace(
        name: "Askwith Media Library",
        openingHours: const OpeningHours.range(
            TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 18, minute: 0)),
        pictureUrl:
            "https://www.lib.umich.edu/static/f38a16cbb3e878b965464909b31067b8/fddf6/Shapiro-Askwith3-Feb2020_edited.jpg"),
    StudySpace(
        name: "Music Library",
        openingHours: const OpeningHours.range(
            TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0)),
        pictureUrl:
            "https://www.lib.umich.edu/static/4f747347e1b9c383e2c178100c9e0869/fddf6/earlmoore4-june2019_edited.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    var wordBoundary = RegExp(r'\W');
    var filteredStudySpaces = queryName.isNotEmpty
        ? studySpaces
            .where((space) =>
                space.name.toLowerCase().split(wordBoundary).any((word) {
                  return queryName
                      .toLowerCase()
                      .split(wordBoundary)
                      .any((queryWord) {
                    return word.similarityTo(queryWord) > 0.4;
                  });
                }))
            .toList()
        : studySpaces;
    return Scaffold(
      appBar: appState == AppState.filterSearch
          ? AppBar(
              toolbarHeight: 10,
              backgroundColor: Theme.of(context).canvasColor,
              elevation: 0,
            )
          : AppBar(
              title: TextField(
                focusNode: queryFocusNode,
                onChanged: (String name) {
                  setState(() {
                    appState = AppState.keywordSearch;
                    queryName = name;
                  });
                },
                onTap: () {
                  setState(() {
                    appState = AppState.startingSearch;
                  });
                },
                decoration: InputDecoration(
                    focusedBorder: appState == AppState.keywordSearch
                        ? UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2.0),
                          )
                        : InputBorder.none,
                    hintText: 'Where are you studying?',
                    prefixIcon: appState == AppState.keywordSearch
                        ? GestureDetector(
                            child: const Icon(Icons.arrow_back_ios_new),
                            onTap: () {
                              setState(() {
                                appState = AppState.home;
                                queryFocusNode.unfocus();
                                queryName = "";
                                queryController.clear();
                              });
                            },
                          )
                        : GestureDetector(
                            child: const Icon(Icons.search),
                            onTap: () {
                              setState(() {
                                appState = AppState.startingSearch;
                                queryFocusNode.requestFocus();
                              });
                            },
                          )),
                controller: queryController,
              ),
              backgroundColor: Theme.of(context).canvasColor,
            ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: filteredStudySpaces.length,
        itemBuilder: (BuildContext context, int index) {
          return showListItem(filteredStudySpaces[index]);
        },
        separatorBuilder: (context, index) => SizedBox(
          height: Theme.of(context).textTheme.bodySmall!.fontSize! / 2,
        ),
        // itemExtent: 100,
      ),
      floatingActionButton: appState == AppState.startingSearch
          ? FloatingActionButton.extended(
              onPressed: () async {
                setState(() {
                  appState = AppState.filterSearch;
                });
                TimeRange? result = await showTimeRangePicker(
                    context: context,
                    start: const TimeOfDay(hour: 9, minute: 0),
                    end: const TimeOfDay(hour: 22, minute: 0),
                    interval: const Duration(minutes: 30),
                    minDuration: const Duration(minutes: 30),
                    snap: true,
                    use24HourFormat: false,
                    strokeWidth: 4,
                    ticks: 24,
                    ticksOffset: -7,
                    ticksLength: 15,
                    ticksColor: Colors.grey,
                    labels: [
                      "12 am",
                      "3 am",
                      "6 am",
                      "9 am",
                      "12 pm",
                      "3 pm",
                      "6 pm",
                      "9 pm"
                    ].asMap().entries.map((e) {
                      return ClockLabel.fromIndex(
                          idx: e.key, length: 8, text: e.value);
                    }).toList(),
                    labelOffset: 35,
                    rotateLabels: false,
                    padding: 60);
                print("result: " + result.toString());
              },
              label: const Text('Search with filters'),
              icon: const Icon(Icons.filter_alt),
              backgroundColor: Theme.of(context).primaryColor,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }

  Widget showListItem(StudySpace studySpace) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: Column(
          children: [
            Text(
              studySpace.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
                height: Theme.of(context).textTheme.bodySmall!.fontSize! / 2),
            Text(openingHoursToString(studySpace.openingHours),
                style: Theme.of(context).textTheme.bodyMedium),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        )),
        SizedBox(
            width: 80,
            height: 80,
            child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: NetworkImage(studySpace.pictureUrl)))))),
      ]),
    ));
  }

  String openingHoursToString(OpeningHours hours) {
    return hours.when(
        allDay: () => "24H",
        range: (start, end) =>
            timeOfDayToString(start) + " - " + timeOfDayToString(end));
  }

  String timeOfDayToString(TimeOfDay time) {
    String _addLeadingZeroIfNeeded(int value) {
      if (value < 10) return '0$value';
      return value.toString();
    }

    if (time.hour > 12) {
      return (time.hour - 12).toString() +
          ":" +
          _addLeadingZeroIfNeeded(time.minute) +
          "PM";
    } else {
      return time.hour.toString() +
          ":" +
          _addLeadingZeroIfNeeded(time.minute) +
          "AM";
    }
  }

  @override
  void dispose() {
    queryFocusNode.dispose();
    queryController.dispose();
    super.dispose();
  }
}
