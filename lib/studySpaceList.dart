import 'package:flutter/material.dart';
import 'package:mstudy/main.dart';

List<StudySpace> studySpaces = [
  StudySpace(
    title: "Art, Architecture, and Engineering Library",
    openingHours: List.filled(7, const OpeningHours.allDay()),
    pictureUrl: "assets/duderstadt.webp",
    address: "2281 Bonisteel Blvd",
    buildingPosition:
        const BuildingPosition(latitude: 42.291165, longitude: -83.715716),
    phoneNumber: 7346475747,
    connectedToMLibraryApi: true,
    areas: [],
  ),
  StudySpace(
    title: "Hatcher Library",
    openingHours: [
      ...List.filled(
          4,
          const OpeningHours.range(
              TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 19, minute: 0))),
      const OpeningHours.range(
          TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 17, minute: 0)),
      const OpeningHours.range(
          TimeOfDay(hour: 10, minute: 0), TimeOfDay(hour: 18, minute: 0)),
      const OpeningHours.range(
          TimeOfDay(hour: 13, minute: 0), TimeOfDay(hour: 19, minute: 0)),
    ],
    pictureUrl: "assets/hatcher.webp",
    address: "913 S. University Avenue",
    buildingPosition: const BuildingPosition(
        latitude: 42.276334,
        longitude: -83.737981), // Uses Hatcher Library South
    phoneNumber: 7347640401,
    connectedToMLibraryApi: true,
    areas: [
      Area(
        title: "Asia Library",
        floor: "4",
        pictureUrl: "assets/hatcher_asia.webp",
        indoor: true,
      )
    ],
  ),
  StudySpace(
    title: "Shapiro Library",
    openingHours: [
      ...List.filled(4, const OpeningHours.allDay()),
      const OpeningHours.range(
          TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 18, minute: 0)),
      const OpeningHours.range(
          TimeOfDay(hour: 10, minute: 0), TimeOfDay(hour: 18, minute: 0)),
      const OpeningHours.range(
          TimeOfDay(hour: 10, minute: 0), TimeOfDay(hour: 0, minute: 0)),
    ],
    pictureUrl: "assets/shapiro.webp",
    address: "919 S. University Ave",
    buildingPosition:
        const BuildingPosition(latitude: 42.275615, longitude: -83.737183),
    phoneNumber: 7347647490,
    connectedToMLibraryApi: true,
    areas: [],
  ),
  StudySpace(
    title: "Fine Arts Library",
    openingHours: [
      ...List.filled(
          5,
          const OpeningHours.range(
              TimeOfDay(hour: 10, minute: 0), TimeOfDay(hour: 13, minute: 0))),
      const OpeningHours.closed(),
      const OpeningHours.closed(),
    ],
    pictureUrl: "assets/fine_arts.webp",
    address: "855 S. University Ave",
    buildingPosition:
        const BuildingPosition(latitude: 42.274944, longitude: -83.738995),
    phoneNumber: 7347645405,
    connectedToMLibraryApi: true,
    areas: [],
  ),
  StudySpace(
    title: "Taubman Health Sciences Library",
    openingHours: [
      ...List.filled(
          5,
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0))),
      const OpeningHours.closed(),
      const OpeningHours.closed(),
    ],
    pictureUrl: "assets/taubman.webp",
    address: "1135 Catherine St",
    buildingPosition:
        const BuildingPosition(latitude: 42.283548, longitude: -83.734451),
    phoneNumber: 7347641210,
    connectedToMLibraryApi: true,
    areas: [],
  ),
  StudySpace(
    title: "Music Library",
    openingHours: [
      ...List.filled(
          5,
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0))),
      const OpeningHours.closed(),
      const OpeningHours.closed(),
    ],
    pictureUrl: "assets/music.webp",
    address: "1100 Baits Dr",
    buildingPosition:
        const BuildingPosition(latitude: 42.290373, longitude: -83.721006),
    phoneNumber: 7347642512,
    connectedToMLibraryApi: true,
    areas: [],
  ),
  StudySpace(
    title: "East Quad",
    openingHours: [
      ...List.filled(
          5,
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 21, minute: 30))),
      const OpeningHours.range(
          TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 20, minute: 0)),
      const OpeningHours.range(
          TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 20, minute: 0)),
    ],
    pictureUrl: "assets/east_quad.webp",
    address: "701 E. University",
    buildingPosition: const BuildingPosition(
        latitude: 42.272745760362035, longitude: -83.73550729385826),
    phoneNumber: 7347633164,
    connectedToMLibraryApi: false,
    areas: [
      Area(
        title: "Blue Cafe",
        floor: "Main",
        indoor: true,
        pictureUrl: 'assets/east_quad_blue_cafe.webp',
      ),
      Area(
        title: "Open Space",
        floor: "Lower Level",
        indoor: true,
        pictureUrl: 'assets/east_quad_open_space.webp',
      ),
      Area(
        title: "Study Rooms",
        floor: "Lower Level",
        indoor: true,
        pictureUrl: 'assets/image_coming_soon.webp',
      ),
    ],
  )
];
