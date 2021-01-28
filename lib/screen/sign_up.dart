import 'package:dio/dio.dart';
import 'package:parttime/screen/main_company.dart';
import 'package:parttime/screen/main_user.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/style.dart';
import 'package:flutter/material.dart';
import 'package:parttime/utility/normal_dialog.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String chooseType, name, username, password, checkpassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 0,
        // title: MyStyle().showTitle('Sign Up'),
        gradient: MyStyle().buildLinearGradient(),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  padding: EdgeInsets.only(left: 15, top: 0),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: MyStyle().buildLinearGradient(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SafeArea(
                        child: Stack(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '  Sign Up!   ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                    Text(
                                      'Create your Account',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  "assets/sign_logo.png",
                                  width: 180,
                                  fit: BoxFit.fitWidth,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 35, right: 35, top: 170),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        _buildSignUpWithText(),
                        SizedBox(
                          height: 10,
                        ),
                        _inputName(hint: "Name", icon: Icons.people),
                        SizedBox(height: 10),
                        _inputUser(
                            hint: "Username", icon: Icons.account_circle),
                        SizedBox(
                          height: 10,
                        ),
                        _inputPassword(hint: "Password", icon: Icons.vpn_key),
                        SizedBox(
                          height: 10,
                        ),
                        _inputCheckPass(
                            hint: "Confirm Password",
                            icon: Icons.verified_user),
                        SizedBox(
                          height: 18,
                        ),
                        _buildChooseTypeText(),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            userRadio(),
                            shopRadio(),
                          ],
                        ),
                        _buildSignUpBtn(context),
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

  Widget _inputName({controller, hint, icon}) {
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
        onChanged: (value) => name = value.trim(),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
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
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _inputCheckPass({controller, hint, icon}) {
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
        onChanged: (value) => checkpassword = value.trim(),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildSignUpBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          print(
              'name = $name, user = $username, password = $password, chooseType = $chooseType');
          if (name == null || name.isEmpty) {
            normalDialog(context, 'Please enter name');
          } else if (username == null || username.isEmpty) {
            normalDialog(context, 'Please enter username');
          } else if (password == null || password.isEmpty) {
            normalDialog(context, 'Please enter password');
          } else if (chooseType == null) {
            normalDialog(context, 'Please enter type');
          } else if (password != checkpassword) {
            normalDialog(context, 'Please check password');
          } else {
            checkUser();
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        // color: Color(0xFF0277BD),
        color: Colors.blue,
        child: Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Future<Null> checkUser() async {
    String url =
        '${MyConstant().domain}/parttime/checkUser.php?isAdd=true&username=$username';

    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        registerThread();
      } else {
        normalDialog(context, 'This user is "$username" \nalready used.');
      }
    } catch (e) {}
  }

  Future<Null> registerThread() async {
    String url =
        '${MyConstant().domain}/parttime/userRegister.php?name=$name&username=$username&password=$password&choosetype=$chooseType';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
        // if (chooseType.toString() == 'Company') {
        //   // MaterialPageRoute route = MaterialPageRoute(
        //   //   builder: (context) => MainCompany(),
        //   // );
        //   // Navigator.push(context, route);
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => MainCompany()));
        //   print('object');
        // }
        // if (chooseType.toString() == 'User') {
        //   // MaterialPageRoute route = MaterialPageRoute(
        //   //   builder: (context) => MainCompany(),
        //   // );
        //   // Navigator.push(context, route);
        //   print('Yesss');
        // }
      } else {
        normalDialog(context, 'Cannot Register!');
      }
    } catch (e) {}
  }

  Widget _buildSignUpWithText() {
    return Container(
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          '  Create your Account',
          style: TextStyle(
            color: Color(0xFF527DAA),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildChooseTypeText() {
    return Container(
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          '  Choose type user',
          style: TextStyle(
            color: Color(0xFF527DAA),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget userRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // width: 150,
            margin: EdgeInsets.only(left: 40),
            child: Row(children: <Widget>[
              Radio(
                value: 'User',
                groupValue: chooseType,
                onChanged: (value) {
                  setState(() {
                    chooseType = value;
                  });
                },
              ),
              Text(
                'Part-Time',
                style: TextStyle(
                    color: Colors.grey[600], fontWeight: FontWeight.w600),
              ),
            ]),
          ),
        ],
      );

  Widget shopRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // width: 250,
            margin: EdgeInsets.only(right: 50),
            child: Row(children: <Widget>[
              Radio(
                value: 'Company',
                groupValue: chooseType,
                onChanged: (value) {
                  setState(() {
                    chooseType = value;
                  });
                },
              ),
              Text(
                'Company',
                style: TextStyle(
                    color: Colors.grey[600], fontWeight: FontWeight.w600),
              ),
            ]),
          ),
        ],
      );

  // Row showAppName() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       MyStyle().showTitle('Part-Time'),
  //     ],
  //   );
  // }

}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 363.15;
    path.lineTo(
        -0.003999999999997783 * _xScaling, 341.78499999999997 * _yScaling);
    path.cubicTo(
      -0.003999999999997783 * _xScaling,
      341.78499999999997 * _yScaling,
      23.461000000000002 * _xScaling,
      363.15099999999995 * _yScaling,
      71.553 * _xScaling,
      363.15099999999995 * _yScaling,
    );
    path.cubicTo(
      119.645 * _xScaling,
      363.15099999999995 * _yScaling,
      142.21699999999998 * _xScaling,
      300.186 * _yScaling,
      203.29500000000002 * _xScaling,
      307.21 * _yScaling,
    );
    path.cubicTo(
      264.373 * _xScaling,
      314.234 * _yScaling,
      282.666 * _xScaling,
      333.47299999999996 * _yScaling,
      338.408 * _xScaling,
      333.47299999999996 * _yScaling,
    );
    path.cubicTo(
      394.15000000000003 * _xScaling,
      333.47299999999996 * _yScaling,
      413.99600000000004 * _xScaling,
      254.199 * _yScaling,
      413.99600000000004 * _xScaling,
      254.199 * _yScaling,
    );
    path.cubicTo(
      413.99600000000004 * _xScaling,
      254.199 * _yScaling,
      413.99600000000004 * _xScaling,
      0 * _yScaling,
      413.99600000000004 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      413.99600000000004 * _xScaling,
      0 * _yScaling,
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
      -0.003999999999997783 * _xScaling,
      341.78499999999997 * _yScaling,
      -0.003999999999997783 * _xScaling,
      341.78499999999997 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
