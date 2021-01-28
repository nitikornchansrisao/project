import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:parttime/screen/main_user.dart';
import 'package:parttime/screen/search/show_search.dart';
import 'package:parttime/screen/user_resume/add_resume.dart';
import 'package:parttime/screen/user_resume/show_resume.dart';
import 'package:parttime/utility/icons.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/normal_dialog.dart';
import 'package:parttime/utility/signout.dart';
import 'package:parttime/utility/style.dart';
import 'package:parttime/screen/Fav.dart';
import 'package:parttime/screen/user_applyJob.dart';

import '../Fav.dart';
import '../user_applyJob.dart';

class AdvanceSearchHome extends StatefulWidget {
  @override
  _AdvanceSearchHomeState createState() => _AdvanceSearchHomeState();
}

class _AdvanceSearchHomeState extends State<AdvanceSearchHome> {
  Map<String, bool> values = {
    'Sun': false,
    'Mon': false,
    'Tue': false,
    'Wed': false,
    'Thur': false,
    'Fri': false,
    'Sat': false,
  };

  var tmpArray = [];
  String tmpArray1;
  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    tmpArray1 = tmpArray.toString();

    // print(tmpArray1);

    tmpArray.clear();
    searchSubmit();
  }

  List<bool> isSelected = List.generate(6, (_) => false);

  int categoryID;

  String salary, startTime, endTime;
  String category1;
  String dropdownGender = 'เพศ';

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
            //  ClipPath(
            //     clipper: MyClipper(),
            //     child: Container(
            //       height: 230,
            //       decoration: BoxDecoration(
            //         gradient: MyStyle().minimalMinimal5(),
            //         // color: Colors.blue[500],
            //       ),
            //     ),
            //   ),
            SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.assignment,
                          color: MyStyle().minimal1,
                          size: 20,
                        ),
                        Text(
                          ' ประเภทงาน :',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                              // color: MyStyle().minimal1,
                              color: Colors.grey[800],
                              letterSpacing: .2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  category(),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.date_range,
                                color: MyStyle().minimal1,
                                size: 20,
                              ),
                              Text(
                                ' วันทำงาน :',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    // color: MyStyle().minimal1,
                                    color: Colors.grey[800],
                                    letterSpacing: .2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        workDay(),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: MyStyle().minimal1,
                                size: 20,
                              ),
                              Text(
                                ' ค่าตอบแทน :  ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              _inputSalary(),
                              Text(
                                ' บาท/ชม.',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person,
                                color: MyStyle().minimal1,
                                size: 20,
                              ),
                              Text(
                                ' เพศ :  ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              _dropDownGender(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: MyStyle().minimal1,
                                size: 20,
                              ),
                              Text(
                                ' เริ่มงาน :  ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              _inputStarttime(),
                              Text(
                                ' - ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              _inputEndtime(),
                              Text(
                                ' น.',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildSignUpBtn(context)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: showDrawer(),
    );
  }

  Widget _inputSalary({controller}) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[100],
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        onChanged: (value) => salary = value.trim(),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: 'ค่าตอบแทน',
          hintStyle: GoogleFonts.kanit(
            textStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          // prefixIcon: Icon(Icons.access_time,color: MyStyle().minimal1,),
        ),
      ),
    );
  }

  Widget _inputStarttime({controller}) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[100],
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        onChanged: (value) => startTime = value.trim(),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: '0.00',
          hintStyle: GoogleFonts.kanit(
            textStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          // prefixIcon: Icon(Icons.access_time,color: MyStyle().minimal1,),
        ),
      ),
    );
  }

  Widget _inputEndtime({controller}) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[100],
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        onChanged: (value) => endTime = value.trim(),
        // onChanged: (text) => endTime = text,

        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: '0.00',
          hintStyle: GoogleFonts.kanit(
            textStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          // prefixIcon: Icon(Icons.access_time,color: MyStyle().minimal1,),
        ),
      ),
    );
  }

  Widget _dropDownGender() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          DropdownButton<String>(
            value: dropdownGender,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: GoogleFonts.kanit(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            underline: Container(
              height: 0.5,
              color: Colors.white,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownGender = newValue;
              });
            },
            items: <String>['เพศ', 'ชาย', 'หญิง', 'ไม่จำกัดเพศ']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget category() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(children: <Widget>[
        Container(
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[100],
              // border: Border.all(width: 1 , color: Colors.grey[300]),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(6, 9)),
              ],
            ),
            margin: EdgeInsets.only(left: 22),
            child: ToggleButtons(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: 15, right: 8, left: 8, bottom: 7),
                        child: SvgPicture.asset(iconChef, width: 45)),
                    Text(
                      'Chef',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: MyStyle().minimal1,
                          letterSpacing: .2,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: 15, right: 8, left: 8, bottom: 7),
                        child: SvgPicture.asset(iconWaiter, width: 45)),
                    Text(
                      'Waiter',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: MyStyle().minimal1,
                          letterSpacing: .2,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: 15, right: 8, left: 8, bottom: 7),
                        child: SvgPicture.asset(iconClean, width: 45)),
                    Text(
                      'Cleaner',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: MyStyle().minimal1,
                          letterSpacing: .2,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: 15, right: 8, left: 8, bottom: 7),
                        child: SvgPicture.asset(iconStaff, width: 45)),
                    Text(
                      'Staff',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: MyStyle().minimal1,
                          letterSpacing: .2,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: 15, right: 8, left: 8, bottom: 7),
                        child: SvgPicture.asset(iconTutor, width: 45)),
                    Text(
                      'Tutor',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: MyStyle().minimal1,
                          letterSpacing: .2,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: 15, right: 8, left: 8, bottom: 7),
                        child: SvgPicture.asset(iconCashier, width: 45)),
                    Text(
                      'Cashier',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: MyStyle().minimal1,
                          letterSpacing: .2,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    if (i == index) {
                      isSelected[i] = !isSelected[i];

                      categoryID = i;
                    } else {
                      isSelected[i] = false;
                    }
                  }
                });
              },
              isSelected: isSelected,
              fillColor: MyStyle().minimal5,
              renderBorder: false,
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,

              // borderWidth: 1,
              // borderColor: Colors.grey,
            )),
        // Text(
        //   'CHEF',
        //   style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600),
        // ),
      ]),
    );
  }

  Widget _buildSignUpBtn(context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ///COMFIRM
          Container(
            // margin: EdgeInsets.only(left: 20),
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {
                setState(() {
                  if (categoryID == 0) {
                    category1 = 'ทำอาหาร';
                  }
                  if (categoryID == 1) {
                    category1 = 'พนักงานเสิร์ฟ';
                  }
                  if (categoryID == 2) {
                    category1 = 'ทำความสะอาด';
                  }
                  if (categoryID == 3) {
                    category1 = 'สต๊าฟ';
                  }
                  if (categoryID == 4) {
                    category1 = 'ติวเตอร์';
                  }
                  if (categoryID == 5) {
                    category1 = 'พนักงานขาย';
                  }

                  getCheckboxItems();
                });
              },
              padding:
                  EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // color: Colors.blue[500],

              color: MyStyle().minimal1,
              child: Text(
                'SEARCH',
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
    );
  }

  Future<Null> searchSubmit() async {
    // if (tmpArray1 == '[]') {
    //   // tmpArray1.substring(1, tmpArray1.length - 1);
    //   tmpArray1 = '';
    //   tmpArray1.toString();
    // }
    if (category1 == null) {
      category1 = 'ทำอาหาร';
    }
    if (salary == null) {
      salary = '';
    }
    if (startTime == null) {
      startTime = '';
    }
    if (endTime == null) {
      endTime = '';
    }

    // print('category === $category1');
    // print('work day === $tmpArray1');
    // print('salary === $salary บาท/ชม.');
    // print('gender === $dropdownGender');
    // print('startTime === $startTime - $endTime น.');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowSearch(
                  category1: category1,
                  tmpArray1: tmpArray1,
                  salary: salary,
                  dropdownGender: dropdownGender,
                  startTime: startTime,
                  endTime: endTime,
                )));
  }

  Widget workDay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: values.keys.map((String key) {
              return Container(
                //  alignment: Alignment.center,
                width: 40,
                child: Column(
                  children: [
                    Text(
                      key,
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          // color: Colors.orange[800],
                          color: MyStyle().minimal1,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: MyStyle().minimal1,
                      value: values[key],
                      onChanged: (bool value) {
                        setState(() {
                          values[key] = value;
                        });
                      },
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            headerDrawer(),
            home(),
            resume(),
            favApply(),
            // createResume(),
            signOutMenu(),
          ],
        ),
      );

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
      subtitle: Text(
        'หน้าหลัก',
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
            MaterialPageRoute(builder: (value) => MainUser());
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
                // child: resumeModel == null
                //     ? Image.asset(
                //         'assets/user.png',
                //         width: 50,
                //       )
                //     : CircleAvatar(
                //         radius: 70,
                //         backgroundImage: NetworkImage(
                //             '${MyConstant().domain}${resumeModel.urlPicture}'),
                //       ),
                ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          // color: MyStyle().a,
          // gradient: MyStyle().buildLinearGradientBlue(),
          color: MyStyle().minimal1),
      accountName: Text(
        'name',
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

  ListTile favApply() {
    return ListTile(
      leading: Icon(
        Icons.save_alt,
        color: MyStyle().minimal1,
      ),
      title: Text(
        'Apply & Favorite ',
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      subtitle: Text(
        'งานที่สมัคร & งานที่บันทึก',
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
            MaterialPageRoute(builder: (value) => FavAndApply());
        Navigator.push(context, route);
      },
    );
  }

  ListTile jobApplied() {
    return ListTile(
      leading: Icon(Icons.people),
      title: Text(
        'Job Applied',
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      subtitle: Text(
        'งานที่สมัครไว้',
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
            MaterialPageRoute(builder: (value) => UserApplyJob());
        Navigator.push(context, route);
      },
    );
  }

  ListTile createResume() {
    return ListTile(
      leading: Icon(
        Icons.person,
        color: MyStyle().minimal1,
      ),
      title: Text(
        'Add Resume',
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      subtitle: Text(
        'สร้างโปรไฟล์',
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
            MaterialPageRoute(builder: (value) => AddResume());
        Navigator.push(context, route);
      },
    );
  }

  ListTile resume() {
    return ListTile(
      leading: Icon(
        Icons.person,
        color: MyStyle().minimal1,
      ),
      title: Text(
        'My Resume',
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      subtitle: Text(
        'โปรไฟล์สมัครงาน',
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
            MaterialPageRoute(builder: (value) => MyResume());
        Navigator.push(context, route);
      },
    );
  }
}

class catagory extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  const catagory({
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
          margin: EdgeInsets.only(top: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.green,
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
            margin: EdgeInsets.only(top: 12),
            child: Text(
              title,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: MyStyle().minimal1,
                  // color: Colors.indigo[600],
                  // color: Colors.teal[800],

                  // color: Colors.black,
                  letterSpacing: .5,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            )),
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
