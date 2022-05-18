
import 'dart:async';
import 'dart:io';

import 'package:fake_call_mobile/features/views/map/ui/map_style.dart';
import 'package:fake_call_mobile/utils/services/voice_service.dart';
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



  late BitmapDescriptor pinLocationIcon;
  void setCustomMapPin() async {

    pinLocationIcon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(

    ),
        Platform.isIOS? 'assets/markerDefaultIOS':'assets/DefaultMarkerAndroid.png');
  }

  // List<LocationModel>? rests;
  var status =  Permission.location.status;

  final VoiceService _voiceService = VoiceService();

  List<Marker> markersBuilder({required List<LocationModel> rests}) {
    return List.generate(rests.length, (index) {
      return Marker(
        icon: pinLocationIcon,

        markerId: MarkerId(rests[index].id.toString()),
        position: LatLng(
          double.parse(rests[index].latitude),
          double.parse(rests[index].longitude)
        ),
        infoWindow: InfoWindow(
          onTap: () {
            Navigator.pushNamed(context, '/restaurant_details',
                arguments: rests[index].id);
          },

          title: rests[index].username,
          snippet: rests[index].phoneNumber,
        ),
      );
    });
  }

  // void onMapCreated(GoogleMapController controller) {
  //   googleMapController = controller;
  //
  //   _currentLocation(controller);
  //
  // }


  List<LocationModel>? locations = [];

  Set<Marker> getmarkers(List<Marker> markersToList) {
    //markers to place on map

    for (int i = 0; i < markersToList.length; i++) {
      markers.add(markersToList[i]);
    }

    return markers;
  }

  void setLocations() async {
    locations = await _voiceService.getAllLocations();
    setState(() {

    });
  }


  final Set<Marker> markers = {}; //markers for google map



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
    super.initState();
    getLocationPermission();
    WidgetsBinding.instance!.addPostFrameCallback((_){
      setLocations();
      setCustomMapPin();
    });
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
          markers: getmarkers(markersBuilder(rests: locations!)),
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
    googleMapController.setMapStyle(MapStyle.mapStyle);

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
