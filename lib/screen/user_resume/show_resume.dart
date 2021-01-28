import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/model/resume_model.dart';
import 'package:parttime/model/user_model.dart';

import 'package:parttime/screen/edit_job.dart';
import 'package:parttime/screen/main_company.dart';
import 'package:parttime/screen/sign_in.dart';
import 'package:parttime/screen/user_resume/add_resume.dart';
import 'package:parttime/utility/icons.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';

import 'package:flutter/material.dart';
import 'package:parttime/utility/signout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../add_info.dart';
import 'edit_resume.dart';

class MyResume extends StatefulWidget {
  @override
  _MyResumeState createState() => _MyResumeState();
}

class _MyResumeState extends State<MyResume> {
  ResumeModel resumeModel;
  UserModel userModel;

  final refreshKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readResume();
  }

  Future<Null> readResume() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id_user = preferences.getString('id');
    print('id_user ==== $id_user');

    String url =
        '${MyConstant().domain}/parttime/getResume.php?isAdd=true&id_user=$id_user';
    await Dio().get(url).then((value) {
      print('value === $value');

      var result = json.decode(value.data);

      for (var map in result) {
        setState(() {
          resumeModel = ResumeModel.fromJson(map);
          // print('id_resume ==== ${resumeModel.id}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 0,
        title: Text('My Resume',
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
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: readResume,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Container(
              //   color: MyStyle().minimal5,
              //   height: 160,
              //   width: double.infinity,
              // ),
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: MyStyle().minimalMinimal5(),
                    // color: Colors.blue[500],
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      resumeModel == null ? addCard() : showContent(),

                      // showContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addCard() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      // width: 190,
      height: 190,

      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(8, 12),
            blurRadius: 15,
            spreadRadius: -17,
            color: Colors.grey,
          )
        ],
        border: Border.all(color: Colors.grey[100], width: 3),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => AddResume(),
            );
            Navigator.push(context, route);
          },
          borderRadius: BorderRadius.circular(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create Your Resume',
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      // color: Colors.white,
                      color: MyStyle().minimal1,

                      // letterSpacing: .5,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Container showContent() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _picture1(),
            ],
          ),
          name(),
          _description(),
          _contact(),
          _btnAccept(),
        ],
      ),
    );
  }

  Widget _picture1() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: [
          BoxShadow(
            offset: Offset(8, 12),
            blurRadius: 15,
            spreadRadius: -17,
            color: Colors.grey,
          )
        ],
      ),
      child: CircleAvatar(
        backgroundImage:
            NetworkImage('${MyConstant().domain}${resumeModel.urlPicture}'),
        radius: 100,
      ),
    );
  }

  Widget name() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                resumeModel.firstname,
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    // color: Colors.orange[800],
                    color: MyStyle().minimal1,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text('    '),
              Text(
                resumeModel.lastname,
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    // color: Colors.orange[800],
                    color: MyStyle().minimal1,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _description() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 0, top: 15),
      width: double.infinity,
      height: 210,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 5, left: 20),
                child: Text(
                  "Description",
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      // color: Colors.orange[800],
                      color: MyStyle().minimal1,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Container(
                  // decoration: BoxDecoration(
                  //   // color: Colors.white,
                  //   color: MyStyle().minimal1,
                  //   borderRadius: BorderRadius.all(Radius.circular(120)),
                  //   // border: Border.all(
                  //   //   width: 5,
                  //   //   // color: Colors.blue,
                  //   //   color: MyStyle().minimal6,
                  //   // ),
                  // ),
                  margin: EdgeInsets.only(right: 16, top: 5),
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: MyStyle().minimal1,
                      // color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditResume()));
                    },
                  ))
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 30),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.assignment,
                      color: Colors.blue[400],
                    ),
                    Text(
                      ' ชื่อ :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      resumeModel.firstname,
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.stars,
                      color: Colors.blue[400],
                    ),
                    Text(
                      ' นามสกุล :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      resumeModel.lastname,
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.assignment_ind,
                      color: Colors.blue[400],
                    ),
                    Text(
                      ' อายุ :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      resumeModel.age,
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      ' ปี ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.monetization_on,
                      color: Colors.blue[400],
                    ),
                    Text(
                      ' ประสบการณ์ :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      resumeModel.experience,
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.accessibility,
                      color: Colors.blue[400],
                    ),
                    Text(
                      ' เพศ :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      resumeModel.gender,
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contact() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        // color: Colors.grey[100],
        color: MyStyle().minimal4,

        borderRadius: BorderRadius.all(Radius.circular(20)),
        // border: Border.all(
        //   width: 5,
        //   // color: Colors.blue,
        //   color: MyStyle().minimal2,
        // ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 15, left: 20),
            child: Text(
              "Contact",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: MyStyle().minimal1,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 7, left: 30),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.perm_phone_msg,
                  color: Colors.blue[400],
                ),
                Text(
                  ' ติดต่อ : ',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6),
                  child: Text(
                    resumeModel.contact,
                    style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 7, left: 30),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.perm_phone_msg,
                  color: Colors.blue[400],
                ),
                Text(
                  ' ที่อยู่ : ',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6),
                  child: Text(
                    resumeModel.address,
                    style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnAccept() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 25),
      height: 60,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditResume()));
        },
        padding: EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        // color: Colors.blue[500],

        color: MyStyle().minimal1,
        child: Text(
          'EDIT RESUME',
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
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height - 20); //vertical line
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 20); //cubic curve
    path.lineTo(size.width, 0); //vertical line
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
