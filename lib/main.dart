import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:time_range_picker/time_range_picker.dart';

part 'main.freezed.dart';
part 'main.g.dart';

@freezed
class OpeningHours with _$OpeningHours {
  const factory OpeningHours.allDay() = AllDayOpeningHours;
  const factory OpeningHours.range(@CustomTimeOfDayConverter() TimeOfDay start,
      @CustomTimeOfDayConverter() TimeOfDay end) = RangeOpeningHours;
  const factory OpeningHours.closed() = ClosedOpeningHours;
  factory OpeningHours.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursFromJson(json);
}

class CustomTimeOfDayConverter implements JsonConverter<TimeOfDay, int> {
  const CustomTimeOfDayConverter();

  @override
  TimeOfDay fromJson(int json) => intToTimeOfDay(json);

  @override
  int toJson(TimeOfDay time) => timeOfDayToInt(time);
}

@freezed
class AppState with _$AppState {
  const factory AppState.home() = HomeAppState;
  const factory AppState.startingSearch() = StartingSearchAppState;
  const factory AppState.keywordSearch() = KeywordSearchAppState;
  const factory AppState.filterSearch() = FilterSearchAppState;
  const factory AppState.filterResults({required OpeningHours openingHours}) =
      FilterResultsAppState;
}

@JsonSerializable(explicitToJson: true)
class OpeningDateAndHours {
  late String id;
  final DateTime startDate;
  final DateTime endDate;
  final List<OpeningHours> hoursByDayOfWeek;

  OpeningDateAndHours(
      {required this.id,
      required this.startDate,
      required this.endDate,
      required this.hoursByDayOfWeek});

  factory OpeningDateAndHours.fromJson(Map<String, dynamic> json) =>
      _$OpeningDateAndHoursFromJson(json);
  Map<String, dynamic> toJson() => _$OpeningDateAndHoursToJson(this);
}

typedef HoursType = String;
typedef SpaceTitle = String;
typedef FieldOpeningHours
    = Map<HoursType, Map<SpaceTitle, List<OpeningDateAndHours>>>;
typedef ProcessedOpeningHours = Map<SpaceTitle, List<OpeningDateAndHours>>;

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
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          )),
      home: const MyHomePage(title: 'Opening Now'),
    );
  }
}

class StudySpace {
  final String title;
  List<OpeningHours> openingHours;
  final String pictureUrl;

  StudySpace(
      {required this.title,
      required this.openingHours,
      required this.pictureUrl});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String queryName = "";
  AppState appState = const AppState.home();
  final queryController = TextEditingController();
  final FocusNode queryFocusNode = FocusNode();
  ProcessedOpeningHours openingHours = {};

  List<StudySpace> studySpaces = [
    StudySpace(
        title: "Art, Architecture, and Engineering Library",
        openingHours: [const OpeningHours.allDay()],
        pictureUrl: "images/duderstadt.jpeg"),
    StudySpace(
        title: "Hatcher Library",
        openingHours: [
          const OpeningHours.range(
              TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 19, minute: 0))
        ],
        pictureUrl: "images/hatcher.jpeg"),
    StudySpace(
        title: "Shapiro Library",
        openingHours: [const OpeningHours.allDay()],
        pictureUrl: "images/shapiro.jpeg"),
    StudySpace(
        title: "Fine Arts Library",
        openingHours: [
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0))
        ],
        pictureUrl: "images/fine_arts.jpeg"),
    StudySpace(
        title: "Asia Library",
        openingHours: [
          const OpeningHours.range(
              TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 19, minute: 0))
        ],
        pictureUrl: "images/asian.jpeg"),
    StudySpace(
        title: "Taubman Health Sciences Library",
        openingHours: [
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0))
        ],
        pictureUrl: "images/taubman.jpeg"),
    StudySpace(
        title: "Music Library",
        openingHours: [
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0))
        ],
        pictureUrl: "images/music.jpeg")
  ];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      var storedLastUpdateTime = prefs.getString("openingHoursLastUpdateTime");
      // if openingHoursLastUpdateTime is not set, use the year 2,000 as the default value
      // this will force us to fetch latest opening hours from M Library API
      var lastUpdateTime = storedLastUpdateTime == null
          ? DateTime(2000)
          : DateTime.parse(storedLastUpdateTime);
      var storedOpeningHours = prefs.getString("openingHours");
      if (storedOpeningHours == null ||
          DateTime.now()
                  .difference(lastUpdateTime)
                  .compareTo(const Duration(days: 7 * 3)) >
              0) {
        fetchNewOpeningHours().then((newOpeningHours) {
          openingHours = newOpeningHours;
          prefs.setString(
              'openingHoursLastUpdateTime', DateTime.now().toIso8601String());
          prefs.setString('openingHours', jsonEncode(openingHours));
          updateOpeningHoursForNextSevenDays();
        });
      } else {
        if (kDebugMode) {
          print("Loaded opening hours from cache");
        }
        openingHours = (jsonDecode(storedOpeningHours) as Map<String, dynamic>)
            .map((title, openingHours) => MapEntry(
                title,
                (openingHours as List<dynamic>)
                    .map((hours) => OpeningDateAndHours.fromJson(hours))
                    .toList()));
        updateOpeningHoursForNextSevenDays();
      }
    });
  }

  Future<ProcessedOpeningHours> fetchNewOpeningHours() async {
    if (kDebugMode) {
      print("Fetching new opening hours from M Library API");
    }
    var buildingRequest = getFieldOpeningHours("building");
    var locationRequest = getFieldOpeningHours("location");
    return Future.wait([buildingRequest, locationRequest]).then((hours) async {
      return {
        ...processFieldOpeningHours(hours[0]),
        ...processFieldOpeningHours(hours[1]),
        ...openingHours,
      };
    });
  }

  void updateOpeningHoursForNextSevenDays() {
    List<DateTime> nextSevenDays = [];
    var nextDay = DateTime.now();
    for (var i = 0; i < 7; ++i) {
      nextSevenDays.add(nextDay);
      nextDay = nextDay.add(const Duration(days: 1));
    }
    studySpaces = studySpaces.map((space) {
      space.openingHours.clear();
      for (var day in nextSevenDays) {
        var newOpeningHours = getOpeningHours(space.title, day);
        if (kDebugMode) {
          print(
              "opening hours for ${space.title} on ${day.year}-${day.month}-${day.day} is $newOpeningHours.");
        }
        space.openingHours.add(newOpeningHours!);
      }
      return space;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var wordBoundary = RegExp(r'\W');
    var queryFilteredStudySpaces = queryName.isNotEmpty
        ? studySpaces
            .where((space) =>
                space.title.toLowerCase().split(wordBoundary).any((word) {
                  return queryName
                      .toLowerCase()
                      .split(wordBoundary)
                      .any((queryWord) {
                    return word.similarityTo(queryWord) > 0.4;
                  });
                }))
            .toList()
        : studySpaces;
    var filteredStudySpaces = appState.when(
      filterResults: (filterOpeningHours) => studySpaces
          .where((space) =>
              isOpenDuring(filterOpeningHours, space.openingHours[0]))
          .toList(),
      keywordSearch: () => queryFilteredStudySpaces,
      filterSearch: () => queryFilteredStudySpaces,
      home: () => queryFilteredStudySpaces,
      startingSearch: () => queryFilteredStudySpaces,
    );
    return Scaffold(
      appBar: appState.when(
        filterSearch: () => filterSearchAppBar(),
        filterResults: filterResultsAppBar,
        startingSearch: () => searchAppBar(),
        keywordSearch: () => searchAppBar(),
        home: () => searchAppBar(),
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
      floatingActionButton: Visibility(
          visible: appState == const AppState.startingSearch(),
          child: FloatingActionButton.extended(
            onPressed: startFiltering,
            label: const Text('Search with filters'),
            icon: const Icon(Icons.filter_alt),
            backgroundColor: Theme.of(context).primaryColor,
          )),
    );
  }

  AppBar filterResultsAppBar(OpeningHours openingHours) => AppBar(
        title: Row(children: [
          backToHomeIconButton(),
          SizedBox(
              width: Theme.of(context).textTheme.titleMedium!.fontSize! / 2),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    Theme.of(context).textTheme.titleMedium!.fontSize! * 2),
              ),
              padding: EdgeInsets.all(
                  Theme.of(context).textTheme.titleMedium!.fontSize! / 1.5),
              primary: Colors.white,
              textStyle: Theme.of(context).textTheme.titleMedium,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: startFiltering,
            child: Text(openingHoursToString(openingHours)),
          )
        ]),
        backgroundColor: Theme.of(context).canvasColor,
      );

  AppBar filterSearchAppBar() => AppBar(
        toolbarHeight: 10,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      );

  AppBar searchAppBar() => AppBar(
        title: TextField(
          focusNode: queryFocusNode,
          onChanged: (String name) {
            setState(() {
              appState = const AppState.keywordSearch();
              queryName = name;
            });
          },
          onTap: () {
            setState(() {
              appState = const AppState.startingSearch();
            });
          },
          decoration: InputDecoration(
              focusedBorder: appState == const AppState.keywordSearch()
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0),
                    )
                  : InputBorder.none,
              hintText: 'Where are you studying?',
              prefixIcon: appState == const AppState.keywordSearch()
                  ? backToHomeIconButton()
                  : startSearchingIconButton()),
          controller: queryController,
        ),
        backgroundColor: Theme.of(context).canvasColor,
      );

  Widget startSearchingIconButton() => GestureDetector(
        child: const Icon(Icons.search),
        onTap: () {
          setState(() {
            appState = const AppState.startingSearch();
            queryFocusNode.requestFocus();
          });
        },
      );

  Widget backToHomeIconButton() => GestureDetector(
        child: Icon(Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor),
        onTap: () {
          setState(() {
            appState = const AppState.home();
            queryFocusNode.unfocus();
            queryName = "";
            queryController.clear();
          });
        },
      );

  void startFiltering() async {
    setState(() {
      appState = const AppState.filterSearch();
    });
    TimeOfDay _startTime = TimeOfDay.now();
    TimeOfDay _endTime = const TimeOfDay(hour: 22, minute: 0);
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            title: const Text("Opening Hours"),
            content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 450,
                child: TimeRangePicker(
                    paintingStyle: PaintingStyle.fill,
                    strokeColor:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                    timeTextStyle: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                    activeTimeTextStyle: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                    hideButtons: true,
                    onStartChange: (start) {
                      setState(() {
                        _startTime = start;
                      });
                    },
                    onEndChange: (end) {
                      setState(() {
                        _endTime = end;
                      });
                    },
                    start: _startTime,
                    end: _endTime,
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
                    padding: 60)),
            actions: <Widget>[
              TextButton(
                  child: const Text('Back'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      appState = const AppState.home();
                    });
                  }),
              TextButton(
                child: const Text('Filter'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    appState = AppState.filterResults(
                        openingHours: OpeningHours.range(_startTime, _endTime));
                  });
                },
              ),
            ],
          );
        });
  }

  Widget showListItem(StudySpace studySpace) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudySpacePage(studySpace: studySpace),
            ));
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Column(
            children: [
              Text(
                studySpace.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                  height: Theme.of(context).textTheme.bodySmall!.fontSize! / 2),
              Text(openingHoursToString(studySpace.openingHours[0]),
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
                              image: AssetImage(studySpace.pictureUrl)))))),
        ]),
      )),
    );
  }

  String openingHoursToString(OpeningHours hours) {
    return hours.when(
        closed: () => "Closed",
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

  OpeningHours? getOpeningHours(String queryTitle, DateTime queryDate) {
    // print(openingHours[queryTitle]
    //     ?.map((hours) => "${hours.startDate} - ${hours.endDate}"));
    var dateAndHours = openingHours[queryTitle]?.firstWhere(
        (hours) =>
            (hours.startDate.isBefore(queryDate) ||
                hours.startDate.isAtSameMomentAs(queryDate)) &&
            (hours.endDate.isAfter(queryDate) ||
                hours.endDate.isAtSameMomentAs(queryDate)),
        orElse: () => throw "Can't find opening hours for $queryDate.");
    if (dateAndHours != null) {
      return dateAndHoursToHours(queryDate, dateAndHours);
    } else {
      return null;
    }
  }

  OpeningHours dateAndHoursToHours(
          DateTime queryDate, OpeningDateAndHours hours) =>
      // DateTime weekdays start from Monday with a value of 1
      // M Library API weekdays start from Sunday with a value of 0
      hours.hoursByDayOfWeek[queryDate.weekday % 7];

  ProcessedOpeningHours processFieldOpeningHours(
      FieldOpeningHours fieldOpeningHours) {
    const specialTypes = [
      "paragraph--hours_exceptions",
      "paragraph--fall_and_winter_semester_hours"
    ];
    FieldOpeningHours exception = Map.from(fieldOpeningHours);
    exception.removeWhere((hoursType, _) => hoursType != specialTypes[0]);
    FieldOpeningHours fallAndWinter = Map.from(fieldOpeningHours);
    fallAndWinter.removeWhere((hoursType, _) => hoursType != specialTypes[1]);
    FieldOpeningHours allOtherTypes = Map.from(fieldOpeningHours);
    allOtherTypes
        .removeWhere((hoursType, _) => !specialTypes.contains(hoursType));
    List<Map<SpaceTitle, List<OpeningDateAndHours>>> prioritizedHours = [
      ...exception.values,
      ...allOtherTypes.values,
      ...fallAndWinter.values
    ];
    ProcessedOpeningHours result = {};
    for (var space in studySpaces) {
      for (var hours in prioritizedHours) {
        if (hours[space.title] != null) {
          result.putIfAbsent(space.title, () => []).addAll(hours[space.title]!);
        }
      }
    }
    return result;
  }

  Future<FieldOpeningHours> getFieldOpeningHours(String spaceType) async {
    var baseUri = 'https://cms.lib.umich.edu/jsonapi/node/$spaceType/';

    final uriDesign = StandardUriDesign(Uri.parse(baseUri));

    final client = RoutingClient(uriDesign);

    // A Map from fieldHoursOpen.type (eg paragraph__hours_exceptions) to a Map from study space title to its opening hours
    FieldOpeningHours fieldOpeningHours = {};

    try {
      /// Fetch the collection.
      /// See other methods to query and manipulate resources.
      final response = await client.fetchCollection("", fields: {
        "node--$spaceType": ["title", "field_hours_open"]
      }, include: [
        "field_hours_open"
      ]);

      for (var resource in response.collection) {
        String title = resource.attributes["title"]! as String;
        if (studySpaces.map((space) => space.title).contains(title)) {
          resource.relationships["field_hours_open"]?.forEach((fieldHoursOpen) {
            var emptyOpeningHoursWithId = OpeningDateAndHours(
              id: fieldHoursOpen.id,
              hoursByDayOfWeek: [],
              endDate: DateTime(-1),
              startDate: DateTime(-1),
            );
            fieldOpeningHours
                .putIfAbsent(fieldHoursOpen.type, () => {})
                .putIfAbsent(title, () => [emptyOpeningHoursWithId])
                .add(emptyOpeningHoursWithId);
          });
        }
      }
      for (var paragraph in response.included) {
        final dynamic fieldDateRange = paragraph.attributes["field_date_range"];
        final dynamic fieldHoursOpen = paragraph.attributes["field_hours_open"];
        if (fieldDateRange == null || fieldHoursOpen == null) {
          continue;
        }
        // print(fieldDateRange["value"]);
        // print(fieldDateRange["end_value"]);
        fieldOpeningHours[paragraph.type] = Map.fromEntries(
            fieldOpeningHours[paragraph.type]!.entries.mapIndexed(
                (index, entry) => MapEntry(
                    entry.key,
                    entry.value
                        .map((period) => period.id == paragraph.id
                            ? OpeningDateAndHours(
                                id: paragraph.id,
                                startDate:
                                    DateTime.parse(fieldDateRange["value"]),
                                endDate:
                                    DateTime.parse(fieldDateRange["end_value"]),
                                hoursByDayOfWeek:
                                    (fieldHoursOpen as List).map((day) {
                                  int startHours = day["starthours"];
                                  int endHours = day["endhours"];
                                  String? comment = day["comment"];
                                  // print("$startHours $endHours $comment");
                                  if (comment == "24 hours") {
                                    return const OpeningHours.allDay();
                                  } else if (comment == "Closed") {
                                    return const OpeningHours.closed();
                                  } else {
                                    return OpeningHours.range(
                                        intToTimeOfDay(startHours),
                                        intToTimeOfDay(endHours));
                                  }
                                }).toList())
                            : period)
                        .toList())));
      }
    } on RequestFailure catch (e) {
      /// Catch error response
      for (var error in e.errors) {
        if (kDebugMode) {
          print(error.title);
        }
      }
    }
    return fieldOpeningHours;
  }

  bool timeOfDayLessThanEqual(TimeOfDay t1, TimeOfDay t2) =>
      timeOfDayToDouble(t1) <= timeOfDayToDouble(t2);

  double timeOfDayToDouble(TimeOfDay myTime) =>
      myTime.hour + myTime.minute / 60.0;

  @override
  void dispose() {
    queryFocusNode.dispose();
    queryController.dispose();
    super.dispose();
  }
}

class StudySpacePage extends StatelessWidget {
  const StudySpacePage({Key? key, required this.studySpace}) : super(key: key);

  final StudySpace studySpace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(studySpace.title),
      ),
      body: Column(children: [
        Padding(
            padding: EdgeInsets.all(
                Theme.of(context).textTheme.titleMedium!.fontSize!),
            child: Image.asset(studySpace.pictureUrl))
      ]),
    );
  }
}

TimeOfDay intToTimeOfDay(int n) => TimeOfDay(hour: n ~/ 100, minute: n % 100);

int timeOfDayToInt(TimeOfDay time) => time.hour * 100 + time.minute;
