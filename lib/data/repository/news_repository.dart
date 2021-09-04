import 'package:news_app/data/web_services/news_services.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/data/models/articels.dart';

class NewsRepository {
  final NewsWebServices newsWebServices;

  NewsRepository(this.newsWebServices);

  Future<List<Article>> getallArticles() async {
    final webServicesData = await newsWebServices.getAllArticles();
    Articles articlesData = Articles.fromJson(webServicesData);
    List<Article> articlesWithNull =
        articlesData.articles.map((e) => Article.fromJson(e)).toList();
    List<Article> articles = articlesWithNull
        .where((element) =>
            element.title != null &&
            element.url != null &&
            element.urlToImage != null &&
            element.description != null)
        .toList();
    return articles;
  }

  Future<List<Article>> getArticlesByCategory(String category) async {
    final webServicesData =
        await newsWebServices.getArticlesByCategory(category);
    Articles articlesData = Articles.fromJson(webServicesData);
    List<Article> articlesWithNull =
        articlesData.articles.map((e) => Article.fromJson(e)).toList();
    List<Article> articles = articlesWithNull
        .where((element) =>
            element.title != null &&
            element.url != null &&
            element.urlToImage != null &&
            element.content != null &&
            element.description != null &&
            element.publishedAt != null)
        .toList();
    return articles;
  }
}
