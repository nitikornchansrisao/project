import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/screen/searchbar.dart';
import 'package:parttime/screen/showDes/user_jobdes.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CleanerCategoryUser extends StatefulWidget {
  @override
  _CleanerCategoryState createState() => _CleanerCategoryState();
}

class _CleanerCategoryState extends State<CleanerCategoryUser> {
  List<JobDesModel> jobDesModels = List();
  List<Widget> jobCard = List();
  GlobalKey _globalKey = GlobalKey();
  int _page = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJob();
  }

  Future<Null> readJob() async {
    String url =
        '${MyConstant().domain}/parttime/Category/getCategory.php?isAdd=true&category=ทำความสะอาด';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;
      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        // String nameJob = jobDesModel.nameJob;
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
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
        title: Text('Cleaner',
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
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        key: _globalKey,
        height: 58,
        // color: Colors.blue[500],
        color: MyStyle().minimal2,
        buttonBackgroundColor: MyStyle().minimal2,
        backgroundColor: MyStyle().minimal4,
        animationCurve: Curves.easeOutBack,
        animationDuration: Duration(seconds: 1),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        items: <Widget>[
          Icon(
            Icons.search,
            size: 28,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            size: 28,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            size: 28,
            color: Colors.white,
          ),
          Icon(
            Icons.category,
            size: 28,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 28,
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.only(left: 40, top: 20),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     // gradient: MyStyle().buildLinearGradientBlue(),
            //   ),
            //   child: Text(
            //     "CLEANER",
            //     style: GoogleFonts.ubuntu(
            //       textStyle: TextStyle(
            //         color: Colors.blue[900],
            //         // letterSpacing: .5,
            //         fontSize: 22,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            _search(),
            Column(
              children: [
                jobCard.length == 0
                    ? Container(
                        margin: EdgeInsets.only(top: 200),
                        child: Text('ยังไม่มีประกาศรับสมัครงาน',
                            style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                // color: Colors.white,
                                color: MyStyle().minimal1,

                                // letterSpacing: .5,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
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

  Widget createCard(JobDesModel jobDesModel, int index) {
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
              builder: (context) => UserJobDescription(
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
                                "วันที่ทำงาน",
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
