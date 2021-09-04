import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/articles_cubit.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/presentstion/screens/news_details_screen.dart';
import 'package:news_app/presentstion/widget/news_cart.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Article> articles;

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myPenk,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ArticlesCubit>(context).getallArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('EgyNews'),
      ),
      body: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          if (state is ArticlesLoaded) {
            articles = (state).articles;
            return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return NewsCard(
                    text: articles[index].title!,
                    imgUrl: articles[index].urlToImage!,
                    onPress: () {
                      Navigator.pushNamed(context, NewsDetailsScreen.routName,
                          arguments: articles[index]);
                    },
                  );
                });
          } else {
            return showLoadingIndicator();
          }
        },
      ),
    );
  }
}
