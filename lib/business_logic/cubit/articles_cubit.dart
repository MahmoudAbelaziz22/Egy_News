import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/article.dart';
import '../../data/repository/news_repository.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  int page = 1;
  final NewsRepository newsRepository;
  ArticlesCubit(this.newsRepository) : super(ArticlesInitial());

  List<Article> articles = [];
  List<dynamic> savedArticles = [];
  var oldPosts = <Article>[];

  Future<List<Article>> getArticles({
    required String country,
    required String category,
  }) async {
    emit(ArticlesLoading(oldPosts, isFirstFetch: page == 1));

    final currentState = state;

    if (currentState is ArticlesLoaded) {
      oldPosts = currentState.articles;
    }
    newsRepository
        .getArticles(country: country, category: category, page: page)
        .then((newArticles) {
      page++;

      if (state.runtimeType != ArticlesInitial &&
          state.runtimeType != ArticlesLoaded) {
        articles = (state as ArticlesLoading).oldArticles;
        articles.addAll(newArticles);
      }

      emit(ArticlesLoaded(articles));
      this.articles = articles;
    });

    return articles;
  }

  void resetArticles() {
    oldPosts = [];
    page = 1;
  }

  Future<List<dynamic>> getSavedArticles() async {
    newsRepository.getSavedArticles().then((articles) {
      emit(SavedArticlesLoaded(articles));
      this.savedArticles = articles;
    });

    return articles;
  }
}
