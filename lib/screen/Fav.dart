import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parttime/model/resume_model.dart';
import 'package:parttime/screen/user_applyJob.dart';
import 'package:parttime/screen/user_resume/add_resume.dart';
import 'package:parttime/screen/user_resume/show_resume.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/signout.dart';
import 'package:parttime/utility/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Favorite.dart' as one;
import 'Apply.dart' as two;
import 'main_user.dart';

class FavAndApply extends StatefulWidget {
  @override
  _FavAndApplyState createState() => _FavAndApplyState();
}

class _FavAndApplyState extends State<FavAndApply> {
  ResumeModel resumeModel;

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // drawer: showDrawer(),
        appBar: AppBar(
          title: Text('Part-Time Jobs',
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )),
          centerTitle: true,
          backgroundColor: MyStyle().minimal1,
          bottom: TabBar(tabs: <Tab>[
            Tab(
              text: 'Favorite',
              icon: Icon(Icons.favorite),
            ),
            Tab(
              text: 'Apply',
              icon: Icon(Icons.check),
            )
          ]),
        ),
        body: new TabBarView(
          children: <Widget>[
            one.Favorite(),
            two.ApplyJob(),
          ],
        ),
      ),
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
              child: resumeModel == null
                  ? Image.asset(
                      'assets/user.png',
                      width: 50,
                    )
                  : CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          '${MyConstant().domain}${resumeModel.urlPicture}'),
                    ),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          // color: MyStyle().a,
          // gradient: MyStyle().buildLinearGradientBlue(),
          color: MyStyle().minimal1),
      accountName: Text(
        'Username',
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
