import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/cubit/articles_cubit.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/data/repository/news_repository.dart';
import 'package:news_app/data/web_services/news_services.dart';
import 'package:news_app/presentstion/screens/home_screen/home_screen.dart';
import 'package:news_app/presentstion/screens/news_details_screen/news_details_screen.dart';
import 'package:news_app/presentstion/screens/saved_articles_screen/saved_article_screen.dart';
import 'package:news_app/presentstion/screens/select_country_screen/select_country_screen.dart';

class AppRouter {
  late ArticlesCubit articlesCubit;
  late NewsRepository newsRepository;

  AppRouter() {
    newsRepository = NewsRepository(NewsWebServices());
    articlesCubit = ArticlesCubit(newsRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => articlesCubit,
                  child: HomeScreen(),
                ));
      case SavedArticlesScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => articlesCubit,
                  child: SavedArticlesScreen(),
                ));
      case NewsDetailsScreen.routName:
        final article = settings.arguments as Article;
        return MaterialPageRoute(
            builder: (_) => NewsDetailsScreen(article: article));
      case SelectCountryScreen.routeName:
        return MaterialPageRoute(builder: (_) => SelectCountryScreen());
    }
  }
}
