import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

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
  String queryName = "";
  bool isSearching = false;
  final queryController = TextEditingController();

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
    StudySpace(
        name: "Asian Library",
        hoursStart: 8,
        hoursEnd: 17,
        pictureUrl:
            "https://www.lib.umich.edu/static/50a94f6a1ea2e98354f34892825c57d0/fddf6/AsiaLibrary.jpg"),
    StudySpace(
        name: "Taubman Health Sciences Library",
        hoursStart: 9,
        hoursEnd: 17,
        pictureUrl:
            "https://www.lib.umich.edu/static/ba2f579811238c27e92075de164c5c65/fddf6/taubman-3-june2019_edited.jpg"),
    StudySpace(
        name: "Askwith Media Library",
        hoursStart: 9,
        hoursEnd: 18,
        pictureUrl:
            "https://www.lib.umich.edu/static/f38a16cbb3e878b965464909b31067b8/fddf6/Shapiro-Askwith3-Feb2020_edited.jpg"),
    StudySpace(
        name: "Music Library",
        hoursStart: 9,
        hoursEnd: 17,
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
      appBar: AppBar(
        title: TextField(
          onChanged: (String name) {
            setState(() {
              isSearching = true;
              queryName = name;
            });
          },
          onTap: () {
            setState(() {
              isSearching = true;
            });
          },
          decoration: InputDecoration(
              focusedBorder: isSearching
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0),
                    )
                  : InputBorder.none,
              hintText: 'Where are you studying?',
              prefixIcon: isSearching
                  ? GestureDetector(
                      child: const Icon(Icons.arrow_back_ios_new),
                      onTap: () {
                        setState(() {
                          isSearching = false;
                          queryName = "";
                          queryController.clear();
                        });
                      },
                    )
                  : GestureDetector(
                      child: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          isSearching = true;
                        });
                      },
                    )),
          controller: queryController,
        ),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: filteredStudySpaces.length,
        itemBuilder: (BuildContext context, int index) {
          return showListItem(filteredStudySpaces[index]);
        },
        // itemExtent: 100,
      ),
    );
  }

  Widget showListItem(StudySpace studySpace) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(
          child: ListTile(
        trailing: AspectRatio(
            aspectRatio: 1,
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(studySpace.pictureUrl))))),
        title: Text(studySpace.name),
        subtitle: Text(hourToString(studySpace.hoursStart) +
            " - " +
            hourToString(studySpace.hoursEnd)),
      )),
    ]));
  }

  String hourToString(int hour) {
    if (hour > 12) {
      return (hour - 12).toString() + "PM";
    } else {
      return hour.toString() + "AM";
    }
  }
}
