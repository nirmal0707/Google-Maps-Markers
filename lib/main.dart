import 'package:flutter/material.dart';

import 'mapspage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps Marker',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryTextTheme: TextTheme(
            headline6: TextStyle(color: Theme.of(context).canvasColor)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapsPage(title: 'Google Maps Marker'),
    );
  }
}
