import 'dart:math';

import 'package:first_app/buy_products/wemap/place/place.dart';
import 'package:first_app/buy_products/wemap/search/search.dart';
import 'package:first_app/buy_products/wemap/search/stream.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../camera.dart';
import '../circle.dart';
import '../controller.dart';
import '../language_vi.dart';
import '../location.dart';
import '../symbol.dart';
import '../wemap_map.dart';

WeMapStream<bool> visibleStream = WeMapStream<bool>();
WeMapStream<int> timeStream = WeMapStream<int>();
WeMapStream<int> distanceStream = WeMapStream<int>();
WeMapStream<int> indexStream = WeMapStream<int>();
WeMapStream<List<LatLng>> routeStream = WeMapStream<List<LatLng>>();
WeMapStream<List<LatLng>> routePreviewStream = WeMapStream<List<LatLng>>();
WeMapStream<WeMapPlace> originPlaceStream = WeMapStream<WeMapPlace>();
WeMapStream<WeMapPlace> destinationPlaceStream = WeMapStream<WeMapPlace>();
WeMapStream<bool> isDrivingStream = WeMapStream<bool>();
WeMapStream<bool> fromHomeStream = WeMapStream<bool>();
int time = 0;
int _tripDistance = 0;

class WeMapDirections {
  Future<void> loadRoute(WeMapController mapController,
      List<LatLng> _route,
      List<LatLng> rootPreview,
      bool visible,
      int indexOfTab,
      String from,
      String to) async {
    await mapController.addCircle(CircleOptions(
        geometry: _route[0],
        circleRadius: 8.0,
        circleColor: '#d3d3d3',
        circleStrokeWidth: 2,
        circleStrokeColor: '#0071bc'));
    await mapController.addCircle(CircleOptions(
        geometry: _route[_route.length - 1],
        circleRadius: 8.0,
        circleColor: '#ffffff',
        circleStrokeWidth: 2,
        circleStrokeColor: '#0071bc'));
  }

  Future<void> animatedCamera(WeMapController mapController,
      LatLngBounds bounds) async {
    await mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
      ),
    );
  }

  Future<void> addMarker(LatLng latLng, WeMapController mapController,
      String iconImage) async {
    await mapController.addSymbol(SymbolOptions(
      geometry: latLng, // location is 0.0 on purpose for this example
      iconImage: iconImage,
      iconAnchor: "bottom",
    ));
  }

  Future<void> addCircle(LatLng latLng, WeMapController mapController,
      String color) async {
    await mapController.addCircle(CircleOptions(
        geometry: latLng,
        circleRadius: 8.0,
        circleColor: color,
        circleStrokeWidth: 2.5,
        circleStrokeColor: '#0071bc'));
  }
}

class WeMapDirection extends StatefulWidget {
  String originIcon;
  String destinationIcon;
  WeMapPlace originPlace;
  WeMapPlace destinationPlace;

  WeMapDirection(
      {this.originIcon,
      this.destinationIcon,
      this.originPlace,
      this.destinationPlace});

  @override
  State createState() => WeMapDirectionState();
}

class WeMapDirectionState extends State<WeMapDirection> {
  WeMapSearch search;
  WeMapController mapController;
  var mapKey = new GlobalKey();
  LatLng myLatLng;
  Color primaryColor = Color.fromRGBO(0, 113, 188, 1);
  Color primaryColorTransparent = Color.fromRGBO(0, 113, 188, 0);
  int indexOfTab = 0;
  List<LatLng> _route = [];
  List<LatLng> rootPreview = [];
  bool isController = false;
  bool _changeBackground = false;
  double _panelClosed = 75.0;
  double _panelOpened;
  double _panelCenter = 300.0;
  bool visible = false;
  bool isYour = true;
  bool myLatLngEnabled = true;
  String placeName;
  double paddingBottom;
  String from;
  String to;

  Future<void> _onMapCreated(WeMapController controller) async {
    mapController = controller;
  }

  Future<void> onSelected() async {
    if (myLatLng == null && mapController != null)
      myLatLng = await mapController.requestMyLocationLatLng();
    fromHomeStream.increment(false);
    if (widget.originPlace != null && widget.destinationPlace == null) {
      await mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          widget.originPlace.location,
          18.0,
        ),
      );
      mapController.clearSymbols();
      mapController.clearCircles();
      await WeMapDirections()
          .addCircle(widget.originPlace.location, mapController, '#d3d3d3');
//      await WeMapDirections().addMarker(widget.originPlace.location, mapController, widget.originIcon);
//      myLatLngEnabled = false;
    }
    if (widget.originPlace == null && widget.destinationPlace != null) {
      await mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          widget.destinationPlace.location,
          18.0,
        ),
      );
      mapController.clearSymbols();
      mapController.clearCircles();
      await WeMapDirections().addMarker(widget.destinationPlace.location,
          mapController, widget.destinationIcon);
//      myLatLngEnabled = false;
    }
    if (widget.originPlace != null && widget.destinationPlace != null) {
      from =
          '${widget.originPlace.location.latitude},${widget.originPlace.location.longitude}';
      to =
          '${widget.destinationPlace.location.latitude},${widget.destinationPlace.location.longitude}';
      mapController.clearLines();
      mapController.clearCircles();
//      await WeMapDirections().addMarker(widget.originPlace.location, mapController, widget.originIcon);
      mapController.clearSymbols();
//      myLatLngEnabled = false;
      if ((widget.originPlace.description != wemap_yourLocation) &&
          (widget.destinationPlace.description != wemap_yourLocation)) {
        isDrivingStream.increment(false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    timeStream.increment(0);
    distanceStream.increment(0);
    indexStream.increment(0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _panelOpened = size.height - MediaQuery.of(context).padding.top;
    return new Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          WeMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                const CameraPosition(target: LatLng(21.03, 105.78), zoom: 15.0),
            onStyleLoadedCallback: onSelected,
            myLocationEnabled: myLatLngEnabled,
            compassEnabled: true,
            compassViewMargins: Point(24, 550),
            onMapClick: (point, latlng, place) async {},
          ),
          Positioned(
            key: mapKey,
            height: 156 + MediaQuery.of(context).padding.top,
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 0, left: 0, right: 0, bottom: 55),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 12,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 0, left: 0, right: 0, bottom: 0),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Visibility(
                                  visible: false,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: PopupMenuButton<String>(
                                      onSelected: (value) {},
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuItem<String>>[
                                        const PopupMenuItem<String>(
                                          value: 'Lưu',
                                          child: Text(routeShareText),
                                        ),
                                      ],
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5, left: 0, right: 0, bottom: 0),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.swap_vert,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 45,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: indexOfTab == 0
                                            ? primaryColor
                                            : Colors.transparent,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    top: BorderSide(
                                        color: Colors.transparent,
                                        style: BorderStyle.solid,
                                        width: 2))),
                            child: CupertinoButton(
                                pressedOpacity: 0.8,
                                padding: EdgeInsets.all(0),
                                child: Icon(
                                  Icons.directions_car,
                                  color: indexOfTab == 0
                                      ? primaryColor
                                      : Colors.blueGrey,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    indexOfTab = 0;
                                  });
                                }),
                          ),
                        ),
//                            Expanded(
//                              flex: 1,
//                              child: Container(
//                                decoration: BoxDecoration(
//                                    border: Border(
//                                        bottom: BorderSide(
//                                            color: indexOfTab == 1
//                                                ? primaryColor
//                                                : Colors.transparent,
//                                            style: BorderStyle.solid,
//                                            width: 2),
//                                        top: BorderSide(
//                                            color: Colors.transparent,
//                                            style: BorderStyle.solid,
//                                            width: 2))),
//                                child: CupertinoButton(
//                                    pressedOpacity: 0.8,
//                                    padding: EdgeInsets.all(0),
//                                    child: Icon(
//                                      Icons.motorcycle,
//                                      color: indexOfTab == 1
//                                          ? primaryColor
//                                          : Colors.blueGrey,
//                                    ),
//                                    onPressed: () async {
//                                      setState(() {
//                                        indexOfTab = 1;
//                                      });
//                                      await mapController.clearLines();
//                                      await WeMapDirections().loadRoute(mapController, _route, insRoute, rootPreview, visible, indexOfTab, from, to);
//                                    }),
//                              ),
//                            ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: indexOfTab == 1
                                            ? primaryColor
                                            : Colors.transparent,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    top: BorderSide(
                                        color: Colors.transparent,
                                        style: BorderStyle.solid,
                                        width: 2))),
                            child: CupertinoButton(
                                pressedOpacity: 0.8,
                                padding: EdgeInsets.all(0),
                                child: Icon(
                                  Icons.directions_bike,
                                  color: indexOfTab == 1
                                      ? primaryColor
                                      : Colors.blueGrey,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    indexOfTab = 1;
                                  });
                                }),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: indexOfTab == 2
                                            ? primaryColor
                                            : Colors.transparent,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    top: BorderSide(
                                        color: Colors.transparent,
                                        style: BorderStyle.solid,
                                        width: 2))),
                            child: CupertinoButton(
                                pressedOpacity: 0.8,
                                padding: EdgeInsets.all(0),
                                child: Icon(
                                  Icons.directions_walk,
                                  color: indexOfTab == 2
                                      ? primaryColor
                                      : Colors.blueGrey,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    indexOfTab = 2;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
