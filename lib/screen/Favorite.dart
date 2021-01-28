import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttime/model/favorite_model.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/model/resume_model.dart';
import 'package:parttime/model/user_model.dart';
import 'package:parttime/screen/showDes/apply_jobdes.dart';
import 'package:parttime/screen/showDes/user_jobdes.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<JobDesModel> jobDesModels = List();
  List<Widget> jobCard = List();
  ResumeModel resumeModel;
  UserModel userModel;
  FavoriteModel favoriteModel;
  String id_resume, status;

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
      // print('value === $value');

      var result = json.decode(value.data);

      for (var map in result) {
        setState(() {
          resumeModel = ResumeModel.fromJson(map);
          readJob();
        });
      }
    });
  }

  Future<Null> readJob() async {
    String id_resume = resumeModel.id;
    print('id_resume ==== $id_resume');

    String url =
        '${MyConstant().domain}/parttime/getFavorite.php?isAdd=true&id_resume=$id_resume';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;
      for (var map in result) {
        FavoriteModel favoriteModel = FavoriteModel.fromJson(map);
        JobDesModel jobDesModel = JobDesModel.fromJson(map);

        print('nameJob = ${jobDesModel.nameJob}');
        print('status === ${favoriteModel.status}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(favoriteModel, jobDesModel, index));
          index++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                jobCard.length == 0
                    ? MyStyle().showProgress()
                    : Container(
                        child: Column(
                          children: jobCard,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget createCard(
      FavoriteModel favoriteModel, JobDesModel jobDesModel, int index) {
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
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print('index ==== $index');
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => ApplyJobDescription(
                jobDesModel: jobDesModels[index],
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
                    margin: EdgeInsets.only(top: 10, left: 10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          jobDesModel.nameJob,
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
                    margin: EdgeInsets.only(top: 55, left: 20),
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
                          '${MyConstant().domain}${jobDesModel.urlPicture}'),
                      radius: 60,
                    ),
                  ),

                  ///DETAIL
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 160),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                margin: EdgeInsets.only(left: 10),
                              ),
                              Text(
                                jobDesModel.category,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
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
                                jobDesModel.workday.substring(
                                    1, jobDesModel.workday.length - 1),
                                style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.deepOrange,
                                size: 22,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                              ),
                              Text(
                                jobDesModel.startTime,
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                " - ",
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                jobDesModel.endTime,
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.monetization_on,
                                color: Colors.amber,
                                size: 22,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                              ),
                              Text(
                                jobDesModel.salary,
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                " / Hr.",
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
}
