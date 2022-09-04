// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class OfficesModel {
  GeoPoint? location;
  String name;
  String? addres;
  String id;
  OfficesModel({
    this.location,
    required this.name,
    this.addres,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'location': location,
      'name': name,
      'addres': addres,
    };
  }

  factory OfficesModel.fromJson(Map<String, dynamic> json) {
    return OfficesModel(
      id: json['id'],
      location: json['location'] ?? "",
      name: json['name'] ?? "",
      addres: json['addres'] ?? "",
    );
  }

  factory OfficesModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return OfficesModel(
      id: doc['id'],
      location: doc.data()!['location'],
      addres: doc.data()!['addres'],
      name: doc.data()!['name'],
    );
  }
}
