import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:parttime/utility/my_constant.dart';
import 'package:parttime/utility/normal_dialog.dart';
import 'package:parttime/utility/style.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddJob extends StatefulWidget {
  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  String nameJob,
      age,
      category,
      id_gender,
      startTime,
      endTime,
      description,
      qualification,
      salary,
      contact,
      urlPicture;

  List dataType = List();
  List dataGender = List();

  double lat, lng;

  File file;

  final _formKey = GlobalKey<FormState>();

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

    print(tmpArray1);

    tmpArray.clear();
    addJob();
  }

  String dropdownGender = 'ชาย';
  String dropdownCategory = 'ทำอาหาร';

  @override
  void initState() {
    // findLatLng();

    super.initState();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });
    print('lat = $lat , lng = $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().minimal1,
        shadowColor: Colors.transparent,
        title: Text('Add Job',
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
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: Container(
                  padding: EdgeInsets.only(left: 40, top: 60, bottom: 80),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // gradient: MyStyle().minimalLinear(),
                      color: MyStyle().minimal2,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(50))),
                  child: Text("Create Your \nPart-Time Job",
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ),

              SafeArea(
                child: Column(
                  children: <Widget>[
                    /// SHOW_PICTURE
                    Container(
                      margin: EdgeInsets.only(left: 240, top: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                child: InkWell(
                                  child: file == null
                                      ? Image.asset(
                                          'assets/market.png',
                                          width: 80,
                                        )
                                      : CircleAvatar(
                                          radius: 70,
                                          backgroundImage: FileImage(file),
                                        ),
                                  // : Image.file(file,),
                                  onTap: () {
                                    _dialog();
                                    // chooseImage(ImageSource.gallery);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///UPLOAD
                    Container(
                      margin: EdgeInsets.only(left: 236),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.cloud_upload,
                              color: Colors.white70,
                              size: 35,
                            ),
                            color: Colors.pink,
                            onPressed: () {
                              _dialog();
                            },
                          ),
                          Text(
                            "Upload Image",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///FORM
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35, top: 200),
                    padding: EdgeInsets.all(10),
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
                      children: <Widget>[
                        _inputNameJob(),
                        SizedBox(height: 10),
                        _dropDownCategory(),
                        _dropDownGender(),
                        _inputAge(),
                        _inputDescription(),
                        _inputQualification(),
                        _inputSalary(),
                        _textWorkTime(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _startTime(),
                            _endTime(),
                          ],
                        ),
                        _textWorkDate(),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  checkbox1(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        _inputContact(),
                        _textMap(),
                        // lat == null ? MyStyle().showProgress() : showMap(),
                      ],
                    ),
                  ),
                  _buildSignUpBtn(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputNameJob({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        width: 300,
        child: TextFormField(
          onChanged: (value) => nameJob = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
            ),
            labelText: 'Name Job :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropDownCategory() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 17),
            child: Text(
              "Category: ",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  // color: Colors.orange[800],
                  color: MyStyle().minimal1,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          DropdownButton<String>(
            value: dropdownCategory,
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
              color: Colors.grey,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownCategory = newValue;
              });
            },
            items: <String>[
              'ทำอาหาร',
              'พนักงานเสิร์ฟ',
              'พนักงานขาย',
              'ทำความสะอาด',
              'สต๊าฟ',
              'ติวเตอร์'
            ].map<DropdownMenuItem<String>>((String value) {
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

  Future getAllName() async {
    var response = await http.get("${MyConstant().domain}/parttime/viewAll.php",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      dataType = jsonData;
    });

    print(jsonData);
    return "success";
  }

  Widget _dropDownGender() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 17),
            child: Text(
              "Gender:",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  // color: Colors.orange[800],
                  color: MyStyle().minimal1,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
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
              color: Colors.grey,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownGender = newValue;
              });
            },
            items: <String>['ชาย', 'หญิง', 'ไม่ระบุเพศ']
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

  Widget _inputAge({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: 300,
        child: TextFormField(
          onChanged: (value) => age = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
            ),
            labelText: 'Age :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputDescription({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: 300,
        child: TextFormField(
          onChanged: (value) => description = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
            ),
            labelText: 'Description :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputQualification({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: 300,
        child: TextFormField(
          onChanged: (value) => qualification = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
            ),
            labelText: 'Qualification :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputSalary({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: 300,
        child: TextFormField(
          onChanged: (value) => salary = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
            ),
            labelText: 'Salary :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textWorkTime() {
    return Container(
      padding: EdgeInsets.only(left: 13, right: 20, top: 20, bottom: 0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.access_time,
            color: MyStyle().minimal1,
            size: 24.0,
          ),
          Text(
            "  Work Time :  ",
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _startTime({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: 100,
        child: TextFormField(
          onChanged: (value) => startTime = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
            ),
            labelText: 'Start :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _endTime({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: 100,
        child: TextFormField(
          onChanged: (value) => endTime = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
            ),
            labelText: 'End :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textWorkDate() {
    return Container(
      padding: EdgeInsets.only(left: 13, right: 20, top: 20, bottom: 10),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            color: MyStyle().minimal1,
            size: 24.0,
          ),
          Text(
            "  Work Date :  ",
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded checkbox1() {
    return Expanded(
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
    );
  }

  Widget _inputContact({controller, hint, icon}) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: 300,
        child: TextFormField(
          onChanged: (value) => contact = value.trim(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
            ),
            labelText: 'Contact :',
            labelStyle: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                // color: Colors.orange[800],
                color: MyStyle().minimal1,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textMap() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(14, 20, 5, 20),
                child: Icon(
                  Icons.location_on,
                  // color: Colors.red,
                  color: MyStyle().minimal1,
                ),
              ),
              Text(
                "Map",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(
                    // color: Colors.orange[800],
                    color: MyStyle().minimal1,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Set<Marker> mapMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myShop'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: 'My Location',
          snippet: 'latitude = $lat, longitude = $lng',
        ),
      )
    ].toSet();
  }

  Container showMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16,
    );

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 250,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: mapMarker(),
      ),
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
                print('category === $dropdownCategory');
                print('gender === $dropdownGender');

                if (nameJob == null || nameJob.isEmpty) {
                  normalDialog(context, 'Please enter Namejob');
                } else if (description == null || description.isEmpty) {
                  normalDialog(context, 'Please enter Description');
                } else if (qualification == null || qualification.isEmpty) {
                  normalDialog(context, 'Please enter Qualification');
                } else if (salary == null || salary.isEmpty) {
                  normalDialog(context, 'Please enter Salary');
                } else if (startTime == null || description.isEmpty) {
                  normalDialog(context, 'Please enter StartTime');
                } else if (endTime == null || description.isEmpty) {
                  normalDialog(context, 'Please enter EndTime');
                } else if (contact == null || contact.isEmpty) {
                  normalDialog(context, 'Please enter Contact');
                } else {
                  uploadImage();
                }
              },
              padding:
                  EdgeInsets.only(left: 30, top: 15, bottom: 15, right: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // color: Colors.blue[500],

              color: MyStyle().minimal1,
              child: Text(
                'COMFIRM',
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

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'company$i.jpg';

    String url = '${MyConstant().domain}/parttime/saveImage.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        // print('Response ==>> $value');
        urlPicture = '/parttime/Company/$nameImage';
        print('urlImage = $urlPicture');
        getCheckboxItems();

        // addResume();
      });
    } catch (e) {}
  }

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
        maxHeight: 150.0,
        maxWidth: 150.0,
      );
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Future<Null> addJob() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id_user = preferences.getString('id');

    print('tmpArray == $tmpArray1');
    print('id_category === $category');

    String url =
        '${MyConstant().domain}/parttime/addJob.php?id_user=$id_user&nameJob=$nameJob&id_category=$dropdownCategory&description=$description&qualification=$qualification&age=$age&salary=$salary&startTime=$startTime&endTime=$endTime&id_gender=$dropdownGender&contact=$contact&UrlPicture=$urlPicture&Lat=$lat&Lng=$lng&workday=$tmpArray1&id_statusFav=false';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'Cannot Register!');
      }
    } catch (e) {}
  }
}
