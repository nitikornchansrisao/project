
import 'package:flutter/material.dart';
import 'package:parttime/screen/home.dart';
import 'package:parttime/screen/start_app.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home",
      // theme: ThemeData(primarySwatch: Colors.amber),
      home: Start(),
    );
  }
}

