import 'package:attendance/data/models/attendance.dart';
import 'package:attendance/data/models/offices_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _attendanceCollection =
    _firestore.collection('attendance');
final CollectionReference _officeCollection = _firestore.collection('office');

class Database {
  static String? userUid;

  static Future<void> addAttendance({
    required DateTime time,
    required String name,
    required bool isPinLocation,
  }) async {
    DocumentReference documentReferencer = _attendanceCollection.doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "time": time,
      "name": name,
      "is_pin_Location": isPinLocation,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future addMasterLocation(OfficesModel officesModel) async {
    DocumentReference documentReferencer = _officeCollection.doc();
    await documentReferencer
        .set(officesModel.toMap())
        .whenComplete(() => print('Succes Add Location'))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required DateTime time,
    required String name,
    required bool isPinLocation,
  }) async {
    DocumentReference documentReferencer = _attendanceCollection.doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "time": time,
      "name": name,
      "is_pin_Location": isPinLocation,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<List<Attendance>> readItems() {
    return FirebaseFirestore.instance
        .collection('attendance')
        .orderBy('time')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => Attendance.fromJson(e.data())).toList());
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _attendanceCollection.doc(userUid).collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
