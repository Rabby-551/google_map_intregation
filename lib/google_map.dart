import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  static const LatLng _pGooglePlex = LatLng(23.775296799478227, 90.36519209370027);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 16.0,
      )),
    );
  }
}
