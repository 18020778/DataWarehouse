/*import 'package:first_app/buy_products/map/place_search.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'geometry.dart';

class PlacesService {
  final key = 'AIzaSyDunZ6-AUASpPRlrgbHUnyFGJrvTB5UV1k';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var endpointUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=geocode&key=$key';
    var response = await http.get(Uri.parse(endpointUrl));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(double lat, double lng, String placeType) async {
    var url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}*/