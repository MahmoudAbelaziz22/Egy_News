import '../local_database/local_db_helper.dart';
import '../web_services/news_services.dart';
import '../models/article.dart';
import '../models/articels.dart';

class NewsRepository {
  final NewsWebServices newsWebServices;
  NewsRepository(this.newsWebServices);

  Future<List<Article>> getArticles({
    required String country,
    required String category,
    required int page,
  }) async {
    final webServicesData = await newsWebServices.getArticles(
        country: country, category: category, page: page);
    Articles articlesData = Articles.fromJson(webServicesData);
    List<Article> articlesWithNull =
        articlesData.articles.map((e) => Article.fromJson(e)).toList();
    List<Article> articles = articlesWithNull
        .where((element) =>
            element.title != null &&
            element.url != null &&
            element.urlToImage != null &&
            element.description != null &&
            element.publishedAt != null)
        .toList();
    return articles;
  }

  Future<List<dynamic>> getSavedArticles() async {
    LocalDbHelper localDbHelper = LocalDbHelper();
    final localDatabaseData = await localDbHelper.allSavedArticles();
    List<Article> articles =
        localDatabaseData.map((e) => Article.fromJson(e)).toList();
    return articles;
  }
}
