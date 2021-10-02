import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/presentstion/screens/home_screen/Home_Screen.dart';
import '../../../../size_cofig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../business_logic/cubit/articles_cubit.dart';
import '../../../../constants.dart';

class CategoryNavBar extends StatefulWidget {
  @override
  _CategoryNavBarState createState() => _CategoryNavBarState();
}

class _CategoryNavBarState extends State<CategoryNavBar> {
  List<String> categories = [
    "general",
    "sports",
    "entertainment",
    "technology",
    "science",
    "business",
    "health",
  ];
  String? categoryName;
  String? country;
  Future<SharedPreferences> sharedPreference = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    categoryName = 'general';

    sharedPreference.then((SharedPreferences prefs) {
      country = prefs.getString('countryCode');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(120),
      width: double.infinity,
      child: StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            setState(() {
              categoryName = categories[index];
              //  HomeScreen.category = categoryName;
              //  print(categoryName);
              //   print(HomeScreen.category);
              BlocProvider.of<ArticlesCubit>(context).resetArticles();
              BlocProvider.of<ArticlesCubit>(context)
                  .getArticles(category: categoryName!, country: country!);
            });
          },
          child: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: categories[index] == categoryName
                  ? MyColors.myGreen
                  : Colors.white,
            ),
            child: Center(
              child: Text(
                categories[index].toUpperCase(),
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(12),
                  fontWeight: FontWeight.bold,
                  color: categories[index] == categoryName
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.count(
            1,
            categories[index].length.toDouble() /
                getProportionateScreenWidth(4.2)),
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
      ),
    );
  }
}
