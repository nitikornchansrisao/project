import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/model/resume_model.dart';
import 'package:parttime/model/status_model.dart';
import 'package:parttime/model/user_model.dart';

import 'package:parttime/screen/edit_job.dart';
import 'package:parttime/screen/main_company.dart';
import 'package:parttime/screen/sign_in.dart';
import 'package:parttime/screen/user_resume/add_resume.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';

import 'package:flutter/material.dart';
import 'package:parttime/utility/signout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../add_info.dart';

class ApplyResume extends StatefulWidget {
  final ResumeModel resumeModel;
  final StatusModel statusModel;
  ApplyResume({Key key, this.resumeModel, this.statusModel}) : super(key: key);

  @override
  _ApplyResumeState createState() => _ApplyResumeState();
}

class _ApplyResumeState extends State<ApplyResume> {
  ResumeModel resumeModel;
  StatusModel statusModel;
  JobDesModel jobDesModel;
  // List<ResumeModel> resumeModels = List();
  // List<Widget> resumeCard = List();

  @override
  void initState() {
    super.initState();
    resumeModel = widget.resumeModel;
    statusModel = widget.statusModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 0,
        title: Text('${resumeModel.firstname} ${resumeModel.lastname}',
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
          Row(
            children: [
              _btnCancle(),
              _btnAccept(),
            ],
          ),
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
                padding: EdgeInsets.only(top: 15, left: 20),
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
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top:5,left: 30),
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
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          applyJob();

          // print('status ==== ${resumeModel.status}');
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => EditResume()));
        },
        padding: EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        // color: Colors.blue[500],

        color: MyStyle().minimal1,
        child: Text(
          'ACCEPT',
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

  Future<Null> applyJob() async {
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
              'ยืนยันการสมัครงาน',
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    editApplyJob();
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: MyStyle().minimal1,
                  child: Text(
                    'ยืนยัน',
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

  Future<Null> editApplyJob() async {
    String id_apply = statusModel.id_apply, status = statusModel.status;
    print('id_apply === $id_apply');
    print('status === $status');

    String url =
        '${MyConstant().domain}/parttime/companyApplyJob.php?isAdd=true&id_apply=$id_apply&status=1';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      }
    } catch (e) {}
  }

  Widget _btnCancle() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 25),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          cancleJob();

          // print('status ==== ${resumeModel.status}');
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => EditResume()));
        },
        padding: EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        // color: Colors.blue[500],

        color: Colors.red[400],
        child: Text(
          'DISMISS',
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

  Future<Null> cancleJob() async {
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
              'ต้องการปฏิเสธการสมัครงาน',
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    editCancleJob();
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.red,
                  child: Text(
                    'ยืนยัน',
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

  Future<Null> editCancleJob() async {
    String id_apply = statusModel.id_apply, status = statusModel.status;

    String url =
        '${MyConstant().domain}/parttime/companyApplyJob.php?isAdd=true&id_apply=$id_apply&status=2';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      }
    } catch (e) {}
  }
}
