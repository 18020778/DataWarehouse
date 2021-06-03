import 'dart:ffi';

import 'package:first_app/buy_products/wemap/place/WeMapDirections.dart';
import 'package:first_app/buy_products/wemap/place/place_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'wemap/camera.dart';
import 'wemap/controller.dart';
import 'wemap/location.dart';
import 'wemap/place/place.dart';
import 'wemap/search/search_bar.dart';
import 'wemap/wemap_map.dart';

class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {

  WeMapController mapController;
  int searchType = 1; //Type of search bar
  String searchInfoPlace = "Tìm kiếm ở đây"; //Hint text for InfoBar
  String searchPlaceName;
  LatLng myLatLng = LatLng(21.038282, 105.782885);
  bool reverse = true;
  WeMapPlace place;

  void _onMapCreated(WeMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
            children: <Widget>[
              WeMap(
                onMapClick: (point, LatLng, _place) async {
                  place = await _place;
                },
                onPlaceCardClose: () {
                  // print("Place Card closed");
                },
                reverse: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(21.036029, 105.782950),
                  zoom: 16.0,
                ),
                destinationIcon: "assets/symbols/destination.png",
              ),
              Row(
                children: [
                  BackButton(
                    color: Color(4281755726),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    width: 300,
                    child:
    WeMapSearchBar(
    location: myLatLng,
    onSelected: (_place) async {
    setState(() {
    place = _place;
    });
    if (myLatLng != null) {
    await mapController.animateCamera(
    CameraUpdate.newLatLngZoom(
    place.location,
    18.0,
    ),
    );
    mapController.clearSymbols();
    mapController.clearCircles();
    await WeMapDirections()
        .addCircle(place.location, mapController, '#ff1a05');
    }

    mapController.showPlaceCard(place);
    },
                      onClearInput: () {
                        setState(() {
                          place = null;
                          mapController.showPlaceCard?.call(place);
                        });
                      },
                    ),
                  )],
              ),
              // ignore: deprecated_member_use
              Positioned(
                  left: MediaQuery.of(context).size.width/2 - 200,
                  top: MediaQuery.of(context).size.height - 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    minWidth: 400,
                    height: 50,
                    onPressed: (){
                     Navigator.pop(context, place.description.toString());
                    },
                    color: Color(4281755726),
                    child: Text("ĐỒNG Ý", style: TextStyle(color: Colors.white, fontSize: 22),),
                  ))

            ]));
  }
}
