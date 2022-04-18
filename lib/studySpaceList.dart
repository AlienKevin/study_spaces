import 'package:flutter/material.dart';
import 'package:mstudy/main.dart';

List<StudySpace> studySpaces = [
  StudySpace(
    title: "Art, Architecture, and Engineering Library",
    id: "duderstadt",
    openingHours: List.filled(7, const OpeningHours.allDay()),
    address: "2281 Bonisteel Blvd",
    buildingPosition:
        const BuildingPosition(latitude: 42.291165, longitude: -83.715716),
    phoneNumber: "734-647-5747",
    connectedToMLibraryApi: true,
    areas: [],
  ),
  StudySpace(
    title: "Hatcher Library",
    id: "hatcher",
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
    address: "913 S. University Avenue",
    buildingPosition: const BuildingPosition(
        latitude: 42.276334,
        longitude: -83.737981), // Uses Hatcher Library South
    phoneNumber: "734-764-0401",
    connectedToMLibraryApi: true,
    areas: [
      Area(
        title: "Asia Library",
        id: "asia",
        floor: "4",
        indoor: true,
      )
    ],
  ),
  StudySpace(
    title: "Shapiro Library",
    id: "shapiro",
    openingHours: [
      ...List.filled(4, const OpeningHours.allDay()),
      const OpeningHours.range(
          TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 18, minute: 0)),
      const OpeningHours.range(
          TimeOfDay(hour: 10, minute: 0), TimeOfDay(hour: 18, minute: 0)),
      const OpeningHours.range(
          TimeOfDay(hour: 10, minute: 0), TimeOfDay(hour: 0, minute: 0)),
    ],
    address: "919 S. University Ave",
    buildingPosition:
        const BuildingPosition(latitude: 42.275615, longitude: -83.737183),
    phoneNumber: "734-764-7490",
    connectedToMLibraryApi: true,
    areas: [],
  ),
  StudySpace(
    title: "Fine Arts Library",
    id: "fine_arts",
    openingHours: [
      ...List.filled(
          5,
          const OpeningHours.range(
              TimeOfDay(hour: 10, minute: 0), TimeOfDay(hour: 13, minute: 0))),
      const OpeningHours.closed(),
      const OpeningHours.closed(),
    ],
    address: "855 S. University Ave",
    buildingPosition:
        const BuildingPosition(latitude: 42.274944, longitude: -83.738995),
    phoneNumber: "734-764-5405",
    connectedToMLibraryApi: true,
    areas: [],
  ),
  StudySpace(
    title: "Taubman Health Sciences Library",
    id: "taubman",
    openingHours: [
      ...List.filled(
          5,
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0))),
      const OpeningHours.closed(),
      const OpeningHours.closed(),
    ],
    address: "1135 Catherine St",
    buildingPosition:
        const BuildingPosition(latitude: 42.283548, longitude: -83.734451),
    phoneNumber: "734-764-1210",
    connectedToMLibraryApi: true,
    areas: [],
  ),
  StudySpace(
    title: "Music Library",
    id: "music",
    openingHours: [
      ...List.filled(
          5,
          const OpeningHours.range(
              TimeOfDay(hour: 9, minute: 0), TimeOfDay(hour: 17, minute: 0))),
      const OpeningHours.closed(),
      const OpeningHours.closed(),
    ],
    address: "1100 Baits Dr",
    buildingPosition:
        const BuildingPosition(latitude: 42.290373, longitude: -83.721006),
    phoneNumber: "734-764-2512",
    connectedToMLibraryApi: true,
    areas: [],
  ),
  StudySpace(
    title: "East Quad",
    id: "east_quad",
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
    address: "701 E. University",
    buildingPosition: const BuildingPosition(
        latitude: 42.272745760362035, longitude: -83.73550729385826),
    phoneNumber: "734-763-3164",
    connectedToMLibraryApi: false,
    areas: [
      Area(
        title: "Blue Cafe",
        id: "blue_cafe",
        floor: "Main",
        indoor: true,
      ),
      Area(
        title: "Open Space",
        id: "open_space",
        floor: "Lower Level",
        indoor: true,
      ),
      Area(
        title: "Study Rooms",
        id: "study_rooms",
        floor: "Lower Level",
        indoor: true,
        hasImage: false,
      ),
    ],
  )
];
