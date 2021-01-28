import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyle {
  Color a = const Color.fromRGBO(78, 173, 253, 1);
  Color b = const Color.fromRGBO(70, 194, 230, 1);
  Color c = const Color.fromRGBO(67, 205, 218, 1);
  Color d = const Color.fromRGBO(62, 216, 206, 1);
  Color e = const Color.fromRGBO(55, 235, 187, 1);

  //สีมินิมอล
  Color minimal1 = const Color.fromRGBO(66, 132, 154, 1);
  Color minimal2 = const Color.fromRGBO(114, 167, 183, 1);
  Color minimal3 = const Color.fromRGBO(182, 197, 200, 1);
  Color minimal4 = const Color.fromRGBO(228, 234, 234, 0.5);
  Color minimal5 = const Color.fromRGBO(187, 220, 229, 1);
  Color minimal6 = const Color.fromRGBO(163, 179, 150, 1);

  Color minimal55 = const Color.fromRGBO(187, 220, 229, 0.5);


  LinearGradient minimalMinimal5() {
    return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          // MyStyle().minimal2,
          // MyStyle().minimal3,
          MyStyle().minimal5,
          MyStyle().minimal5,
          // MyStyle().minimal5,
          // Colors.white,
          // Colors.white,
        ]);
  }

  LinearGradient minimalLinear() {
    return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          MyStyle().minimal1,
          MyStyle().minimal1,

          // MyStyle().minimal3,
          // MyStyle().minimal4,
          // MyStyle().minimal6,
          // MyStyle().minimal6,

          // Colors.white,
          // Colors.white,
        ]);
  }

//ไล่สี
  LinearGradient buildLinearGradient() {
    return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          MyStyle().a,
          MyStyle().b,
          MyStyle().c,
          MyStyle().d,
          // MyStyle().e,
        ]);
  }

  LinearGradient buildLinearGradientBlue() {
    return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.blue,
          Colors.lightBlue[600],
          Colors.lightBlue,
          Colors.lightBlue[400],
          Colors.lightBlue[300],
        ]);
  }

  LinearGradient buildLinearGradientNewjob() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          // Colors.lightBlue[200],
          Colors.lightBlue[100],
          Colors.lightBlue[50],
          Colors.white,
        ]);
  }

  LinearGradient buildLinearGradientWhite() {
    return LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          Colors.grey[50],
          Colors.grey[50],
          // Colors.grey[100],
          Colors.grey[100],
          // Colors.grey[300],
        ]);
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget titleCenter(String string) {
    return Center(
      child: Text(
        string,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

//ตัวหนังสือ
  Text showTitle(String title) => Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTitleType(String title) => Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      );

//เว้นระยะห่าง
  SizedBox mySizeBox() => SizedBox(
        width: 8,
        height: 16,
      );

  SizedBox mySizeBoxIm() => SizedBox(
        height: 10,
      );

  SizedBox mySizeBoxText() => SizedBox(
        height: 1,
      );

  MyStyle();
}

var kTitleStyle = GoogleFonts.ubuntu();
