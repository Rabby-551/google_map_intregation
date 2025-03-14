
import 'package:flutter/material.dart';
import 'package:google_map_intregation/google_map.dart';
import 'package:google_map_intregation/google_map_live_screen.dart';

void main (){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapLiveScreen(),
    );
  }
}
