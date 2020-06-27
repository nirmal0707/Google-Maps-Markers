import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  MapsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _googleMapController = Completer();
  List<Marker> markers = [];
  LatLng latlng = LatLng(40.7128, -74.0060);

  _getPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _changeCameraPosition(position);
  }

  _changeCameraPosition(Position position) async {
    await _googleMapController.future.then((value) {
      value.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.0,
        ),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    _getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: latlng, zoom: 14.0),
        markers: Set.from(markers),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController googleMapController) {
          _googleMapController.complete(googleMapController);
        },
        onTap: _onMapTapped,
      ),
    );
  }

  _onMapTapped(LatLng tappedPosition) {
    print(tappedPosition);
    setState(() {
//      Uncomment the next line if you need only one point from the map.
//      markers = [];
      markers.add(
        Marker(
          markerId: MarkerId(tappedPosition.toString()),
          position: tappedPosition,
          draggable: true,
          onDragEnd: (dragEndPosition) => print(dragEndPosition),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        ),
      );
    });
  }
}
