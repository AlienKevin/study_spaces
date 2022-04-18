import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:mstudy/buildingList.dart' as building_list;
import 'package:mstudy/buildingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:time_range_picker/time_range_picker.dart'
    deferred as time_range_picker;

import 'MaterialIconsSelected.dart';
import 'utils.dart';

part 'main.freezed.dart';
part 'main.g.dart';

/// Opening hours of a building
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
/// are the only way to find and match opening hours to buildings.
/// Each [HoursType] of a building has a unique [id].
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

/// Title of buildings
typedef SpaceTitle = String;

/// Unprocessed [OpeningDateAndHours] for each building, organized by [HoursType]
typedef FieldOpeningHours
    = Map<HoursType, Map<SpaceTitle, List<OpeningDateAndHours>>>;

/// Processed [OpeningDateAndHours] for each building, listed in decreasing priorities.
/// Priorities cf processFieldOpeningHours.
typedef ProcessedOpeningHours = Map<SpaceTitle, List<OpeningDateAndHours>>;

void main() {
  runApp(const MyApp());
}

const maizeColor = Color(0xFFFFCB05);
const blueColor = Color(0xFF00274C);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Map<int, Color> maizeColorMap = {
      50: maizeColor,
      100: maizeColor,
      200: maizeColor,
      300: maizeColor,
      400: maizeColor,
      500: maizeColor,
      600: maizeColor,
      700: maizeColor,
      800: maizeColor,
      900: maizeColor,
    };
    final Map<int, Color> blueColorMap = {
      50: blueColor,
      100: blueColor,
      200: blueColor,
      300: blueColor,
      400: blueColor,
      500: blueColor,
      600: blueColor,
      700: blueColor,
      800: blueColor,
      900: blueColor,
    };
    final maizeSwatch = MaterialColor(maizeColor.value, maizeColorMap);
    final blueSwatch = MaterialColor(blueColor.value, blueColorMap);
    final theme = ThemeData(
        textTheme:
            GoogleFonts.robotoTextTheme(Theme.of(context).textTheme.apply(
                  bodyColor: blueSwatch,
                  displayColor: blueSwatch,
                  decorationColor: blueSwatch,
                )),
        primarySwatch: maizeSwatch,
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          iconColor: blueColor,
          prefixIconColor: blueColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith((_) => blueColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99.0),
                        side: BorderSide.none)))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith((_) => blueColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99.0))),
                side: MaterialStateProperty.all(
                    const BorderSide(color: blueColor, width: 2.0)))),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((_) => blueColor),
        )));
    return MaterialApp(
      title: 'Buildings',
      theme: theme,
      home: const MyHomePage(title: 'Opening Now'),
    );
  }
}

class BuildingPosition {
  final double latitude;
  final double longitude;

  const BuildingPosition({
    required this.latitude,
    required this.longitude,
  });
}

typedef Id = String;

class Area {
  final String title;
  final Id id;
  final String floor;
  final bool indoor;
  final bool hasImage;

  Area({
    required this.title,
    required this.floor,
    required this.indoor,
    required this.id,
    this.hasImage = true,
  });
}

Id getAreaId(Id buildingId, Id areaId) => "${buildingId}_$areaId";

class Building {
  final String title;
  final String id;
  List<OpeningHours>
      openingHours; // From Monday (list index 0) to Sunday (list index 6)
  final BuildingPosition buildingPosition;
  final String address;
  final String phoneNumber;
  final bool connectedToMLibraryApi;
  final List<Area> areas;

  Building({
    required this.title,
    required this.id,
    required this.openingHours,
    required this.buildingPosition,
    required this.address,
    required this.phoneNumber,
    required this.connectedToMLibraryApi,
    required this.areas,
  });
}

String getImageUrl({
  required Id id,
  hasImage = true,
}) =>
    hasImage ? "assets/$id.webp" : "assets/image_coming_soon.webp";

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
  List<Building> buildings = building_list.buildings;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      getCurrentPosition().then((position) {
        print("Current position is $position");
        for (var space in buildings) {
          var distance = Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              space.buildingPosition.latitude,
              space.buildingPosition.longitude);
          print(
              "Distance from current position to ${space.title} is ${distance}m.");
        }
      });
    }
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

  /// Update the opening hours for the next 7 days of all buildings
  /// connected to the M library API
  void updateOpeningHoursForNextSevenDays() {
    List<DateTime> nextSevenDays = [];
    var nextDay = DateTime.now();
    for (var i = 0; i < 7; ++i) {
      nextSevenDays.add(nextDay);
      nextDay = nextDay.add(const Duration(days: 1));
    }
    setState(() {
      buildings.where((space) => space.connectedToMLibraryApi).forEach((space) {
        for (var day in nextSevenDays) {
          var newOpeningHours = getOpeningHours(space.title, day);
          if (kDebugMode) {
            print(
                "opening hours for ${space.title} on ${day.year}-${day.month}-${day.day} is $newOpeningHours.");
          }
          space.openingHours[day.weekday - 1] = newOpeningHours!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var wordBoundary = RegExp(r'\W');
    var queryFilteredBuildings = queryName.isNotEmpty
        ? buildings
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
        : buildings;
    final openingHoursIndex = getOpeningHoursIndex();
    var filteredBuildings = appState
        .when(
          filterResults: () => buildings
              .where((space) => isOpenDuring(
                  OpeningHours.range(filterStartTime, filterEndTime),
                  space.openingHours[openingHoursIndex]))
              .toList(),
          keywordSearch: () => queryFilteredBuildings,
          filterSearch: () => queryFilteredBuildings,
          home: () => queryFilteredBuildings,
        )
        .sorted((space1, space2) => space1.openingHours[openingHoursIndex].when(
              allDay: () => space2.openingHours[openingHoursIndex].when(
                  allDay: () => 0,
                  range: (_start, _end) => -1,
                  closed: () => -1),
              range: (TimeOfDay space1Start, TimeOfDay space1End) =>
                  space2.openingHours[openingHoursIndex].when(
                      allDay: () => 1,
                      range: (space2Start, space2End) =>
                          timeOfDayLessThanEqual(space2End, space1End)
                              ? -1
                              : (space2End == space1End ? 0 : 1),
                      closed: () => -1),
              closed: () => space2.openingHours[openingHoursIndex].when(
                  allDay: () => 1, range: (_start, _end) => 1, closed: () => 0),
            ));
    return Scaffold(
      appBar: appState.when(
        filterSearch: () => filterResultsAppBar(),
        filterResults: () => filterResultsAppBar(),
        keywordSearch: () => searchAndFilterAppBar(),
        home: () => searchAndFilterAppBar(),
      ),
      body: LayoutBuilder(
          builder: (context, constraints) => constraints.maxWidth <= 500
              ? showNarrowList(filteredBuildings)
              : showWideList(filteredBuildings, constraints.maxWidth)),
    );
  }

  Widget showNarrowList(List<Building> filteredBuildings) => ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: filteredBuildings.length,
        itemBuilder: (BuildContext context, int index) {
          return showNarrowListItem(filteredBuildings[index]);
        },
        separatorBuilder: (context, index) => SizedBox(
          height: Theme.of(context).textTheme.bodySmall!.fontSize! / 2,
        ),
        // itemExtent: 100,
      );

  Widget showWideList(List<Building> filteredBuildings, double maxWidth) =>
      Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: GridView.count(
            childAspectRatio: 1.05,
            padding: const EdgeInsets.all(8),
            children: filteredBuildings.map(showWideListItem).toList(),
            crossAxisSpacing:
                Theme.of(context).textTheme.bodySmall!.fontSize! / 2,
            crossAxisCount: maxWidth > 800 ? 3 : 2,
          ),
        ),
      );

  AppBar filterResultsAppBar() => AppBar(
        toolbarHeight: 60,
        flexibleSpace: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(
                  Theme.of(context).textTheme.bodyLarge!.fontSize!),
              child: Row(children: [
                backToHomeIconButton(),
                SizedBox(
                    width:
                        Theme.of(context).textTheme.bodyLarge!.fontSize! / 2),
                ElevatedButton(
                  onPressed: startFiltering,
                  child: Text(openingHoursToString(
                      OpeningHours.range(filterStartTime, filterEndTime))),
                )
              ])),
        ),
        backgroundColor: Theme.of(context).canvasColor,
      );

  AppBar searchAndFilterAppBar() {
    var textFieldBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: blueColor),
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
                cursorColor: blueColor,
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
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
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
        child: const Icon(MaterialIconsSelected.arrow_back_ios_new),
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
                                timeTextStyle:
                                    Theme.of(context).textTheme.titleLarge,
                                activeTimeTextStyle:
                                    Theme.of(context).textTheme.titleLarge,
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

  Widget showNarrowListItem(Building building) {
    var openingHoursIndex = getOpeningHoursIndex();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BuildingPage(building: building),
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
                building.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                  height: Theme.of(context).textTheme.bodySmall!.fontSize! / 2),
              Text(
                  openingHoursToString(
                      building.openingHours[openingHoursIndex]),
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
                              image:
                                  AssetImage(getImageUrl(id: building.id))))))),
        ]),
      )),
    );
  }

  Widget showWideListItem(Building building) {
    var openingHoursIndex = getOpeningHoursIndex();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BuildingPage(building: building),
            ));
      },
      child: Card(
        child: Padding(
          padding:
              EdgeInsets.all(Theme.of(context).textTheme.bodyLarge!.fontSize!),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  building.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                    height:
                        Theme.of(context).textTheme.bodySmall!.fontSize! / 2),
                Text(
                    openingHoursToString(
                        building.openingHours[openingHoursIndex]),
                    style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) =>
                            AspectRatio(
                                aspectRatio: 1.5,
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(
                                    getImageUrl(id: building.id),
                                  ),
                                ))))),
              ]),
        ),
      ),
    );
  }

  /// Get the [OpeningHours] of a building with a [queryTitle] at a [queryDate].
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
    buildings.where((space) => space.connectedToMLibraryApi).forEach((space) {
      for (var hours in prioritizedHours) {
        if (hours[space.title] != null) {
          result.putIfAbsent(space.title, () => []).addAll(hours[space.title]!);
        }
      }
    });
    return result;
  }

  /// Get [FieldOpeningHours] from M Library API for a [spaceType].
  ///
  /// [spaceType] can be either "building" or "location"
  Future<FieldOpeningHours> getFieldOpeningHours(String spaceType) async {
    var baseUri = 'https://cms.lib.umich.edu/jsonapi/node/$spaceType/';

    final uriDesign = StandardUriDesign(Uri.parse(baseUri));

    final client = RoutingClient(uriDesign);

    // A Map from fieldHoursOpen.type (eg paragraph__hours_exceptions) to a Map from building title to its opening hours
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
        if (buildings
            .where((space) => space.connectedToMLibraryApi)
            .map((space) => space.title)
            .contains(title)) {
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

/// Weekday values start on Monday as 1 all the way to Sunday as 7
/// We need to subtract 1 from all weekday values to get 0-based list index
int getOpeningHoursIndex() => DateTime.now().weekday - 1;

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> getCurrentPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
