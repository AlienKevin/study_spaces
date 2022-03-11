import 'package:flutter/material.dart';

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
      ),
      home: MyHomePage(title: 'Opening Now'),
    );
  }
}

class StudySpace {
  final String name;
  final int hoursStart;
  final int hoursEnd;
  final String pictureUrl;

  StudySpace(
      {required this.name,
      required this.hoursStart,
      required this.hoursEnd,
      required this.pictureUrl});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<StudySpace> studySpaces = [
    StudySpace(
        name: "Art, Architecture, and Engineering Library",
        hoursStart: 9,
        hoursEnd: 22,
        pictureUrl:
            "https://www.lib.umich.edu/static/542b6db6cb4cb1f683c44314617cebf8/fddf6/duderstadt2-june2019_edited.jpg"),
    StudySpace(
        name: "Hatcher Library",
        hoursStart: 10,
        hoursEnd: 21,
        pictureUrl:
            "https://www.lib.umich.edu/static/db8149c1851a919702b5eeda601def8e/fddf6/hatcher-5-june2019_edited.jpg"),
    StudySpace(
        name: "Shapiro Library",
        hoursStart: 9,
        hoursEnd: 20,
        pictureUrl:
            "https://www.lib.umich.edu/static/a702abfd347b4a1f3591d9f4ad572594/f9008/shapiro-4-june2019_edited.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          showFeaturedListItem(studySpaces[0]),
          ...studySpaces.sublist(1).map(showListItem).toList(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showFilters,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void showFilters() {}

  Widget showListItem(StudySpace studySpace) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        title: Text(studySpace.name),
        subtitle: Text(studySpace.hoursStart.toString() +
            "-" +
            studySpace.hoursEnd.toString()),
      ),
    ]));
  }

  Widget showFeaturedListItem(StudySpace studySpace) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Image.network(studySpace.pictureUrl),
          ListTile(
            title: Text(studySpace.name),
            subtitle: Text(studySpace.hoursStart.toString() +
                "-" +
                studySpace.hoursEnd.toString()),
          ),
        ]),
        margin: const EdgeInsets.all(10));
  }
}
