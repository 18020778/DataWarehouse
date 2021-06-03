/*import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_marker_icon/custom_marker_icon.dart';

import 'geometry.dart';

class MarkerService {

  LatLngBounds bounds(Set<Marker> markers) {
    if (markers == null || markers.isEmpty) return null;
    return createBounds(markers.map((m) => m.position).toList());
  }

  LatLngBounds createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce((value, element) => value < element ? value : element); // smallest
    final southwestLon = positions.map((p) => p.longitude).reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce((value, element) => value > element ? value : element); // biggest
    final northeastLon = positions.map((p) => p.longitude).reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon)
    );
  }

  Marker createMarkerFromPlace(Place place, bool center) {
    /*BitmapDescriptor markerIcon = BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),
        "assets/mapMarker.png"
    ) as BitmapDescriptor;*/
    var markerId = place.name;
    if (center) markerId = 'center';

    return Marker(
        markerId: MarkerId(markerId),
        draggable: false,
        visible: (center) ? false : true,
        infoWindow: InfoWindow(
            title: place.name),
        position: LatLng(place.geometry.location.lat,
            place.geometry.location.lng),
      icon: BitmapDescriptor.defaultMarker,

    );
  }
}

class GeolocatorService {

  Future<Position> getCurrentLocation() async {
    return  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}*/