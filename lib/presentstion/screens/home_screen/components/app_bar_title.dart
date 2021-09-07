import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

class AppBarTitle extends StatelessWidget {
  bool isSearching;
  final ValueChanged<String>? onChanged;
  AppBarTitle({required this.isSearching, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return isSearching
        ? TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          )
        : Text(
            "EgyNews",
            style: TextStyle(
                color: MyColors.myGreen,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          );
  }
}
