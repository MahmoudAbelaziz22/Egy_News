import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/business_logic/cubit/articles_cubit.dart';
import 'package:news_app/constants.dart';

class CategoryNavBar extends StatefulWidget {
  final Function scrollToTop;

  const CategoryNavBar({required this.scrollToTop});
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
  String categoryName = "general";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
              BlocProvider.of<ArticlesCubit>(context)
                  .getArticles(category: categoryName, country: "eg");
              widget.scrollToTop();
            });
          },
          child: Container(
            margin: const EdgeInsets.all(6),
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: categories[index] == categoryName
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(1, categories[index].length.toDouble() / 3.5),
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
      ),
    );
  }
}