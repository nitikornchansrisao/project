import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttime/utility/style.dart';

Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      // color: Colors.orange[800],
                      // color: Colors.white,
                      color: MyStyle().minimal1,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            // title: Text(
            //   message,
            //   style: GoogleFonts.ubuntu(
            //     textStyle: TextStyle(
            //       // color: Colors.orange[800],
            //       // color: Colors.white,
            //       color: MyStyle().minimal1,
            //       fontSize: 22,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // color: Colors.blue,
                      color: MyStyle().minimal1,
                      child: Text(
                        'OK',
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )),
                ],
              )
            ],
          ));
}
