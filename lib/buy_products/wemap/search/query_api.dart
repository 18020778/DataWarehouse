
import 'package:first_app/buy_products/wemap/place/place.dart';
import 'package:first_app/buy_products/wemap/plugin.dart';
import 'package:http/http.dart' as http;
import '../location.dart';
import 'dart:convert' as JSON;

class WeMapSearchAPI {
  const WeMapSearchAPI();

  Future<List<WeMapPlace>> getSearchResult(
      String input, LatLng latLng, WeMapGeocoder geocoder) async {
    List<WeMapPlace> places = [];
    try {
      final response = await http.get(Uri.parse(apiSearch(input, latLng, geocoder)));
      final json = JSON.jsonDecode(response.body);
      List results = json["features"];
      switch (geocoder) {
        case WeMapGeocoder.Photon:
        // print("Search query api Geocoder.Photon: ${apiSearch(input, latLng, geocoder)}");
          results.forEach((prediction) {
            places.add(WeMapPlace.fromPhoton(prediction));
          });
          break;
        case WeMapGeocoder.Nominatim:
        // print("Search query api Geocoder.Nominatim: ${apiSearch(input, latLng, geocoder)}");
          results.forEach((prediction) {
            places.add(WeMapPlace.fromNominatim(prediction));
          });
          break;
        default:
        // print("Search query api Geocoder.Pelias: ${apiSearch(input, latLng, geocoder)}");
          results.forEach((prediction) {
            places.add(WeMapPlace.fromPelias(prediction));
          });
          break;
      }
    } catch (e) {
      print('Error getSearchResult() => $e');
    }
    return places;
  }
}
