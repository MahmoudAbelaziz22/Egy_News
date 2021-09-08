import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:news_app/data/models/article.dart';
import 'package:news_app/data/repository/news_repository.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final NewsRepository newsRepository;
  ArticlesCubit(this.newsRepository) : super(ArticlesInitial());
  List<Article> articles = [];
  List<dynamic> savedArticles = [];
  Future<List<Article>> getArticles(
      {required String country, required String category}) async {
    newsRepository
        .getArticles(category: category, country: country)
        .then((articles) {
      emit(ArticlesLoaded(articles));
      this.articles = articles;
    });

    return articles;
  }

  Future<List<dynamic>> getSavedArticles() async {
    newsRepository.getSavedArticles().then((articles) {
      emit(SavedArticlesLoaded(articles));
      this.savedArticles = articles;
    });

    return articles;
  }
}
