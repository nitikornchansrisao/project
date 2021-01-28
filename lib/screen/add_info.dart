import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';
import 'package:parttime/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInformation extends StatefulWidget {
  @override
  _AddInformationState createState() => _AddInformationState();
}

class _AddInformationState extends State<AddInformation> {
  Map<String, bool> values = {
    'Sun': false,
    'Mon': false,
    'Tue': false,
    'Wed': false,
    'Thur': false,
    'Fri': false,
    'Sat': false,
  };

  var tmpArray = [];

  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    print(tmpArray);

    tmpArray.clear();
  }

  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 0,
        title: Text('Part-Time job',
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                color: Colors.white,
                // color: MyStyle().minimal1,

                // letterSpacing: .5,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )),
        centerTitle: true,
        gradient: MyStyle().minimalLinear(),
      ),
      body: Column(
        children: [
          checkbox1(),
          RaisedButton(
            child: Text(
              " Get Selected Checkbox Items ",
              style: TextStyle(fontSize: 18),
            ),
            onPressed: getCheckboxItems,
            color: Colors.deepOrange,
            textColor: Colors.white,
            splashColor: Colors.grey,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
          // checkbox(),

          // _dropDownGender(),
          _buildSignUpBtn(context),
        ],
      ),
    );
  }

  Expanded checkbox1() {
    return Expanded(
      child: Row(
        children: values.keys.map((String key) {
          return Column(
            children: [
              Text(
                key,
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    // color: Colors.orange[800],
                    color: MyStyle().minimal1,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Checkbox(
                checkColor: Colors.white,
                activeColor: MyStyle().minimal1,
                value: values[key],
                onChanged: (bool value) {
                  setState(() {
                    values[key] = value;
                  });
                },
              )
            ],
          );
        }).toList(),
      ),
    );
  }

  // Widget _dropDownGender() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
  //     child: Row(
  //       children: <Widget>[
  //         // Icon(
  //         //   Icons.assignment_ind,
  //         //   color: Colors.blueAccent,
  //         //   size: 24.0,
  //         // ),
  //         Container(
  //           margin: EdgeInsets.only(left: 5, right: 17),
  //           child: Text(
  //             "Gender:",
  //             style: GoogleFonts.ubuntu(
  //               textStyle: TextStyle(
  //                 // color: Colors.orange[800],
  //                 color: MyStyle().minimal1,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w800,
  //               ),
  //             ),
  //           ),
  //         ),
  //         DropdownButton(
  //           value: id_gender,
  //           hint: Text(
  //             "Select Gender",
  //             style: GoogleFonts.ubuntu(
  //               textStyle: TextStyle(
  //                 // color: Colors.orange[800],
  //                 color: MyStyle().minimal1,
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ),
  //           items: dataGender.map(
  //             (list) {
  //               return DropdownMenuItem(
  //                 child: Text(
  //                   list['gender'],
  //                   style: GoogleFonts.kanit(
  //                     textStyle: TextStyle(
  //                       // color: Colors.orange[800],
  //                       color: MyStyle().minimal1,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ),
  //                 value: list['gender'].toString(),
  //               );
  //             },
  //           ).toList(),
  //           onChanged: (value) {
  //             setState(() {
  //               id_gender = value;
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSignUpBtn(context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ///COMFIRM
          Container(
            // margin: EdgeInsets.only(left: 20),
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {
                print('gender === $dropdownValue');
              },
              padding:
                  EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // color: Colors.blue[500],

              color: MyStyle().minimal1,
              child: Text(
                'COMFIRM',
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    // color: Colors.orange[800],
                    color: Colors.white,
                    // color: MyStyle().minimal1,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future getAllGender() async {
  //   var response = await http.get(
  //       "${MyConstant().domain}/parttime/viewGender.php",
  //       headers: {"Accept": "application/json"});
  //   var jsonBody = response.body;
  //   var jsonData = json.decode(jsonBody);

  //   setState(() {
  //     dataGender = jsonData;
  //   });

  //   print(jsonData);
  //   return "success";
  // }
}
