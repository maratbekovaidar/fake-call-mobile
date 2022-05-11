
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  static const route = "/map";

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController googleMapController;

  var status = Permission.location.status;

  LatLng myLocation = const LatLng(37.43296265331129, -122.08832357078792);
  bool shareVisibility = false;

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  @override
  void initState() {
    //custom marker
    setCustomMapPin();
    getLocationPermission();
    super.initState();
  }

  late BitmapDescriptor pinLocationIcon;
  void setCustomMapPin() {

    pinLocationIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    //     .fromAssetImage(const ImageConfiguration(
    //
    // ),
    //   Platform.isIOS? 'assets/images/new_design/markerDefaultIOS':'assets/images/new_design/DefaultMarkerAndroid.png');
  }


  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: _kLake,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            onMapCreated(controller);
          },
          circles: _shareMyLocation(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            shareVisibility = !shareVisibility;
            _shareMyLocation();
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                bearing: 0,
                target: LatLng(myLocation.latitude, myLocation.longitude),
                zoom: 17.0,
              ),
            ));
          });
        },
        label: const Text('Share My Location!'),
        icon: const Icon(Icons.wifi_tethering),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }




  Location location = Location();

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    _currentLocation(controller);

  }

  void getLocationPermission() async {
    if (await Permission.location.request().isGranted) {
    }
  }

  int _circleIdCounter = 1;

  Set<Circle> _shareMyLocation() {
    final String circleVal = 'circle_id_$_circleIdCounter';
    _circleIdCounter++;
    Set<Circle> circles = {Circle(
      circleId: CircleId(circleVal),
      fillColor: const Color.fromRGBO(0, 0, 255, 0.3),
      strokeColor: Colors.blue,
      strokeWidth: 3,
      center: LatLng(myLocation.latitude, myLocation.longitude),
      radius: 200,
      visible: shareVisibility
    )};


    return circles;
  }

  void _currentLocation(GoogleMapController controller) async {
    LocationData currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      return ;
    }
    myLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 17.0,
      ),
    ));
  }


}
