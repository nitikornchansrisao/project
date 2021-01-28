import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:location/location.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';
import '../sign_in.dart';

void main() => runApp(MaterialApp(home: HomeJobDescription()));

class HomeJobDescription extends StatefulWidget {
  final JobDesModel jobDesModel;
  HomeJobDescription({Key key, this.jobDesModel}) : super(key: key);

  @override
  _HomeJobDescriptionState createState() => _HomeJobDescriptionState();
}

class _HomeJobDescriptionState extends State<HomeJobDescription> {
  // String id_user;
  double lat1, lng1, lat2, lng2;
  Location location = Location();
  JobDesModel jobDesModel;

  @override
  void initState() {
    super.initState();
    jobDesModel = widget.jobDesModel;
    findLatLng();
    // findLocationData();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat1 = locationData.latitude;
      lng1 = locationData.longitude;
      lat2 = double.parse(jobDesModel.lat);
      lng2 = double.parse(jobDesModel.lng);
    });
    print('lat = $lat2 , lng = $lng2');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 0,
        title: Text('Part-Time Job',
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
      body: SingleChildScrollView(
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
                height: 170,
                decoration: BoxDecoration(
                  gradient: MyStyle().minimalMinimal5(),
                  // color: Colors.blue[500],
                ),
              ),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    showContent(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showContent() {
    return Container(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.grey),
                      iconSize: 40,
                      onPressed: () {
                        signInDialog();
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _picture(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _nameCompany(),
                  // IconFavorite(),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                _description(),
                _contact(),
                _mapIcon(),
                lat1 == null ? MyStyle().showProgress() : _map(),
              ],
            ),
          ),
          _btnAccept(),
        ],
      ),
    );
  }

  Widget _picture() {
    return Container(
      // margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(80)),
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
            NetworkImage('${MyConstant().domain}${jobDesModel.urlPicture}'),
        radius: 80,
      ),
    );
  }

  Widget _nameCompany() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        jobDesModel.nameJob,
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            // color: Colors.blue[900],
            color: MyStyle().minimal1,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(right: 4, left: 4, top: 5),
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[100], width: 2),
          boxShadow: [
            BoxShadow(
              offset: Offset(10, 12),
              blurRadius: 15,
              spreadRadius: -12,
              color: Colors.grey,
            )
          ],
          // color: MyStyle().minimal4,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 15, left: 13),
            child: Text(
              "Description",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: MyStyle().minimal1,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 10, left: 30),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.assignment,
                      color: Colors.green,
                      size: 20,
                    ),
                    Text(
                      ' รายละเอียด :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      jobDesModel.description,
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
                      color: Colors.orange,
                      size: 20,
                    ),
                    Text(
                      ' คุณสมบัติ   :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      jobDesModel.qualification,
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
                      Icons.category,
                      color: MyStyle().minimal1,
                      size: 20,
                    ),
                    Text(
                      ' อายุ          :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      jobDesModel.age,
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
                      color: Colors.yellow[700],
                      size: 20,
                    ),
                    Text(
                      ' ค่าตอบแทน :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      jobDesModel.salary,
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
                      Icons.access_time,
                      color: Colors.red,
                      size: 20,
                    ),
                    Text(
                      ' เริ่มงาน      :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      jobDesModel.startTime,
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '  - ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      jobDesModel.endTime,
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
                      Icons.account_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                    Text(
                      ' เพศ          :  ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      jobDesModel.id_gender,
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: Colors.pinkAccent,
                      size: 20,
                    ),
                    Text(
                      ' วันทำงาน    :    ',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      jobDesModel.workday
                          .substring(1, jobDesModel.workday.length - 1),
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(right: 4, left: 4, top: 30),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[100], width: 2),
          boxShadow: [
            BoxShadow(
              offset: Offset(10, 12),
              blurRadius: 15,
              spreadRadius: -12,
              color: Colors.grey,
            )
          ],
          // color: MyStyle().minimal4,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 15, left: 13),
            child: Text(
              "Contact",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.teal[700],
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
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
                  color: MyStyle().minimal1,
                  size: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 6),
                  child: Text(
                    jobDesModel.contact,
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

  Widget _mapIcon() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      margin: EdgeInsets.only(left: 16, top: 16),
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: Colors.red,
            size: 30.0,
          ),
          Text(
            '  Map ',
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.blue[800],
                color: MyStyle().minimal1,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _map() {
    LatLng latLng = LatLng(lat2, lng2);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16,
    );

    return Container(
      margin: EdgeInsets.only(top: 4),
      height: 280,
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[100], width: 2),
        boxShadow: [
          BoxShadow(
            offset: Offset(10, 12),
            blurRadius: 15,
            spreadRadius: -12,
            color: Colors.grey,
          )
        ],
        // color: MyStyle().minimal4,
      ),
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: mapMarker(),
      ),
    );
  }

  Set<Marker> mapMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myShop'),
        position: LatLng(lat2, lng2),
        infoWindow: InfoWindow(
          title: 'My Location',
          snippet: 'latitude = $lat2, longitude = $lng2',
        ),
      )
    ].toSet();
  }

  Future<Null> signInDialog() async {
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
              'กรุณาเข้าสู่ระบบ',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                  color: MyStyle().minimal1,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: MyStyle().minimal1,
                child: Text(
                  'ตกลง',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.grey[500],
                  child: Text(
                    'ยกเลิก',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _btnAccept() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 25),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          signInDialog();
        },
        padding: EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        // color: Colors.blue[500],

        color: MyStyle().minimal1,
        child: Text(
          'APPLY JOB',
          // 'APPLY JOB',

          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 22,
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
