/*import 'dart:async';

import 'package:first_app/buy_products/map/place_search.dart';
import 'package:first_app/buy_products/map/place_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:first_app/buy_products/map/markerService.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'geometry.dart';
import 'location.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placeService = PlacesService();
  final markerService = MarkerService();

  Position currentLocation;
  List<PlaceSearch> searchResults;
  StreamController<Place> seletedLocation = StreamController<Place>();
  Place selectedLocationStatic;
  String placeType;
  List<Place> placeResults;
  List<Marker> markers = List<Marker>();
  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    selectedLocationStatic = Place(
        name: null,
        geometry: Geometry(
            location: Location(
                lat: currentLocation.latitude,
                lng: currentLocation.longitude)));
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placeService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placeService.getPlace(placeId);
    seletedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }

  clearSelectedLocation() {
    seletedLocation.add(null);
    selectedLocationStatic = null;
    searchResults = null;
    placeType = null;
    notifyListeners();
  }

  togglePlaceType(String value, bool selected) {
    if (selected) {
      placeType = value;
    } else {
      placeType = null;
    }

    if (placeType != null) {
      var places = placeService.getPlaces(
          selectedLocationStatic.geometry.location.lat,
          selectedLocationStatic.geometry.location.lng,
          placeType);
      var newMarker = markerService.createMarkerFromPlace((places as Map)[0], false);
      markers.add(newMarker);
    }

    var locationMarker =
    markerService.createMarkerFromPlace(selectedLocationStatic, true);
    markers.add(locationMarker);

    var _bounds = markerService.bounds(Set<Marker>.of(markers));
    bounds.add(_bounds);

    notifyListeners();
  }


  @override
  void dispose() {
    seletedLocation.close();
    super.dispose();
  }
}

class Zoommap {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}*/
