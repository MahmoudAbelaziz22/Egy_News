import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/articles_cubit.dart';
import 'package:news_app/presentstion/screens/news_details_screen/news_details_screen.dart';
import 'package:news_app/presentstion/widget/loading_indicator.dart';
import 'package:news_app/presentstion/widget/news_card.dart';

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

  @override
  void initState() {
    super.initState();

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
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('EgyNews'),
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
                      text: articles[index].title!,
                      imgUrl: articles[index].urlToImage!,
                      date: articles[index].publishedAt!,
                      onSavedPress: () {},
                      onPress: () {
                        Navigator.pushNamed(context, NewsDetailsScreen.routName,
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
