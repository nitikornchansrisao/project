import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/model/user_model.dart';
import 'package:parttime/screen/searchbar.dart';
import 'package:parttime/screen/showDes/home_jobdes.dart';
import 'package:parttime/screen/showDes/user_jobdes.dart';
import 'package:parttime/screen/sign_in.dart';
import 'package:parttime/screen/sign_up.dart';
import 'package:parttime/utility/icons.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/normal_dialog.dart';
import 'package:parttime/utility/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'category/category_cashier.dart';
import 'category/category_chef.dart';
import 'category/category_cleaner.dart';
import 'category/category_staff.dart';
import 'category/category_tutor.dart';
import 'category/category_waiter.dart';
import 'main_company.dart';
import 'main_user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<JobDesModel> jobDesModels = List();

  List<Widget> jobCard = List();

  GlobalKey _globalKey = GlobalKey();
  int _page = 0;
  final refreshKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreference();
    readJob();
  }

///////Loginตลอดเวลา/////////

  Future<Null> checkPreference() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String chooseType = preferences.getString('choosetype');
      if (chooseType != null && chooseType.isNotEmpty) {
        if (chooseType == 'User') {
          routeToService(MainUser());
        } else if (chooseType == 'Company') {
          routeToService(MainCompany());
        } else {
          normalDialog(context, 'Error User Type');
        }
      }
    } catch (e) {}
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

///////Loginตลอดเวลา//////////

  Future<Null> readJob() async {
    String url =
        '${MyConstant().domain}/parttime/getJobDes.php?isAdd=true&id=id';
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
      }
    });
  }

  Widget createCard(JobDesModel jobDesModel, int index) {
    return Container(
      width: 130,
      margin: EdgeInsets.only(left: 5),
      height: 200,
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Colors.transparent,
        // color: MyStyle().minimal4,
        // gradient: MyStyle().buildLinearGradientNewjob(),

        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(8, 12),
        //     blurRadius: 16,
        //     spreadRadius: -19,
        //     color: Colors.black,
        //   )
        // ],
        border: Border.all(
          color: Colors.grey[350],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print('index ==== $index');
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => HomeJobDescription(
                jobDesModel: jobDesModels[index],
              ),
            );
            Navigator.push(context, route);
          },
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: <Widget>[
              MyStyle().mySizeBox(),
              Text(
                jobDesModel.nameJob,
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    // color: Colors.blue[900],
                    color: MyStyle().minimal1,

                    // letterSpacing: .5,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              // MyStyle().mySizeBox(),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${MyConstant().domain}${jobDesModel.urlPicture}'),
                  radius: 45,
                ),
              ),

              MyStyle().mySizeBoxIm(),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: MyStyle().minimal2,
                      size: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                    ),
                    Text(
                      jobDesModel.id_gender,
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          // color: Colors.blue[900],
                          color: MyStyle().minimal1,

                          letterSpacing: .5,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.category,
                      color: MyStyle().minimal1,
                      size: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                    ),
                    Text(
                      jobDesModel.id_category,
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          // color: Colors.blue[900],
                          color: MyStyle().minimal1,

                          letterSpacing: .5,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          children: <Widget>[
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
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: SearchBar(
                        onChanged: (value) {},
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 40, right: 40),
                      padding: const EdgeInsets.all(5.0),
                      height: 220,
                      decoration: BoxDecoration(
                          // color: Colors.black,
                          color: MyStyle().minimal4,

                          // gradient: MyStyle().buildLinearGradientWhite(),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.05),
                                // color: Colors.grey[400],
                                blurRadius: 8,
                                spreadRadius: 3,
                                offset: Offset(6, 10)),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          padding: const EdgeInsets.all(10),
                          children: <Widget>[
                            catagoryCard(
                              title: 'CHEF',
                              svgSrc: iconChef,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChefCategory()));
                              },
                            ),
                            catagoryCard(
                              title: 'WAITER',
                              svgSrc: iconWaiter,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WaiterCategory()));
                              },
                            ),
                            catagoryCard(
                              title: 'CASHIER',
                              svgSrc: iconCashier,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CashierCategory()));
                              },
                            ),
                            catagoryCard(
                              title: 'CLEANER',
                              svgSrc: iconClean,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CleanerCategory()));
                              },
                            ),
                            catagoryCard(
                              title: 'STAFF',
                              svgSrc: iconStaff,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StaffCategory()));
                              },
                            ),
                            catagoryCard(
                              title: 'TUTOR',
                              svgSrc: iconTutor,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TutorCategory()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 10),
                      alignment: Alignment.topLeft,
                      child: Text('NEW JOBS',
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              // color: Colors.blue,
                              color: MyStyle().minimal1,
                              letterSpacing: .5,
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                      // color: MyStyle().minimal1,
                    ),
                    jobCard.length == 0
                        ? MyStyle().showProgress()
                        : Container(
                            width: 390,
                            height: 200,
                            margin: EdgeInsets.only(top: 15),

                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: jobCard,
                                );
                              },
                            ),
                            // child: ListView(
                            //   scrollDirection: Axis.horizontal,
                            //   children: jobCard,
                            // ),
                          ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 25, left: 10),
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     'URGENT JOBS',
                    //     style: GoogleFonts.ubuntu(
                    //       textStyle: TextStyle(
                    //         // color: Colors.blue,
                    //         color: MyStyle().minimal1,

                    //         letterSpacing: .5,
                    //         fontSize: 17,
                    //         fontWeight: FontWeight.w900,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 15, bottom: 15),
                    //   child: Column(
                    //     children: <Widget>[
                    //       Container(
                    //         height: 100,
                    //         child: ListView(
                    //           scrollDirection: Axis.horizontal,
                    //           children: <Widget>[
                    //             urgentJob(),
                    //             urgentJob(),
                    //             urgentJob(),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: showDrawer(),
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
    );
  }

//////////////////////////////////////Drawer/////////////////////////////////

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            headerDrawer(),
            home(),
            signInMenu(),
            signUpMenu(),
          ],
        ),
      );

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(
        Icons.person,
        color: MyStyle().minimal1,
      ),
      title: Text(
        'Sign In',
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);

        // MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext buildContext){
        //   return SignIn();
        // });
        // Navigator.of(context).push(materialPageRoute).then((value) {
        //     setState(() {
        //       print('Set State Work');
        //     });
        // });
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
      leading: Icon(
        Icons.group_add,
        color: MyStyle().minimal1,
      ),
      title: Text(
        'Sign Up',
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignUp());
        Navigator.push(context, route);
      },
    );
  }

  ListTile home() {
    return ListTile(
      leading: Icon(
        Icons.home,
        color: MyStyle().minimal1,
      ),
      title: Text(
        'Home',
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // subtitle: Text(
      //   'หน้าหลัก',
      //   style: GoogleFonts.kanit(
      //     textStyle: TextStyle(
      //       color: Colors.grey[600],
      //       fontSize: 14,
      //       // fontWeight: FontWeight.w500,
      //     ),
      //   ),
      // ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Home());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader headerDrawer() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -20,
              color: Colors.black,
            )
          ],
        ),
        child: Container(
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            child: InkWell(
                child: Image.asset(
              'assets/user.png',
              width: 50,
            )),
          ),
        ),
      ),
      decoration: BoxDecoration(
          // color: MyStyle().a,
          // gradient: MyStyle().buildLinearGradientBlue(),
          color: MyStyle().minimal1),
      accountName: Text(
        'Name',
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      accountEmail: Text(
        'Select your Part-Time Jobs',
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
//////////////////////////////////////Drawer/////////////////////////////////

}

class urgentJob extends StatelessWidget {
  const urgentJob({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(8, 10),
            blurRadius: 15,
            spreadRadius: -22,
            color: Colors.black,
          )
        ],
        border: Border.all(
          color: Colors.grey[350],
        ),
      ),
    );
  }
}

class newJob extends StatelessWidget {
  final Function press;
  const newJob({
    Key key,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        // margin: EdgeInsets.only(top: 5),
        width: 120,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: Offset(8, 10),
              blurRadius: 15,
              spreadRadius: -22,
              color: Colors.black,
            )
          ],
          border: Border.all(
            color: Colors.grey[350],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: press,
            child: Column(
              children: <Widget>[
                MyStyle().mySizeBox(),
                Text(
                  'Job Name',
                  style: kTitleStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: MyStyle().a,
                  ),
                ),
                MyStyle().mySizeBox(),
                SvgPicture.asset(
                  logoMarket,
                  width: 70,
                ),
                MyStyle().mySizeBox(),
                Text(
                  'Description\nasdasdasd',
                  style: kTitleStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class catagoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  const catagoryCard({
    Key key,
    this.svgSrc,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            // border : Border.all(width: 2,color: Colors.blue),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: Offset(5, 8)),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: press,
              child: Column(
                children: <Widget>[
                  MyStyle().mySizeBoxIm(),
                  SvgPicture.asset(
                    svgSrc,
                    width: 46,
                  )
                ],
              ),
            ),
          ),
        ),
        // MyStyle().mySizeBoxText(),
        Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(title,
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    color: Colors.blue[900],
                    // color: Colors.grey[600],
                    // letterSpacing: .5,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ))),
      ],
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
