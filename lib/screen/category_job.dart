import 'package:flutter/material.dart';
import 'package:parttime/model/category_model.dart';
import 'package:parttime/model/jobdes_model.dart';

class CategoryJob extends StatefulWidget {
  final CategoryModel categoryModel;
  CategoryJob({Key key, this.categoryModel}) : super(key: key);
  @override
  _CategoryJobState createState() => _CategoryJobState();
}

class _CategoryJobState extends State<CategoryJob> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(''),
    );
  }
}
