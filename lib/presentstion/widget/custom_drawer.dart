import 'package:flutter/material.dart';
import '../../size_cofig.dart';
import '../../constants.dart';

import '../../data/models/tile.dart';
import '../screens/saved_articles_screen/saved_article_screen.dart';
import '../screens/select_country_screen/select_country_screen.dart';
import 'custom_tile.dart';

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
    Tile(title: "Select Country", icon: Icons.flag),
  ];

  String selectedTitle = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 12,
          ),
          width: getProportionateScreenWidth(270),
          color: Color(0xFFFFFFFF),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Center(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/oday.jpg'),
                        radius: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Oday Abdo',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(25),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
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
                      : MyColors.myGreen,
                  titleColor: selectedTitle == tiles[index].title
                      ? Colors.white
                      : MyColors.myGreen,
                  tileColor: selectedTitle == tiles[index].title
                      ? MyColors.myGreen
                      : Colors.transparent,
                  leadingIcon: tiles[index].icon,
                  onTap: () {
                    setState(() {
                      selectedTitle = tiles[index].title;
                      if (index == 0) {
                        Navigator.pushReplacementNamed(
                            context, SavedArticlesScreen.routeName);
                      }
                      if (index == 1) {
                        Navigator.pushReplacementNamed(
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
              size: getProportionateScreenWidth(40),
            ),
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
