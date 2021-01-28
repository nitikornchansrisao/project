import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/normal_dialog.dart';
import 'package:parttime/utility/style.dart';

import 'home.dart';

class EditJob extends StatefulWidget {
  final JobDesModel jobDesModel;
  EditJob({Key key, this.jobDesModel}) : super(key: key);

  @override
  _EditJobState createState() => _EditJobState();
}

class _EditJobState extends State<EditJob> {
  JobDesModel jobDesModel;
  File file;
  String nameJob,
      age,
      category,
      gender,
      startTime,
      endTime,
      description,
      qualification,
      salary,
      contact,
      urlPicture;

  double lat, lng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobDesModel = widget.jobDesModel;
    nameJob = jobDesModel.nameJob;
    description = jobDesModel.description;
    age = jobDesModel.age;
    gender = jobDesModel.id_gender;
    startTime = jobDesModel.startTime;
    endTime = jobDesModel.endTime;
    qualification = jobDesModel.qualification;
    salary = jobDesModel.salary;
    contact = jobDesModel.contact;
    urlPicture = jobDesModel.urlPicture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 0,
        title: Text('Edit Resume',
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
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  gradient: MyStyle().minimalMinimal5(),
                  // color: Colors.blue[500],
                ),
              ),
            ),
            showContent()
          ],
        ),
      ),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40),
            child: InkWell(
              child: file == null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${MyConstant().domain}${jobDesModel.urlPicture}'),
                      radius: 80,
                    )
                  : CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(file),
                    ),
              // : Image.file(file),
              onTap: () {
                _dialog();
              },
            ),
          ),
          Container(
            // padding: EdgeInsets.only( left: 10, right: 10),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            width: 400,
            height: 500,
            decoration: BoxDecoration(
              // color: Colors.white,
              color: MyStyle().minimal4,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              // border: Border.all(
              //   width: 5,
              //   // color: Colors.blue,
              //   color: MyStyle().minimal6,
              // ),
            ),
            child: Column(
              children: [
                nameShopForm(),
                descriptionForm(),
                qualificationForm(),
                ageForm(),
                salaryForm(),
                timeForm(),
                genderForm(),
                contactForm(),
              ],
            ),
          ),
          editBtn()
        ],
      ),
    );
  }

//////////editButton//////////

  Widget editBtn() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 25, bottom: 10),
      height: 60,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          confirmDialog();
        },
        padding: EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        // color: Colors.blue[500],

        color: MyStyle().minimal1,
        child: Text(
          'CONFIRM EDIT',
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
    );
  }

  Future<Null> confirmDialog() async {
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
              'ยืนยันการแก้ไข',
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
                  onPressed: () {
                    Navigator.pop(context);
                    uploadImage();
                    editJobdes();
                    Navigator.pop(context);
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

  Future<Null> editJobdes() async {
    String id_jobdescription = jobDesModel.id_jobdescription;
    String url =
        '${MyConstant().domain}/parttime/editJob.php?isAdd=true&id_jobdescription=$id_jobdescription&nameJob=$nameJob&description=$description&qualification=$qualification&age=$age&salary=$salary&startTime=$startTime&endTime=$endTime&contact=$contact&UrlPicture=$urlPicture';
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        // Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่');
      }
    });
  }

//////////editButton//////////

  Future<void> _dialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose an option",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  // color: Colors.orange[800],
                  // color: Colors.white,
                  color: MyStyle().minimal1,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                      child: Text(
                        "   Gallery",
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            // color: Colors.orange[800],
                            // color: Colors.white,
                            color: MyStyle().minimal1,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onTap: () {
                        chooseImage(ImageSource.gallery);
                        Navigator.pop(context);
                      }
                      // onTap: () => chooseImage(ImageSource.gallery),

                      ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                      child: Text(
                        "   Camera",
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            // color: Colors.orange[800],
                            // color: Colors.white,
                            color: MyStyle().minimal1,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onTap: () {
                        chooseImage(ImageSource.camera);
                        Navigator.pop(context);
                      }
                      // onTap: () => chooseImage(ImageSource.camera),
                      ),
                ],
              ),
            ),
          );
        });
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxHeight: 500.0,
        maxWidth: 500.0,
      );
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'Company$i.jpg';

    String url = '${MyConstant().domain}/parttime/saveImage.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('Response ==>> $value');
        urlPicture = '/parttime/Company/$nameImage';
        print('urlImage = $urlPicture');
        editJobdes();
      });
    } catch (e) {}
  }

  Widget nameShopForm() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30, left: 30),
          child: Text(
            "ชื่อร้าน :",
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, left: 15),
          width: 200,
          child: TextFormField(
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal2,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            onChanged: (value) => nameJob = value.trim(),
            initialValue: nameJob,
            //จาก userModel.nameShop =>> setState จากข้างบน แต่ถ้าsetState แล้วใช้ nameShop เลย
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  Widget descriptionForm() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15, left: 30),
          child: Text(
            "รายละเอียดงาน :",
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, left: 15),
          width: 200,
          child: TextFormField(
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal2,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            onChanged: (value) => description = value.trim(),
            initialValue: description,
            //จาก userModel.nameShop =>> setState จากข้างบน แต่ถ้าsetState แล้วใช้ nameShop เลย
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  Widget qualificationForm() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15, left: 30),
          child: Text(
            "คุณสมบัติ :",
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, left: 15),
          width: 200,
          child: TextFormField(
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal2,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            onChanged: (value) => qualification = value.trim(),
            initialValue: qualification,
            //จาก userModel.nameShop =>> setState จากข้างบน แต่ถ้าsetState แล้วใช้ nameShop เลย
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  Widget ageForm() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15, left: 30),
          child: Text(
            "อายุ :",
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, left: 15),
          width: 200,
          child: TextFormField(
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal2,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            onChanged: (value) => age = value.trim(),
            initialValue: age,
            //จาก userModel.nameShop =>> setState จากข้างบน แต่ถ้าsetState แล้วใช้ nameShop เลย
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  Widget salaryForm() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15, left: 30),
          child: Text(
            "ค่าตอบแทน :",
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, left: 15),
          width: 200,
          child: TextFormField(
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal2,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            onChanged: (value) => salary = value.trim(),
            initialValue: salary,
            //จาก userModel.nameShop =>> setState จากข้างบน แต่ถ้าsetState แล้วใช้ nameShop เลย
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  Widget timeForm() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, left: 30),
              child: Text(
                "เริ่มงาน :",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    // color: Colors.orange[800],
                    color: MyStyle().minimal1,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 15),
              width: 70,
              child: TextFormField(
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    // color: Colors.orange[800],
                    color: MyStyle().minimal2,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onChanged: (value) => startTime = value.trim(),
                initialValue: startTime,
                //จาก userModel.nameShop =>> setState จากข้างบน แต่ถ้าsetState แล้วใช้ nameShop เลย
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 30),
              child: Text(
                "เลิกงาน :",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    // color: Colors.orange[800],
                    color: MyStyle().minimal1,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 15),
              width: 70,
              child: TextFormField(
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    // color: Colors.orange[800],
                    color: MyStyle().minimal2,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onChanged: (value) => endTime = value.trim(),
                initialValue: endTime,
                //จาก userModel.nameShop =>> setState จากข้างบน แต่ถ้าsetState แล้วใช้ nameShop เลย
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ],
    );
  }
/////////////////////////////////gender////////////////////////

  Widget genderForm() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15, left: 30),
          child: Text(
            "เพศ :",
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, left: 15),
          width: 200,
          child: TextFormField(
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal2,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            onChanged: (value) => gender = value.trim(),
            initialValue: gender,
            //จาก userModel.nameShop =>> setState จากข้างบน แต่ถ้าsetState แล้วใช้ nameShop เลย
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  Widget contactForm() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15, left: 30),
          child: Text(
            "ข้อมูลติดต่อ :",
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, left: 15),
          width: 200,
          child: TextFormField(
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal2,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            onChanged: (value) => contact = value.trim(),
            initialValue: contact,
            //จาก userModel.nameShop =>> setState จากข้างบน แต่ถ้าsetState แล้วใช้ nameShop เลย
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }
}
