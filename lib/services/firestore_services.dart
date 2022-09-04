import 'dart:developer';

import 'package:attendance/data/models/attendance.dart';
import 'package:attendance/data/models/offices_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference<Map<String, dynamic>> _attendanceCollection =
    _firestore.collection('attendance');
final CollectionReference<Map<String, dynamic>> _officeCollection =
    _firestore.collection('office');

class FirebaseServices {
  Future<bool> addAttendance({required Attendance attendance}) async {
    DocumentReference documentReferencer = _attendanceCollection.doc();
    bool isSucces = false;
    await documentReferencer
        .set(attendance.toMap())
        .whenComplete(() => isSucces = true)
        .catchError(
      (e) {
        isSucces = false;
        print(e);
      },
    );

    return isSucces;
  }

  Future addMasterLocation(OfficesModel officesModel) async {
    DocumentReference documentReferencer = _officeCollection.doc('01');
    return await documentReferencer
        .set(officesModel.toMap())
        .whenComplete(() => print('Succes Add Location'))
        .catchError((e) => print(e));
  }

  Future<OfficesModel> readMasterLocation() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _officeCollection.where('01').get();

    final data =
        snapshot.docs.map((e) => OfficesModel.fromDocumentSnapshot(e)).first;

    return data;
  }

  Future<List<Attendance>> readListAttendance() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _attendanceCollection.get();

    final data =
        snapshot.docs.map((e) => Attendance.fromDocumentSnapshot(e)).toList();
    log(data.toString());
    return data;
  }
}
