import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

import 'package:news_app/data/models/tile.dart';
import 'package:news_app/presentstion/screens/saved_articles_screen/saved_article_screen.dart';
import 'package:news_app/presentstion/screens/select_country_screen/select_country_screen.dart';
import 'package:news_app/presentstion/widget/custom_tile.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late double deviceWidth;

  late double deviceHeigth;

  bool isDrawerOpen = true;

  List<Tile> tiles = [
    Tile(title: "Bookmark", icon: Icons.bookmark_add),
    Tile(title: "Settings", icon: Icons.settings),
  ];

  String selectedTitle = "";

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeigth = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 12,
          ),
          width: deviceWidth - 150,
          color: Color(0xFFFFFFFF),
          child: Column(
            children: [
              CustomTile(
                leadingIcon: Icons.account_box_rounded,
                onTap: () {},
                title: "Oday",
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: MyColors.myGreen,
              ),
              ...List.generate(
                tiles.length,
                (index) => CustomTile(
                  leadingIconColor: selectedTitle == tiles[index].title
                      ? Colors.white
                      : Colors.black,
                  titleColor: selectedTitle == tiles[index].title
                      ? Colors.white
                      : Colors.black,
                  tileColor: selectedTitle == tiles[index].title
                      ? MyColors.myGreen
                      : Colors.transparent,
                  leadingIcon: tiles[index].icon,
                  onTap: () {
                    setState(() {
                      selectedTitle = tiles[index].title;
                      if (index == 0) {
                        Navigator.pushNamed(
                            context, SavedArticlesScreen.routeName);
                      }
                      if (index == 1) {
                        Navigator.pushNamed(
                            context, SelectCountryScreen.routeName);
                      }
                    });
                  },
                  title: tiles[index].title,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              size: 40,
            ),
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
