part of 'articles_cubit.dart';

@immutable
abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoaded extends ArticlesState {
  final List<Article> articles;

  ArticlesLoaded(this.articles);
}

class ArticlesLoading extends ArticlesState {
  final List<Article> oldArticles;
  final bool isFirstFetch;

  ArticlesLoading(this.oldArticles, {this.isFirstFetch = false});
}

class SavedArticlesLoaded extends ArticlesState {
  final List<dynamic> articles;

  SavedArticlesLoaded(this.articles);
}
