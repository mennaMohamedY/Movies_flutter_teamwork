import 'package:flutter/material.dart';
import 'package:movies_app/Themes.dart';

class SearchBarr extends StatefulWidget {
  Function OnQueryChanged;

  SearchBarr({required this.OnQueryChanged});

  @override
  State<SearchBarr> createState() => _SearchBarrState();
}

class _SearchBarrState extends State<SearchBarr> {
  String query = '';

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
      widget.OnQueryChanged(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(11),
      child: TextField(
        style: TextStyle(color: Colors.white),
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          fillColor: MyTheme.sectionsGrey,
          filled: true,
          labelText: 'Search Category here',
          focusColor: Colors.white70,
          labelStyle: TextStyle(color: MyTheme.whiteColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: MyTheme.bordersColor)),
          prefixIcon: Icon(
            Icons.search,
            color: MyTheme.whiteColor,
          ),
        ),
      ),
    );
  }
}
