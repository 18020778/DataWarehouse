

import 'package:first_app/buy_products/wemap/place/place.dart';
import 'package:first_app/buy_products/wemap/place/place_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as GPSService;

import '../language_vi.dart';
import '../location.dart';
import '../plugin.dart';
import '../wemap_navigation.dart';

class WeMapPlaceCard extends StatefulWidget {
  WeMapPlace place;

  /// The callback function that is called when close this place card
  final void Function() onPlaceCardClose;

  /// Place card's padding
  final EdgeInsetsGeometry padding;

  /// Place card's BorderRadius
  final BorderRadiusGeometry borderRadius;

  /// List buttons after the direction button
  List<Widget> buttons;

  /// On/Off the clear button, default is on (true)
  final bool showClearButton;

  /// destination Icon for Direction
  String destinationIcon;

  WeMapPlaceCard({
    @required this.place,
    @required this.onPlaceCardClose,
    this.buttons,
    this.showClearButton = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    this.padding = const EdgeInsets.only(
      left: 8.0,
      right: 8.0,
      bottom: 8.0,
    ),
    this.destinationIcon,
  }) {
    if (this.buttons == null) this.buttons = [];
  }

  @override
  State<StatefulWidget> createState() => _WeMapPlaceCardState();
}

class _WeMapPlaceCardState extends State<WeMapPlaceCard> {
  String _linkMessage;
  WeMapNavigation _directions;
  Location _des = Location(
    name: "hihi2",
    latitude: 21.033811834334458,
    longitude: 105.7840838429172,
  );


  @override
  Widget build(BuildContext context) {
    return widget.place == null
        ? Container()
        : Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: widget.padding,
            child: GestureDetector(
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WeMapPlaceDesc(
                            destinationIcon: widget.destinationIcon,
                            place: widget.place,
                            buttons: widget.buttons,
                          ),
                    ),
                  ),
              child: Container(
                padding: EdgeInsets.only(top: 16.0, left: 16.0),
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: widget.borderRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      upperFirstLetter(widget.place.placeName),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                    ),
                    Text(
                      upperFirstLetter(widget.place.street +
                          ", " +
                          widget.place.cityState),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      height: 60,
                      child: ListView(
                        padding: EdgeInsets.only(
                          bottom: 16,
                          right: 16,
                          top: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          OutlineButtonCustom(
                            icon: Icons.directions,
                            buttonName: directionBtn,
                            onPressed: () {
                              WeMapPlace origin;
                              WeMapPlace destination;
                              print(widget.place.location);
                              if (widget.place != null) {
                                weRequestLocation();

                                final location =
                                GPSService.Location();
                                location
                                    .getLocation()
                                    .then((locationData) {
                                  _des = Location(
                                    name: widget.place.placeName,
                                    latitude: widget
                                        .place.location.latitude,
                                    longitude: widget
                                        .place.location.longitude,
                                  );
                                  destination = new WeMapPlace(
                                    location: LatLng(
                                      _des.latitude,
                                      _des.longitude,
                                    ),
                                    description:
                                    widget.place.placeName,
                                  );
                                  print(destination.description);
                                });
                              }

                              /// write your action for Direction button here
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          OutlineButtonCustom(
                            icon: Icons.navigation,
                            buttonName: start,
                            onPressed: () {
                              if (widget.place != null) {
                                weRequestLocation();
                                final location =
                                GPSService.Location();
                                location
                                    .getLocation()
                                    .then((locationData) {
                                  _des = Location(
                                    name: widget.place.placeName,
                                    latitude: widget
                                        .place.location.latitude,
                                    longitude: widget
                                        .place.location.longitude,
                                  );
                                });
                              }
                            },
                          )
                        ] +
                            widget.buttons,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        widget.showClearButton
            ? Positioned(
          bottom: 128,
          right: 32.0,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            elevation: 0.6,
            child: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                widget.place = null;
                widget.onPlaceCardClose();
              });
            },
          ),
        )
            : Container(),
      ],
    );
  }
}
String upperFirstLetter(String str) {
  String fl = str[0].toUpperCase();
  String tail = str.substring(1);
  return fl + tail;
}

class OutlineButtonCustom extends OutlineButton {
  final VoidCallback onPressed;
  IconData icon;
  String buttonName;
  EdgeInsetsGeometry padding;
  static final Color highlightedColor = primaryColor;
  static final shape2 = StadiumBorder();
  static final borderSide2 = BorderSide(
    color: primaryColor,
  );

  OutlineButtonCustom({
    @required this.onPressed,
    this.icon,
    this.buttonName,
    this.padding,
  }) : super(
          padding: padding,
          onPressed: onPressed,
          color: Colors.black,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: primaryColor,
              ),
              SizedBox(width: 8),
              Text(buttonName,
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.w500))
            ],
          ),
          highlightedBorderColor: highlightedColor,
          shape: shape2,
          borderSide: borderSide2,
        );
}
