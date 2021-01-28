import 'package:parttime/utility/style.dart';
import 'package:flutter/material.dart';


class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBar({
    Key key, this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 5,left: 40,right: 40),
      height: 40,
      padding: EdgeInsets.only(top: 0,left: 15),
      // padding: EdgeInsets.symmetric(horizontal: 25,vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.grey[300],
        ),
      
      ),

      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: IconButton(icon: Icon(Icons.search), onPressed: (){}),
          hintText: "Search Here",
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),

    );

  }


}