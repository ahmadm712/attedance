// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class OfficesModel {
  GeoPoint location;
  String name;
  String addres;
  OfficesModel({
    required this.location,
    required this.name,
    required this.addres,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'name': name,
      'addres': addres,
    };
  }

  factory OfficesModel.fromJson(Map<String, dynamic> json) {
    return OfficesModel(
      location: json['location'] ?? "",
      name: json['name'] ?? "",
      addres: json['addres'] ?? "",
    );
  }
}
