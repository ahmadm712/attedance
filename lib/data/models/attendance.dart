// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:attendance/utils/global_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  String idUser;
  DateTime createdTime;
  GeoPoint? geoPoint;
  bool isWFO;

  Attendance(
      {this.idUser = '',
      required this.createdTime,
      this.geoPoint,
      this.isWFO = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUser': idUser,
      'createdTime': GlobalFunctions.convertToJson(createdTime),
      'geoPoint': geoPoint,
      'isWfo': isWFO,
    };
  }

  factory Attendance.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Attendance(
      idUser: doc.data()!['idUser'],
      createdTime: GlobalFunctions.convertFromJson(doc.data()!['createdTime']),
      geoPoint: doc.data()!['geoPoint'],
      isWFO: doc.data()!['isWfo'],
    );
  }
}
