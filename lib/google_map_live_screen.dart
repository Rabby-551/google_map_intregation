import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//GPS -> Current Location - Latitude & Longitude
//GPS service permission - Yes
//GPS service ON/OFF - Yes
//get data from GPS

class GoogleMapLiveScreen extends StatefulWidget {
  const GoogleMapLiveScreen({super.key});

  @override
  State<GoogleMapLiveScreen> createState() => _GoogleMapLiveScreenState();
}

class _GoogleMapLiveScreenState extends State<GoogleMapLiveScreen> {

  Position? position;
 @override
  void initState() {
    super.initState();
    listenCurrentLocation();
  }

  Future<void> listenCurrentLocation() async {
    final isGranted = await isLocationPermissionGranted();
    if (isGranted) {
      final isServiceEnable = await checkGPSServiceEnable();
      if (isServiceEnable) {
        Geolocator.getPositionStream(
          locationSettings: LocationSettings(
            timeLimit: Duration(seconds: 5),
            distanceFilter: 10,
            accuracy: LocationAccuracy.bestForNavigation,
          ),
        ).listen((position){
          print(position);
        });
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();
      if (result) {
        getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  //get current location
  Future<void> getCurrentLocation() async {
    final isGranted = await isLocationPermissionGranted();
    if (isGranted) {
      final isServiceEnable = await checkGPSServiceEnable();
      if (isServiceEnable) {
        Position p = await Geolocator.getCurrentPosition();
       position = p;
       setState(() { });
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();
      if (result) {
        getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  //request location permission
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  //check location permission
  Future<bool> isLocationPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

// GPS service ON/OFF
  Future<bool> checkGPSServiceEnable() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map Live'),
      ),
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[ Text('My Current location: $position'),
          ElevatedButton(
            onPressed: () {
              getCurrentLocation();
            },
            child: Text('Get Current Location'),
          ),
        ],
      ),
      ),
    );
  }
}
