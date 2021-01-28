import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/model/resume_model.dart';
import 'package:parttime/model/status_model.dart';
import 'package:parttime/screen/company/show_resumeApply.dart';
import 'package:parttime/screen/user_resume/show_resume.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../searchbar.dart';

class ApplyCompany extends StatefulWidget {
  final JobDesModel jobDesModel;
  ApplyCompany({Key key, this.jobDesModel}) : super(key: key);
  @override
  _ApplyCompanyState createState() => _ApplyCompanyState();
}

class _ApplyCompanyState extends State<ApplyCompany> {
  ResumeModel resumeModel;
  List<ResumeModel> resumeModels = List();
  List<StatusModel> statusModels = List();
  List<Widget> resumeCard = List();

  JobDesModel jobDesModel;
  StatusModel statusModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobDesModel = widget.jobDesModel;
    readUser();
  }

  Future<Null> readUser() async {
    String id_jobdescription = jobDesModel.id_jobdescription;
    // print('id_jobdescription ==== $id_jobdescription');
    String url =
        '${MyConstant().domain}/parttime/getUserApply.php?isAdd=true&id_jobdescription=$id_jobdescription';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;
      for (var map in result) {
        resumeModel = ResumeModel.fromJson(map);
        statusModel = StatusModel.fromJson(map);
        // String nameJob = jobDesModel.nameJob;
        print('id_jobdescription = ${jobDesModel.id_jobdescription}');
        print('id_resume = ${resumeModel.id}');
        print('status = ${statusModel.status}');

        setState(() {
          resumeModels.add(resumeModel);
          statusModels.add(statusModel);
          resumeCard.add(createCard(statusModel, resumeModel, index));
          index++;
        });

        //   if (nameJob.isEmpty) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 0,
        title: Text('${jobDesModel.nameJob}',
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
        child: Stack(children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 230,
              decoration: BoxDecoration(
                gradient: MyStyle().minimalMinimal5(),
                // color: Colors.blue[500],
              ),
            ),
          ),
          Column(
            children: [
              _search(),
              Container(
                margin: EdgeInsets.only( top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'รายชื่อคนสมัครงาน',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: Colors.teal[900],
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              resumeCard.length == 0
                  ? Text('ยังไม่มีคนสมัครงาน')
                  : Container(
                      child: Column(
                        children: resumeCard,
                      ),
                    ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget createCard(
      StatusModel statusModel, ResumeModel resumeModel, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 5),
      // width: 190,
      height: 200,

      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(10, 12),
            blurRadius: 15,
            spreadRadius: -17,
            color: Colors.black,
          )
        ],
        border: Border.all(
          color: Colors.grey[200],
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => ApplyResume(
                resumeModel: resumeModel,
                statusModel: statusModel,

                // jobDesModel: jobDesModel,
              ),
            );
            Navigator.push(context, route);
          },
          borderRadius: BorderRadius.circular(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16, left: 15),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          resumeModel.firstname,
                          style: kTitleStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                            // color: MyStyle().minimal1,
                          ),
                        ),
                        Text('  '),
                        Text(
                          resumeModel.lastname,
                          style: kTitleStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                            // color: MyStyle().minimal1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 45, left: 240),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(6, 15),
                          blurRadius: 15,
                          spreadRadius: -17,
                          color: Colors.grey[300],
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${MyConstant().domain}${resumeModel.urlPicture}'),
                      radius: 60,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 280, top: 10),
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        statusModel.status == '0'
                            ? Icon(Icons.access_time,
                                color: Colors.grey, size: 27)
                            : statusModel.status == '1'
                                ? Icon(Icons.check,
                                    color: Colors.green, size: 30)
                                : Icon(Icons.close,
                                    color: Colors.red, size: 30),
                        statusModel.status == '0'
                            ? Text(
                                ' Waiting',
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    // color: Colors.orange[800],
                                    color: Colors.grey,
                                    // color: MyStyle().minimal1,

                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : statusModel.status == '1'
                                ? Text('Applied',
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        // color: Colors.orange[800],
                                        color: Colors.green,
                                        // color: MyStyle().minimal1,

                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ))
                                : Text('Cancle',
                                    style: GoogleFonts.ubuntu(
                                      textStyle: TextStyle(
                                        // color: Colors.orange[800],
                                        color: Colors.red,
                                        // color: MyStyle().minimal1,

                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                      ],
                    ),
                  ),

                  ///DETAIL
                  Container(
                    margin: EdgeInsets.only(top: 70, left: 35),
                    // padding: EdgeInsets.all(10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.category,
                              color: Colors.green,
                              size: 22,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                            ),
                            Text(
                              'เพศ : ${resumeModel.gender}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Kanit',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                // color: Colors.pinkAccent,
                                color: MyStyle().minimal1,
                                size: 22,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                              ),
                              Text(
                                'อายุ : ${resumeModel.age}  ปี',
                                style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: Colors.yellow[800],
                                size: 22,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                              ),
                              Text(
                                'ติดต่อ : ${resumeModel.contact}',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

 Widget _search() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          SearchBar(),
        ],
      ),
    );
  }
}
