/*import 'package:first_app/buy_products/map/location.dart';

class Geometry {
  final Location location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Geometry(
      location: Location.fromJson(parsedJson['location'])
    );
  }
}

class Place {
  final Geometry geometry;
  final String name;
  final String vicinity;

  Place({this.geometry, this.name, this.vicinity});

  factory Place.fromJson(Map<String, dynamic> parsedJson) {
    return Place(
      geometry: Geometry.fromJson(parsedJson['geometry']),
      name: parsedJson['formatted_address'],
      vicinity: parsedJson['vicinity']
    );
  }
}*/