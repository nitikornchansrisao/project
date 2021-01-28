import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:parttime/screen/main_user.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';
import 'package:parttime/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddResume extends StatefulWidget {
  @override
  _AddResumeState createState() => _AddResumeState();
}

class _AddResumeState extends State<AddResume> {
  String firstname,
      lastname,
      age,
      gender,
      experience,
      address,
      contact,
      urlPicture;

  List dataGender = List();

  File file;

  @override
  void initState() {
    getAllGender();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().minimal2,
        shadowColor: Colors.transparent,
        title: Text('Resume',
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
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: Container(
                  padding: EdgeInsets.only(left: 40, top: 60, bottom: 70),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // gradient: MyStyle().minimalLinear(),
                      color: MyStyle().minimal2,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(50))),
                  child: Text("Create Your \nResume",
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ),

              SafeArea(
                child: Column(
                  children: <Widget>[
                    /// SHOW_PICTURE
                    Container(
                      margin: EdgeInsets.only(left: 240),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                child: InkWell(
                                  child: file == null
                                      ? Image.asset(
                                          'assets/user.png',
                                          width: 100,
                                        )
                                      : CircleAvatar(
                                          radius: 70,
                                          backgroundImage: FileImage(file),
                                        ),
                                  // : Image.file(file,),
                                  onTap: () {
                                    _dialog();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///UPLOAD
                    Container(
                      margin: EdgeInsets.only(left: 236),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.cloud_upload,
                              color: Colors.white70,
                              size: 35,
                            ),
                            color: Colors.pink,
                            onPressed: () {
                              _dialog();
                            },
                          ),
                          Text(
                            "Upload Image",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///FORM
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35, top: 190),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      color: MyStyle().minimal4,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      // border: Border.all(
                      //   width: 5,
                      //   // color: Colors.blue,
                      //   color: MyStyle().minimal6,
                      // ),
                    ),
                    child: Column(
                      children: <Widget>[
                        _inputFirstname(),
                        _inputLastname(),
                        SizedBox(height: 10),
                        _dropDownGender(),
                        _inputAge(hint: "", icon: Icons.accessibility),
                        SizedBox(height: 10),
                        _inputExperience(hint: "", icon: Icons.vpn_key),
                        SizedBox(height: 10),
                        _inputAddress(hint: "", icon: Icons.account_box),
                        _inputContact(hint: "", icon: Icons.account_box),
                        SizedBox(height: 30),
                        _btnAddResume(context),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputFirstname({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        width: 300,
        child: TextFormField(
          onChanged: (value) => firstname = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            labelText: 'Firstname :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputLastname({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        width: 300,
        child: TextFormField(
          onChanged: (value) => lastname = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            labelText: 'Lastname :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropDownGender() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          // Icon(
          //   Icons.assignment_ind,
          //   color: Colors.blueAccent,
          //   size: 24.0,
          // ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 17),
            child: Text(
              "Gender:",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  // color: Colors.orange[800],
                  color: MyStyle().minimal1,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          DropdownButton(
            value: gender,
            hint: Text(
              "Select Gender",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  // color: Colors.orange[800],
                  color: MyStyle().minimal1,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            items: dataGender.map(
              (list) {
                return DropdownMenuItem(
                  child: Text(
                    list['gender'],
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        // color: Colors.orange[800],
                        color: MyStyle().minimal1,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  value: list['gender'].toString(),
                );
              },
            ).toList(),
            onChanged: (value) {
              setState(() {
                gender = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Future getAllGender() async {
    var response = await http.get(
        "${MyConstant().domain}/parttime/viewGender.php",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      dataGender = jsonData;
    });

    print(jsonData);
    return "success";
  }

  Widget _inputAge({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        width: 300,
        child: TextFormField(
          onChanged: (value) => age = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            labelText: 'Age :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputExperience({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        width: 300,
        child: TextFormField(
          onChanged: (value) => experience = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            labelText: 'Experience :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputAddress({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        width: 300,
        child: TextFormField(
          onChanged: (value) => address = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            labelText: 'Address :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputContact({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        width: 300,
        child: TextFormField(
          onChanged: (value) => contact = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.5),
            ),
            labelText: 'Contact :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _btnAddResume(context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Row(
          children: <Widget>[
            ///CLEAR
            Container(
              margin: EdgeInsets.only(left: 10),
              child: RaisedButton(
                elevation: 5.0,
                onPressed: () => {},
                padding:
                    EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // color: Colors.blue[500],

                color: MyStyle().minimal3,
                child: Text(
                  'CLEAR',
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

            ///COMFIRM
            Container(
              margin: EdgeInsets.only(left: 20),
              child: RaisedButton(
                elevation: 5.0,
                onPressed: () {
                  if (firstname == null || firstname.isEmpty) {
                    normalDialog(context, 'Please enter name');
                  } else if (lastname == null || lastname.isEmpty) {
                    normalDialog(context, 'Please enter password');
                  } else if (age == null || age.isEmpty) {
                    normalDialog(context, 'Please enter password');
                  } else if (gender == null || gender.isEmpty) {
                    normalDialog(context, 'Please enter password');
                  } else if (experience == null || experience.isEmpty) {
                    normalDialog(context, 'Please enter password');
                  } else if (address == null || address.isEmpty) {
                    normalDialog(context, 'Please enter gender');
                  } else if (contact == null || contact.isEmpty) {
                    normalDialog(context, 'Please enter password');
                  } else {
                    uploadImage();
                  }
                },

                padding:
                    EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // color: Colors.blue[500],

                color: MyStyle().minimal1,
                child: Text(
                  'CONFIRM',
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
      ),
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'user$i.jpg';

    String url = '${MyConstant().domain}/parttime/saveImageUser.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('Response ==>> $value');
        urlPicture = '/parttime/Category/$nameImage';
        print('urlImage = $urlPicture');
        addResume();
      });
    } catch (e) {}
  }

  Future<void> _dialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose an option",
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
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                      child: Text(
                        "   Gallery",
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            // color: Colors.orange[800],
                            // color: Colors.white,
                            color: MyStyle().minimal1,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onTap: () {
                        chooseImage(ImageSource.gallery);
                        Navigator.pop(context);
                      }
                      // onTap: () => chooseImage(ImageSource.gallery),

                      ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                      child: Text(
                        "   Camera",
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            // color: Colors.orange[800],
                            // color: Colors.white,
                            color: MyStyle().minimal1,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onTap: () {
                        chooseImage(ImageSource.camera);
                        Navigator.pop(context);
                      }
                      // onTap: () => chooseImage(ImageSource.camera),
                      ),
                ],
              ),
            ),
          );
        });
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxHeight: 250.0,
        maxWidth: 250.0,
      );
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Future<Null> addResume() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id_user = preferences.getString('id');

    String url =
        '${MyConstant().domain}/parttime/addResume.php?id_user=$id_user&firstname=$firstname&lastname=$lastname&age=$age&gender=$gender&experience=$experience&address=$address&contact=$contact&urlPicture=$urlPicture';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'Cannot Register!');
      }
    } catch (e) {}
  }
}
