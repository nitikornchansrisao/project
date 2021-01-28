import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:parttime/screen/main_company.dart';
import 'package:parttime/screen/main_user.dart';
import 'package:parttime/screen/sign_up.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:parttime/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:parttime/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      // AppBar(
      //   backgroundColor: MyStyle().minimal2,
      //   title: Text('Login',
      //       style: GoogleFonts.ubuntu(
      //         textStyle: TextStyle(
      //           color: Colors.white,
      //           fontSize: 22,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       )),
      //   centerTitle: true,
      // ),
      GradientAppBar(
        elevation: 0,
        // title: MyStyle().showTitle('Sign In'),
        gradient: MyStyle().buildLinearGradientBlue(),
        // gradient: MyStyle().minimalLinear(),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  padding: EdgeInsets.only(left: 15, top: 0, right: 20),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: MyStyle().buildLinearGradientBlue(),
                    // color: MyStyle().minimal2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      SafeArea(
                        child: Stack(
                          children: <Widget>[
                            Image.asset(
                              "assets/maid.png",
                              width: 180,
                              fit: BoxFit.fitWidth,
                            ),
                            Positioned(
                              left: 150,
                              child: Text(
                                "Welcome,\nFind your Part-Time Job.",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    // letterSpacing: .5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // style: kTitleStyle.copyWith(
                                //   color: Colors.white,
                                //   fontWeight: FontWeight.bold,
                                //   fontSize: 20,
                                // ),
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30, top: 250),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        _inputUser(
                            hint: "Username", icon: Icons.account_circle),
                        SizedBox(
                          height: 10,
                        ),
                        _inputPassword(hint: "Password", icon: Icons.vpn_key),
                        SizedBox(
                          height: 20,
                        ),
                        _buildLoginBtn(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildSignInWithText(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildSignupBtn(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputUser({controller, hint, icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        onChanged: (value) => username = value.trim(),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              // color: Colors.grey,
              // letterSpacing: .5,
              // fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _inputPassword({controller, hint, icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        obscureText: true,
        onChanged: (value) => password = value.trim(),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              // color: Colors.grey,
              // letterSpacing: .5,
              // fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() => Container(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          width: double.infinity,
          child: RaisedButton(
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.all(15),
            color: Colors.white,
            child: Text(
              'LOGIN',
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.blue[900],
                  // letterSpacing: .5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // style: TextStyle(
              //   // color: Color(0xFF527DAA),
              //   color: Colors.blue,

              //   letterSpacing: 1.5,
              //   fontSize: 18.0,
              //   fontWeight: FontWeight.bold,
              //   fontFamily: 'OpenSans',
              // ),
            ),
            onPressed: () {
              if (username == null || username.isEmpty) {
                normalDialog(context, 'Please enter username');
              } else if (password == null || password.isEmpty) {
                normalDialog(context, 'Please enter password');
              } else {
                checkAuthen();
              }
            },
          ),
        ),
      );

  Future<Null> checkAuthen() async {
    String url =
        '${MyConstant().domain}/parttime/checkUser.php?isAdd=true&username=$username';
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      // อ่านภาษาไทย
      var result = json.decode(response.data);
      print('result = $result');

      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String chooseType = userModel.choosetype;
          if (chooseType == 'User') {
            routeTuService(MainUser(), userModel);
          } else if (chooseType == 'Company') {
            routeTuService(MainCompany(), userModel);
          } else {
            normalDialog(context, 'Error');
          }
        } else {
          normalDialog(context, 'Password Faild');
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTuService(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('choosetype', userModel.choosetype);
    preferences.setString('name', userModel.name);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              color: Colors.blue[900],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupBtn(context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUp()))
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
//  Path getClip(Size size){
//    Path path = new Path();
//    path.lineTo(0, size.height -20); //vertical line
//    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height - 20); //cubic curve
//    path.lineTo(size.width, 0); //vertical line
//    return path;
//    }
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 30, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
