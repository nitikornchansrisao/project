import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttime/screen/home.dart';
import 'package:parttime/utility/style.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2800), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: MyStyle().a,
        decoration: BoxDecoration(
          gradient: MyStyle().minimalLinear(),
        ),
        child: Center(
          child: Text(
            'Part-Time Job',
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                color: Colors.white,
                // letterSpacing: .5,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            // child: Image.asset("assets/partner.png", width: 150),
          ),
        ),
      ),
    );
  }
}
