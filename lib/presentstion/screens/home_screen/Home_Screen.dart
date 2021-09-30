import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../business_logic/cubit/articles_cubit.dart';
import '../../../constants.dart';
import '../../../data/local_database/local_db_helper.dart';
import '../../../data/models/article.dart';
import 'components/app_bar_title.dart';
import 'components/category_nav_bar.dart';
import 'components/search_button.dart';
import '../news_details_screen/news_details_screen.dart';
import '../select_country_screen/select_country_screen.dart';
import '../../widget/custom_drawer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/loading_indicator.dart';
import '../../widget/news_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? country;
  String category = 'general';
  List<Article>? articles;
  List<Article> searchedArticles = [];
  List<Article> toShowArticles = [];
  late ScrollController _scrollController;
  bool isSearching = false;
  bool showScrolltoTopButton = false;
  late LocalDbHelper localDbHelper;

  Future<SharedPreferences> sharedPreference = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    localDbHelper = LocalDbHelper();
    sharedPreference.then((SharedPreferences prefs) {
      country = prefs.getString('countryCode');
      // print(prefs.getString('countryCode')!);
      if (country == null) {
        Navigator.pushNamed(context, SelectCountryScreen.routeName);
      }
      //  print(country);
      else {
        BlocProvider.of<ArticlesCubit>(context)
            .getArticles(country: country!, category: category);
      }
    });

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels != 0) {
            BlocProvider.of<ArticlesCubit>(context)
                .getArticles(country: country!, category: category);
          }
        }
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
  }

  _buildToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.myGreen,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  _search(String searchCharacters) {
    setState(() {
      searchedArticles = articles!
          .where(
            (element) => element.title!.toLowerCase().contains(
                  searchCharacters.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: AppBarTitle(
          isSearching: isSearching,
          onChanged: (searchCharacters) {
            _search(searchCharacters);
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
    );
  }

  // random reorder of articles if you call refresh indicator
  Future<Null> articlesShuffle() async {
    await Future.delayed(Duration(milliseconds: 500));
    toShowArticles.shuffle();
    setState(() {});
    return null;
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
      drawer: CustomDrawer(),
      appBar: _buildAppBar(),
      body: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          bool isLoading = false;
          if (state is ArticlesLoading && state.isFirstFetch) {
            return LoadingIndicator();
          }
          if (state is ArticlesLoading) {
            articles = (state).oldArticles;
            toShowArticles = isSearching ? searchedArticles : articles!;
            isLoading = true;
          }
          if (state is ArticlesLoaded) {
            articles = (state).articles;
            toShowArticles = isSearching ? searchedArticles : articles!;
          }
          return Column(
            children: [
              CategoryNavBar(
                scrollToTop: scrollToTop,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: RefreshIndicator(
                    onRefresh: articlesShuffle,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: toShowArticles.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < toShowArticles.length) {
                          return NewsCard(
                            id: 0,
                            text: toShowArticles[index].title!,
                            imgUrl: toShowArticles[index].urlToImage!,
                            date: toShowArticles[index].publishedAt!,
                            onSharePress: () {
                              Share.share(toShowArticles[index].url!);
                            },
                            onSavedPress: () async {
                              try {
                                var allSavedArticlesData =
                                    await localDbHelper.allSavedArticles();

                                List<Article> allSavedArticles =
                                    allSavedArticlesData
                                        .map((e) => Article.fromJson(e))
                                        .toList();
                                var isExist = false;
                                for (var i = 0;
                                    i < allSavedArticles.length;
                                    i++) {
                                  // you may have to check the equality operator
                                  //  print(allSavedArticles[i].title);
                                  if (toShowArticles[index].title! ==
                                      allSavedArticles[i].title) {
                                    isExist = true;
                                    break;
                                  }
                                }
                                if (isExist) {
                                  _buildToastMessage("Article is Exist");
                                } else {
                                  localDbHelper
                                      .saveArticle(toShowArticles[index]);
                                  _buildToastMessage("Article added to Saved");
                                }
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
                        } else {
                          return LoadingIndicator();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
