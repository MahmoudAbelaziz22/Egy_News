import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/business_logic/cubit/articles_cubit.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/data/local_database/local_db_helper.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/presentstion/screens/home_screen/components/app_bar_title.dart';
import 'package:news_app/presentstion/screens/home_screen/components/category_nav_bar.dart';
import 'package:news_app/presentstion/screens/home_screen/components/search_button.dart';
import 'package:news_app/presentstion/screens/news_details_screen/news_details_screen.dart';

import '../../widget/loading_indicator.dart';
import '../../widget/news_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String country = 'eg';
  String category = 'general';
  List<Article>? articles;
  List<Article> searchedArticles = [];
  late ScrollController _scrollController;
  bool isSearching = false;
  bool showScrolltoTopButton = false;
  late LocalDbHelper localDbHelper;
  @override
  void initState() {
    super.initState();
    localDbHelper = LocalDbHelper();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > 400) {
          setState(() {
            showScrolltoTopButton = true;
          });
        } else {
          setState(() {
            showScrolltoTopButton = false;
          });
        }
      });

    BlocProvider.of<ArticlesCubit>(context)
        .getArticles(country: country, category: category);
  }

  void scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showScrolltoTopButton == true
          ? FloatingActionButton(
              backgroundColor: MyColors.myGreen,
              onPressed: scrollToTop,
              child: Icon(Icons.arrow_upward),
            )
          : SizedBox(),
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: AppBarTitle(
            isSearching: isSearching,
            onChanged: (searchCharacters) {
              setState(() {
                searchedArticles = articles!
                    .where(
                      (element) => element.title!.toLowerCase().contains(
                            searchCharacters.toLowerCase(),
                          ),
                    )
                    .toList();
              });
            }),
        actions: [
          SearchButton(
            isSearching: isSearching,
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          if (state is ArticlesLoaded) {
            articles = (state).articles;
            var toShowArticles = isSearching ? searchedArticles : articles;
            return Column(
              children: [
                CategoryNavBar(
                  scrollToTop: scrollToTop,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: toShowArticles!.length,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            text: toShowArticles[index].title!,
                            imgUrl: toShowArticles[index].urlToImage!,
                            date: toShowArticles[index].publishedAt!,
                            onSavedPress: () {
                              try {
                                localDbHelper
                                    .saveArticle(toShowArticles[index]);
                                Fluttertoast.showToast(
                                    msg: "Article added to Saved",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey.shade600,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } catch (error) {
                                print(error);
                              }
                            },
                            onPress: () {
                              Navigator.pushNamed(
                                  context, NewsDetailsScreen.routName,
                                  arguments: toShowArticles[index]);
                            },
                          );
                        }),
                  ),
                ),
              ],
            );
          } else {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}
