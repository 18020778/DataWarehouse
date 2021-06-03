

import 'dart:convert';

import 'package:first_app/buy_products/wemap/place/place.dart';
import 'package:first_app/buy_products/wemap/plugin.dart';
import 'package:first_app/buy_products/wemap/place/query_api_place.dart';
import 'package:first_app/buy_products/wemap/wemap_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'controller.dart';
import 'base64_items.dart';
import 'camera.dart';
import 'language_vi.dart';
import 'location.dart';

class ChooseOnMap extends StatefulWidget {
  final Function onChooseMap;
  LatLng searchLocation;
  String iconImage;
  ChooseOnMap({this.onChooseMap, this.searchLocation, this.iconImage});

  @override
  ChooseOnMapState createState() => ChooseOnMapState();
}

class ChooseOnMapState extends State<ChooseOnMap> with TickerProviderStateMixin {
  WeMapController mapController;
  WeMap map;
  WeMapPlace place;
  LatLng latLng;
  var logo;

  Future<void> _onMapCreated(WeMapController controller) async {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    logo = base64.decode(wemap_chooseonmap_marker);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            icon: BackButtonIcon(),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: new Text(wemap_chooseOnMap,
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w300)),
          elevation: 0.0,
          actions: <Widget>[
            MaterialButton(
              onPressed: () async {
                latLng = mapController.cameraPosition.target;
                place = await getPlace(latLng);
                await widget.onChooseMap(place);
                Navigator.of(context).pop();
              },
              child: Text(
                chooseText,
                style: TextStyle(color: primaryColor),
              ),
            )
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints.expand(),
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              map = WeMap(
                initialCameraPosition: CameraPosition(target: widget.searchLocation != null ? widget.searchLocation : LatLng(21.03, 105.787), zoom: 15.0),
                onMapCreated: _onMapCreated,
                trackCameraPosition: true,
              ),
              Container(
                alignment: Alignment.center,
//                child: Image.asset(widget.iconImage),
                child: Image.memory(logo, width: 40, height: 40,),
              )
            ],
          ),
        )
    );
  }
}