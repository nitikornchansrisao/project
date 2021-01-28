import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/model/user_model.dart';
import 'package:parttime/screen/showDes/job_description.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSearch extends StatefulWidget {
  final String category1;
  final String tmpArray1;
  final String salary;
  final String dropdownGender;
  final String startTime;
  final String endTime;

  ShowSearch({
    Key key,
    this.category1,
    this.tmpArray1,
    this.salary,
    this.dropdownGender,
    this.startTime,
    this.endTime,
  }) : super(key: key);
  @override
  _ShowSearchState createState() => _ShowSearchState();
}

class _ShowSearchState extends State<ShowSearch> {
  UserModel userModel;
  List<JobDesModel> jobDesModels = List();
  List<Widget> jobCard = List();
  JobDesModel jobDesModel;

  String id_category;
  String workday;
  String salary;
  String id_gender;
  String startTime;
  String endTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id_category = widget.category1;
    workday = widget.tmpArray1;
    salary = widget.salary;
    id_gender = widget.dropdownGender;
    startTime = widget.startTime;
    endTime = widget.endTime;

    // searchAll();

    // print('id_category === $id_category');
    // print('workday === $workday');
    // print('salary === $salary');
    // print('id_gender === $id_gender');
    // print('startTime === $startTime');
    // print('endTime === $endTime');

    setState(() {
      // if (workday == '[]' &&
      //     id_gender == 'เพศ' &&
      //     salary == '' &&
      //     startTime == '' &&
      //     endTime == '') {
      //   searchCategory();
      // }
        searchCategory();
      
      // if (salary == '' &&
      //     id_gender == 'เพศ' &&
      //     startTime == '' &&
      //     endTime == '') {
      //   searchCateDay();
      // }
      // if (workday == '[]' &&
      //     id_gender == 'เพศ' &&
      //     startTime == '' &&
      //     endTime == '') {
      //   searchCateSal();
      // }
      // if (id_gender == 'เพศ' && startTime == '' && endTime == '') {
      //   searchCateDaySal();
      // }
      // if (startTime == '' && endTime == '') {
      //   searchCateDaySalGen();
      // }
      // if (endTime == '') {
      //   searchCateDaySalGenSt();
      // }
      // if (startTime == '') {
      //   searchCateDaySalGenEnd();
      // }
      // //   if (salary == '' && startTime == '' && endTime == '') {
      // //   searchCateDay();
      // // }
      // // if (startTime == '' && endTime == '') {
      // //   searchNotStartEnd();
      // // }
      // // if (salary == '') {
      // //   searchNotSalary();
      // // }
      // else {
      //   searchAll();
      // }
    });
  }

  Future<Null> readJob() async {
    String url =
        '${MyConstant().domain}/parttime/getJobDes.php?isAdd=true&id=id';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        // setState(() {
        //   jobDesModels.add(jobDesModel);
        //   jobCard.add(createCard(jobDesModel, index));
        //   index++;

        // });
      }
    });
  }

  Future<Null> searchAll() async {
    // print('id_category === $id_category');
    // print('workday === $workday');
    // print('salary === $salary');
    // print('id_gender === $id_gender');
    // print('startTime === $startTime');
    // print('endTime === $endTime');

    String url =
        '${MyConstant().domain}/parttime/Search/searchAll.php?isAdd=true&id_category=$id_category&workday=$workday&salary=$salary&id_gender=$id_gender&startTime=$startTime&endTime=$endTime';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
        });
      }
    });
  }

  Future<Null> searchCategory() async {
    String url =
        '${MyConstant().domain}/parttime/Search/searchCategory.php?isAdd=true&id_category=$id_category&workday=$workday&salary=$salary&id_gender=$id_gender&startTime=$startTime&endTime=$endTime';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
        });
      }
    });
  }

  Future<Null> searchCateDay() async {
    String url =
        '${MyConstant().domain}/parttime/Search/searchCateDay.php?isAdd=true&id_category=$id_category&workday=$workday';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
        });
      }
    });
  }

    Future<Null> searchCateSal() async {
    String url =
        '${MyConstant().domain}/parttime/Search/searchCateSal.php?isAdd=true&id_category=$id_category&salary=$salary';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
        });
      }
    });
  }






  Future<Null> searchCateDaySal() async {
    String url =
        '${MyConstant().domain}/parttime/Search/searchCateDaySal.php?isAdd=true&id_category=$id_category&workday=$workday&salary=$salary';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
        });
      }
    });
  }

  Future<Null> searchCateDaySalGen() async {
    String url =
        '${MyConstant().domain}/parttime/Search/searchCateDaySalGen.php?isAdd=true&id_category=$id_category&workday=$workday&salary=$salary&id_gender=$id_gender';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
        });
      }
    });
  }

  Future<Null> searchCateDaySalGenSt() async {
    String url =
        '${MyConstant().domain}/parttime/Search/searchCateDaySalGenSt.php?isAdd=true&id_category=$id_category&workday=$workday&salary=$salary&id_gender=$id_gender&startTime=$startTime';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
        });
      }
    });
  }

  Future<Null> searchCateDaySalGenEnd() async {
    String url =
        '${MyConstant().domain}/parttime/Search/searchCateDaySalGenEnd.php?isAdd=true&id_category=$id_category&workday=$workday&salary=$salary&id_gender=$id_gender&endTime=$endTime';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
        });
      }
    });
  }

  Future<Null> searchNotStartEnd() async {
    String url =
        '${MyConstant().domain}/parttime/Search/searchNotStartEnd.php?isAdd=true&id_category=$id_category&workday=$workday&salary=$salary&id_gender=$id_gender';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
        });
      }
    });
  }

  Future<Null> searchNotSalary() async {
    String url =
        '${MyConstant().domain}/parttime/Search/searchNotSalary.php?isAdd=true&id_category=$id_category&workday=$workday&id_gender=$id_gender&startTime=$startTime&endTime=$endTime';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 0,
        title: Text('ค้นหางาน',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(
                color: Colors.white,
                // color: MyStyle().minimal1,

                // letterSpacing: .5,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            )),
        centerTitle: true,
        gradient: MyStyle().minimalLinear(),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Column(
                    children: [
                      jobCard.length == 0
                          ? Text('ไม่มีงานที่ค้นหา')
                          : Container(
                              child: Column(
                                children: jobCard,
                              ),
                            ),
                      Column(
                        children: [
                          Text(
                            widget.category1,
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            widget.tmpArray1
                                .substring(1, widget.tmpArray1.length - 1),
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            widget.salary,
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            widget.dropdownGender,
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            widget.startTime,
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            widget.endTime,
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
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
              builder: (context) => JobDescription(
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
                    child: Expanded(
                      child: Row(
                        children: [
                          Text(
                            jobDesModel.nameJob,
                            style: kTitleStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///DETAIL
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 20),
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
                                jobDesModel.id_category,
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
                  Container(
                    margin: EdgeInsets.only(top: 45, left: 200),
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
