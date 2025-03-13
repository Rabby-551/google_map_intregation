import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  static const LatLng _pGooglePlex =
      LatLng(23.775296799478227, 90.36519209370027);

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: _pGooglePlex,
          zoom: 16.0,
        ),
        onTap: (LatLng? latlng) {
          print(latlng);
        },
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        trafficEnabled: true,
        // ADD Marker on map
        markers: <Marker>{
          const Marker(
            markerId: MarkerId('initial-position'),
            position: _pGooglePlex,
          ),
          Marker(
            markerId: MarkerId('Home'),
            position: LatLng(23.77531946411398, 90.36162078380585),
            infoWindow: InfoWindow(
                title: 'Home',
                onTap: () {
                  print('on tapped Home');
                }),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            draggable: true,
            onDragStart: (LatLng onStartLatLng) {
              print('on drag start $onStartLatLng');
            },
            onDragEnd: (LatLng onEndLatLng) {
              print('on drag End $onEndLatLng');
            },
          ),
        },

        // ADD Circle on map
        circles: <Circle>{
          Circle(
            circleId: const CircleId('Dengue-Zone'),
            fillColor: Colors.red.withOpacity(0.5),
            center: LatLng(23.77515807543871, 90.36197751760483),
            radius: 300,
            strokeColor: Colors.black,
            strokeWidth: 4,
            visible: true,
            onTap: () {
              print('on tapped Dengue-Zone');
            },
          ),
          Circle(
              circleId: const CircleId('Corona-Zone'),
              fillColor: Colors.purpleAccent.withOpacity(0.5),
              center: LatLng(23.77607117678774, 90.3697881102562),
              radius: 200,
              strokeColor: Colors.orange,
              strokeWidth: 4,
              visible: true,
              onTap: () {
                print('on tapped Corona-Zone');
              })
        },

        // ADD Polyline on map
        polylines: <Polyline>{
          const Polyline(
            polylineId: PolylineId('Random'),
            points: <LatLng>[
              LatLng(23.785508636360145, 90.35960275679827),
              LatLng(23.792712675432547, 90.36534335464239),
              LatLng(23.78314381321582, 90.37294372916222),
            ],
            color: Colors.blue,
            width: 4,
            jointType: JointType.round,
            //patterns: [PatternItem.dash(10), PatternItem.gap(10)],
          ),
        },

        // ADD Polygon on map
        polygons: <Polygon>{
          Polygon(
            polygonId: const PolygonId('Random'),
            fillColor: Colors.greenAccent.withOpacity(0.5),
            strokeColor: Colors.black,
            strokeWidth: 3,
            points: const <LatLng>[
              LatLng(23.78471678742265, 90.36433048546314),
              LatLng(23.783202105948472, 90.36143705248833),
              LatLng(23.78040832064521, 90.36505434662104),
              LatLng(23.783796690328586, 90.36673374474049)
            ],
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(target: _pGooglePlex, zoom: 16.0),
            ),
          );
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
