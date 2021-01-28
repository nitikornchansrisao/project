import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:parttime/model/jobdes_model.dart';
import 'package:parttime/utility/style.dart';

class UserApplyJob extends StatefulWidget {
  final JobDesModel jobDesModel;
  UserApplyJob({Key key, this.jobDesModel}) : super(key: key);
  @override
  _UserApplyJobState createState() => _UserApplyJobState();
}

class _UserApplyJobState extends State<UserApplyJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 0,
        title: MyStyle().showTitle('Applied Job'),
        gradient: MyStyle().buildLinearGradient(),
      ),
    );
  }
}