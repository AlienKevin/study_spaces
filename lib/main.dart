import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:study_spaces/studySpacePage.dart';
import 'package:time_range_picker/time_range_picker.dart'
    deferred as time_range_picker;

import 'MaterialIconsSelected.dart';
import 'utils.dart';

part 'main.freezed.dart';
part 'main.g.dart';

/// Opening hours of a study space
///
/// Can be all day, a range from start time to end time, or closed
@freezed
class OpeningHours with _$OpeningHours {
  const factory OpeningHours.allDay() = AllDayOpeningHours;
  const factory OpeningHours.range(@CustomTimeOfDayConverter() TimeOfDay start,
      @CustomTimeOfDayConverter() TimeOfDay end) = RangeOpeningHours;
  const factory OpeningHours.closed() = ClosedOpeningHours;
  factory OpeningHours.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursFromJson(json);
}

/// Converts [TimeOfDay] to an [int] and vice versa for Json
class CustomTimeOfDayConverter implements JsonConverter<TimeOfDay, int> {
  const CustomTimeOfDayConverter();

  @override
  TimeOfDay fromJson(int json) => intToTimeOfDay(json);

  @override
  int toJson(TimeOfDay time) => timeOfDayToInt(time);
}

/// Internal states of the app
@freezed
class AppState with _$AppState {
  const factory AppState.home() = HomeAppState;
  const factory AppState.keywordSearch() = KeywordSearchAppState;
  const factory AppState.filterSearch() = FilterSearchAppState;
  const factory AppState.filterResults() = FilterResultsAppState;
}

/// A list of opening hours for each day of week, applicable from [startDate]
/// to [endDate].
///
/// An [id] is used to incorporate hours fetched from M Library API.
/// Titles are not stored in the relationships of JSON:API so [id]s
/// are the only way to find and match opening hours to study spaces.
/// Each [HoursType] of a study space has a unique [id].
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

/// Type of [OpeningDateAndHours] specified in JSON:API, e.g. "paragraph--hours_exceptions"
typedef HoursType = String;

/// Title of study spaces
typedef SpaceTitle = String;

/// Unprocessed [OpeningDateAndHours] for each study space, organized by [HoursType]
typedef FieldOpeningHours
    = Map<HoursType, Map<SpaceTitle, List<OpeningDateAndHours>>>;

/// Processed [OpeningDateAndHours] for each study space, listed in decreasing priorities.
/// Priorities cf processFieldOpeningHours.
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
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99.0),
                        side: BorderSide.none)))),
      ),
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
  TimeOfDay filterStartTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay filterEndTime = const TimeOfDay(hour: 22, minute: 0);

  List<StudySpace> studySpaces = [
    StudySpace(
        title: "Art, Architecture, and Engineering Library",
        openingHours: [const OpeningHours.allDay()],
        pictureUrl: "assets/duderstadt.webp"),
    StudySpace(
        title: "Hatcher Library",
        openingHours: [
          const OpeningHours.range(
              TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 19, minute: 0))
        ],
        pictureUrl: "assets/hatcher.webp"),
    StudySpace(
        title: "Shapiro Library",
        openingHours: [const OpeningHours.allDay()],
        pictureUrl: "assets/shapiro.webp"),
    StudySpace(
        title: "Fine Arts Library",
        openingHours: [
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0))
        ],
        pictureUrl: "assets/fine_arts.webp"),
    StudySpace(
        title: "Asia Library",
        openingHours: [
          const OpeningHours.range(
              TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 19, minute: 0))
        ],
        pictureUrl: "assets/asia.webp"),
    StudySpace(
        title: "Taubman Health Sciences Library",
        openingHours: [
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0))
        ],
        pictureUrl: "assets/taubman.webp"),
    StudySpace(
        title: "Music Library",
        openingHours: [
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0))
        ],
        pictureUrl: "assets/music.webp")
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
          setState(() {
            openingHours = newOpeningHours;
          });
          prefs.setString(
              'openingHoursLastUpdateTime', DateTime.now().toIso8601String());
          prefs.setString('openingHours', jsonEncode(openingHours));
          updateOpeningHoursForNextSevenDays();
        });
      } else {
        if (kDebugMode) {
          print("Loaded opening hours from cache");
        }
        setState(() {
          openingHours =
              (jsonDecode(storedOpeningHours) as Map<String, dynamic>).map(
                  (title, openingHours) => MapEntry(
                      title,
                      (openingHours as List<dynamic>)
                          .map((hours) => OpeningDateAndHours.fromJson(hours))
                          .toList()));
        });
        updateOpeningHoursForNextSevenDays();
      }
    });
  }

  /// Fetch the latest opening hours from M Library API
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

  /// Update the opening hours for the next 7 days of all study spaces
  void updateOpeningHoursForNextSevenDays() {
    List<DateTime> nextSevenDays = [];
    var nextDay = DateTime.now();
    for (var i = 0; i < 7; ++i) {
      nextSevenDays.add(nextDay);
      nextDay = nextDay.add(const Duration(days: 1));
    }
    setState(() {
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
    });
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
      filterResults: () => studySpaces
          .where((space) => isOpenDuring(
              OpeningHours.range(filterStartTime, filterEndTime),
              space.openingHours[0]))
          .toList(),
      keywordSearch: () => queryFilteredStudySpaces,
      filterSearch: () => queryFilteredStudySpaces,
      home: () => queryFilteredStudySpaces,
    );
    return Scaffold(
      appBar: appState.when(
        filterSearch: () => filterResultsAppBar(),
        filterResults: () => filterResultsAppBar(),
        keywordSearch: () => searchAndFilterAppBar(),
        home: () => searchAndFilterAppBar(),
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
    );
  }

  AppBar filterResultsAppBar() => AppBar(
        title: SafeArea(
          child: Row(children: [
            backToHomeIconButton(),
            SizedBox(
                width: Theme.of(context).textTheme.bodyLarge!.fontSize! / 2),
            TextButton(
              style: TextButton.styleFrom(
                shape: const StadiumBorder(),
                padding: EdgeInsets.all(
                    Theme.of(context).textTheme.bodyLarge!.fontSize! / 1.5),
                primary: Colors.white,
                textStyle: Theme.of(context).textTheme.bodyLarge,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: startFiltering,
              child: Text(openingHoursToString(
                  OpeningHours.range(filterStartTime, filterEndTime))),
            )
          ]),
        ),
        backgroundColor: Theme.of(context).canvasColor,
      );

  AppBar filterSearchAppBar() => AppBar(
        toolbarHeight: 10,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      );

  AppBar searchAndFilterAppBar() {
    var textFieldBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: Colors.grey),
      borderRadius: BorderRadius.circular(100),
    );
    var textFieldPadding = Theme.of(context).textTheme.bodyLarge!.fontSize!;
    return AppBar(
      toolbarHeight: 60,
      flexibleSpace: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(
                Theme.of(context).textTheme.bodyLarge!.fontSize!),
            child: Row(children: [
              Visibility(
                  visible: appState != const AppState.keywordSearch(),
                  child: ElevatedButton.icon(
                    // style: Theme.of(context).outlinedButtonTheme.style,
                    onPressed: startFiltering,
                    icon: Icon(MaterialIconsSelected.filter_alt,
                        size: Theme.of(context).textTheme.bodyLarge!.fontSize!),
                    label: const Text('Filter'),
                  )),
              Visibility(
                  visible: appState != const AppState.keywordSearch(),
                  child: SizedBox(
                      width: Theme.of(context).textTheme.bodyLarge!.fontSize!)),
              Expanded(
                  child: TextField(
                focusNode: queryFocusNode,
                onChanged: (String name) {
                  setState(() {
                    appState = const AppState.keywordSearch();
                    queryName = name;
                  });
                },
                onTap: () {
                  setState(() {
                    appState = const AppState.keywordSearch();
                  });
                },
                decoration: InputDecoration(
                  isDense: true,
                  errorBorder: textFieldBorder,
                  focusedBorder: textFieldBorder,
                  focusedErrorBorder: textFieldBorder,
                  disabledBorder: textFieldBorder,
                  enabledBorder: textFieldBorder,
                  border: textFieldBorder,
                  hintText: 'Search by keywords',
                  prefixIcon: appState == const AppState.keywordSearch()
                      ? backToHomeIconButton()
                      : keywordSearchIconButton(),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: textFieldPadding),
                ),
                controller: queryController,
              ))
            ])),
      ),
      backgroundColor: Theme.of(context).canvasColor,
    );
  }

  Widget keywordSearchIconButton() => GestureDetector(
        child: const Icon(MaterialIconsSelected.search),
        onTap: () {
          setState(() {
            appState = const AppState.keywordSearch();
            queryFocusNode.requestFocus();
          });
        },
      );

  Widget backToHomeIconButton() => GestureDetector(
        child: Icon(MaterialIconsSelected.arrow_back_ios_new,
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
    TimeOfDay _startTime = filterStartTime;
    TimeOfDay _endTime = filterEndTime;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                    padding: EdgeInsets.all(
                        Theme.of(context).textTheme.bodyLarge!.fontSize!),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  appState = const AppState.home();
                                });
                              }),
                          TextButton(
                            child: const Text('Confirm'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                filterStartTime = _startTime;
                                filterEndTime = _endTime;
                                appState = const AppState.filterResults();
                              });
                            },
                          ),
                        ])),
                Text("Opening Hours",
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    child: FutureBuilder(
                        future: time_range_picker.loadLibrary(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return time_range_picker.TimeRangePicker(
                                paintingStyle: PaintingStyle.fill,
                                strokeColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5),
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
                                  return time_range_picker.ClockLabel.fromIndex(
                                      idx: e.key, length: 8, text: e.value);
                                }).toList(),
                                labelOffset: 35,
                                rotateLabels: false,
                                padding: 60);
                          } else {
                            return const Text("Loading Time Picker...");
                          }
                        }))
              ]));
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
        padding:
            EdgeInsets.all(Theme.of(context).textTheme.bodyLarge!.fontSize!),
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

  /// Get the [OpeningHours] of a study space with a [queryTitle] at a [queryDate].
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
      return getHoursFromDateAndHours(queryDate, dateAndHours);
    } else {
      return null;
    }
  }

  /// Get [OpeningHours] at a [queryDate] from an [OpeningDateAndHours]
  OpeningHours getHoursFromDateAndHours(
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

  /// Get [FieldOpeningHours] from M Library API for a [spaceType].
  ///
  /// [spaceType] can be either "building" or "location"
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

  @override
  void dispose() {
    queryFocusNode.dispose();
    queryController.dispose();
    super.dispose();
  }
}
