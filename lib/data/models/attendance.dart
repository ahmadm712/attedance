import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  DateTime time;
  String name;
  bool isPinLocation;

  Attendance(
      {required this.time, required this.isPinLocation, required this.name});

  Map<String, dynamic> toJSon() =>
      {'time': time, 'name': name, 'is_pin_location': isPinLocation};

  factory Attendance.fromJson(Map<String, dynamic> parsedJson) {
    return Attendance(
      isPinLocation: parsedJson['is_pin_Location'],
      name: parsedJson['name'],
      time: (parsedJson['time'] as Timestamp).toDate(),
    );
  }
}
