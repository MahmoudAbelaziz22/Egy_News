import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../business_logic/cubit/articles_cubit.dart';
import '../../../data/local_database/local_db_helper.dart';
import '../../../size_cofig.dart';
import '../home_screen/home_screen.dart';
import '../news_details_screen/news_details_screen.dart';
import '../../widget/loading_indicator.dart';
import '../../widget/news_card.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants.dart';

class SavedArticlesScreen extends StatefulWidget {
  static const String routeName = '/saves_articles';

  @override
  _SavedArticlesScreenState createState() => _SavedArticlesScreenState();
}

class _SavedArticlesScreenState extends State<SavedArticlesScreen> {
  String country = 'eg';
  String category = 'general';
  List articles = [];
  late ScrollController _scrollController;
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
    BlocProvider.of<ArticlesCubit>(context).getSavedArticles();
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, HomeScreen.routName),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'EgyNews',
          style: TextStyle(
            color: MyColors.myGreen,
          ),
        ),
      ),
      body: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          if (state is SavedArticlesLoaded) {
            articles = (state).articles;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      id: articles[index].id!,
                      text: articles[index].title!,
                      imgUrl: articles[index].urlToImage!,
                      date: articles[index].publishedAt!,
                      onSharePress: () {
                        Share.share(articles[index].url!);
                      },
                      onSavedPress: () {
                        setState(() {
                          localDbHelper.delete(articles[index].id);
                          Fluttertoast.showToast(
                              msg: "Article is deleted from Saved",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: MyColors.myGreen,
                              textColor: Colors.white,
                              fontSize: getProportionateScreenWidth(14));
                          BlocProvider.of<ArticlesCubit>(context)
                              .getSavedArticles();
                        });
                      },
                      onPress: () {
                        Navigator.pushReplacementNamed(
                            context, NewsDetailsScreen.routName,
                            arguments: articles[index]);
                      },
                    );
                  }),
            );
          } else {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}
