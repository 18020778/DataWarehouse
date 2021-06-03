

import 'package:first_app/buy_products/wemap/place/place.dart';
import 'package:first_app/buy_products/wemap/place/place_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart' as GPSService;

import '../custom_appbar.dart';
import '../language_vi.dart';
import '../location.dart';
import '../plugin.dart';
import '../wemap_navigation.dart';

class WeMapPlaceDesc extends StatefulWidget {
  final WeMapPlace place;

  /// List buttons after direction button
  List<Widget> buttons;
  String destinationIcon;
  WeMapPlaceDesc({@required this.place, this.buttons, this.destinationIcon}) {
    if (this.buttons == null) this.buttons = [];
  }

  @override
  State<StatefulWidget> createState() => _WeMapPlaceDescState();
}

class _WeMapPlaceDescState extends State<WeMapPlaceDesc> {
  List tagsName = [];
  Location _des = Location(
    name: "hihi2",
    latitude: 21.033811834334458,
    longitude: 105.7840838429172,
  );

  @override
  void initState() {
    if (widget.place.extraTags != null) {
      tagsName = widget.place.extraTags.keys.toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          upperFirstLetter(widget.place.placeName),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                          CustomButton(
                            buttonName: directionBtn.toUpperCase(),
                            context: context,
                            onPressed: () {
                              WeMapPlace origin;
                              WeMapPlace destination;
                              print(widget.place.location);
                              if (widget.place != null) {
                                weRequestLocation();
                                final location = GPSService.Location();
                                location.getLocation().then((locationData) {
                                  _des = Location(
                                    name: widget.place.placeName,
                                    latitude: widget.place.location.latitude,
                                    longitude: widget.place.location.longitude,
                                  );
                                  destination = new WeMapPlace(
                                    location:
                                        LatLng(_des.latitude, _des.longitude),
                                    description: widget.place.placeName,
                                  );
                                  print(destination.description);

                                                                  });
                              }

                              /// write your action for Direction button here
                            },
                          ),
                          CustomButton(
                            icon: Icons.navigation,
                            buttonName: start.toUpperCase(),
                            context: context,
                            onPressed: () {
                              if (widget.place != null) {
                                weRequestLocation();
                                final location = GPSService.Location();
                                location.getLocation().then((locationData) {

                                  _des = Location(
                                    name: widget.place.placeName,
                                    latitude: widget.place.location.latitude,
                                    longitude: widget.place.location.longitude,
                                  );
                                });
                              }
                            },
                          )
                        ] +
                        widget.buttons,
                  ),
                ),
                ListTile(
                  title: Text(widget.place.street != null
                      ? upperFirstLetter(
                          widget.place.street + ", " + widget.place.cityState)
                      : upperFirstLetter(widget.place.cityState)),
                  leading: Icon(
                    Icons.location_on,
                    color: primaryColor,
                  ),
                  selected: false,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                      "${widget.place.location.latitude.toStringAsFixed(5)}, ${widget.place.location.longitude.toStringAsFixed(5)}"),
                  leading: Icon(
                    Icons.my_location,
                    color: primaryColor,
                  ),
                  selected: false,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

       ] ),
      ),
    );
  }
}

class CustomButton extends Container {
  BuildContext context;
  final VoidCallback onPressed;
  IconData icon;
  String buttonName;
  double width;

  CustomButton(
      {@required this.onPressed, this.buttonName, this.icon, this.context})
      : super(
          width: MediaQuery.of(context).size.width / 4,
          child: Center(
            child: Column(
              children: <Widget>[
                OutlineButton(
                  child: Icon(
                    icon,
                    color: primaryColor,
                  ),
                  onPressed: onPressed,
                  shape: CircleBorder(),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                Text(
                  buttonName,
                  style: TextStyle(color: primaryColor, fontSize: 12),
                )
              ],
            ),
          ),
        );
}
