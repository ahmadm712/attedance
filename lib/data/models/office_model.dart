class Office {
  double latitude;
  double longitude;
  String name;
  String address;

  Office({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.address,
  });

  String get getName {
    return name;
  }

  String get getAddress {
    return address;
  }

  double get getLatitude {
    return latitude;
  }

  double get getLongitude {
    return longitude;
  }

  factory Office.fromJson(String key, Map<String, dynamic> parsedJson) {
    return Office(
      name: parsedJson['name'],
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
      address: parsedJson['address'],
    );
  }
}
