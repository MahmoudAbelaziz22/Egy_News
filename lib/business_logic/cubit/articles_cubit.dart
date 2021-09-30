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

  Future<List<Article>> getArticles({
    required String country,
    required String category,
  }) async {
    if (state is ArticlesLoading) return [];
    final currentState = state;
    var oldPosts = <Article>[];
    if (currentState is ArticlesLoaded) {
      oldPosts = currentState.articles;
    }

    emit(ArticlesLoading(oldPosts, isFirstFetch: page == 1));

    newsRepository
        .getArticles(country: country, category: category, page: page)
        .then((newArticles) {
      page++;

      articles = (state as ArticlesLoading).oldArticles;
      articles.addAll(newArticles);

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
