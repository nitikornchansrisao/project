import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/model/user_model.dart';
import 'package:parttime/screen/company/addJob.dart';
import 'package:parttime/screen/edit_job.dart';
import 'package:parttime/screen/searchbar.dart';
import 'package:parttime/screen/showDes/job_description.dart';
import 'package:parttime/utility/icons.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/signout.dart';
import 'package:parttime/utility/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_info.dart';
import 'home.dart';

class MainCompany extends StatefulWidget {
  @override
  _MainCompanyState createState() => _MainCompanyState();
}

class _MainCompanyState extends State<MainCompany> {
  List<JobDesModel> jobDesModels = List();
  List<Widget> jobCard = List();

  GlobalKey _globalKey = GlobalKey();
  int _page = 0;
  UserModel userModel;
  final refreshKey = GlobalKey<ScaffoldState>();

  List<List<String>> listDay = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readUser();
    readJob();
  }

  Future<Null> readUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    // print('idddd ==== $id');

    String url =
        '${MyConstant().domain}/parttime/getUser.php?isAdd=true&id=$id';
    await Dio().get(url).then((value) {
      print('value === $value');

      var result = json.decode(value.data);

      for (var map in result) {
        setState(() {
          userModel = UserModel.fromJson(map);
          // print('name ==== ${userModel.name}');
        });
      }
    });
  }

  Future<Null> readJob() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id_user = preferences.getString('id');
    print('id_user =====>>> $id_user');

    String url =
        '${MyConstant().domain}/parttime/getJobHome.php?isAdd=true&id_user=$id_user';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      int index = 0;

      for (var map in result) {
        JobDesModel jobDesModel = JobDesModel.fromJson(map);
        print('object = ${jobDesModel.nameJob}');
        // List<String> day = changArray(jobDesModel.workday);
        // print('day = $day');

        setState(() {
          jobDesModels.add(jobDesModel);
          jobCard.add(createCard(jobDesModel, index));
          index++;
          // listDay.add(day);
        });
      }
    });
  }

  Future<Null> deleteJob(JobDesModel jobDesModel) async {
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
              'คุณต้องการลบงาน \n ${jobDesModel.nameJob} ?',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(
                  // color: Colors.blue[800],
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
                  onPressed: () async {
                    print('id ==== ${jobDesModel.id_jobdescription}');
                    Navigator.pop(context);
                    String url =
                        '${MyConstant().domain}/parttime/deleteJob.php?isAdd=true&id_jobdescription=${jobDesModel.id_jobdescription}';
                    await Dio().get(url).then((value) => readJob());
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // color: Colors.blue,
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

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
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
      // backgroundColor: Colors.grey[200],
      drawer: showDrawer(),
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
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    _search(),
                    jobCard.length == 0
                        ? addCard()
                        : Container(
                            child: Column(
                              children: jobCard,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   index: 0,
      //   key: _globalKey,
      //   height: 58,
      //   color: Colors.blue[500],
      //   buttonBackgroundColor: Colors.blue[500],
      //   backgroundColor: Colors.blue[100],
      //   animationCurve: Curves.easeOutBack,
      //   animationDuration: Duration(seconds: 1),
      //   onTap: (index) {
      //     setState(() {
      //       _page = index;
      //     });
      //   },
      //   items: <Widget>[
      //     Icon(
      //       Icons.search,
      //       size: 28,
      //       color: Colors.white,
      //     ),
      //     Icon(
      //       Icons.favorite,
      //       size: 28,
      //       color: Colors.white,
      //     ),
      //     Icon(
      //       Icons.home,
      //       size: 28,
      //       color: Colors.white,
      //     ),
      //     Icon(
      //       Icons.category,
      //       size: 28,
      //       color: Colors.white,
      //     ),
      //     Icon(
      //       Icons.person,
      //       size: 28,
      //       color: Colors.white,
      //     ),
      //   ],
      // ),
    );
    return scaffold;
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
              builder: (context) => AddJob(),
            );
            Navigator.push(context, route);
          },
          borderRadius: BorderRadius.circular(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add Your Job',
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
                  Container(
                    margin: EdgeInsets.only(left: 280),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: MyStyle().minimal1,
                        // color: MyStyle().minimal6,
                      ),
                      onPressed: () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => EditJob(
                            jobDesModel: jobDesModels[index],
                          ),
                        );
                        Navigator.push(context, route);
                        // .then((value) => readJob());
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 310),
                    child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          // color: Colors.grey[600],
                          color: Colors.grey,
                        ),
                        onPressed: () => deleteJob(
                              jobDesModels[index],
                            )),
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

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            headerDrawer(),
            homeJob(),
            // descriptionMenu(),
            addJobMenu(),
            signOutMenu(),
          ],
        ),
      );

  ListTile homeJob() => ListTile(
        leading: Icon(
          Icons.home,
          color: MyStyle().minimal1,
        ),
        title: Text(
          'Part-Time Jobs',
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        subtitle: Text(
          'งานพาร์ทไทม์',
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              // fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => MainCompany());
          Navigator.push(context, route);
        },
      );

  ListTile addJobMenu() => ListTile(
        leading: Icon(
          Icons.store,
          color: MyStyle().minimal1,
        ),
        title: Text(
          'Add Part-time Job',
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        subtitle: Text(
          'เพิ่มงานพาร์ทไทม์',
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              // fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => AddJob());
          Navigator.push(context, route);
        },
      );

  ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text(
          'Sign Out',
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        subtitle: Text(
          'ออกจากระบบ',
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              // fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: () => signOutProcess(context),
      );

  UserAccountsDrawerHeader headerDrawer() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: Container(
        decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     offset: Offset(0, 17),
            //     blurRadius: 17,
            //     spreadRadius: -20,
            //     color: Colors.black,
            //   )
            // ],
            ),
        child: Container(
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            child: InkWell(
                child: Image.asset(
              'assets/market.png',
              width: 50,
            )
                // : CircleAvatar(
                //     radius: 70,
                //     backgroundImage: NetworkImage(
                //         '${MyConstant().domain}${resumeModel.urlPicture}'),
                //   ),
                ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          // color: MyStyle().a,
          // gradient: MyStyle().buildLinearGradientBlue(),
          color: MyStyle().minimal1),
      accountName: Text(
        userModel.name,
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      accountEmail: Text(
        'Add your Part-Time Jobs',
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            // fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
