import 'package:news_app/data/web_services/news_services.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/data/models/articels.dart';

class NewsRepository {
  final NewsWebServices newsWebServices;

  NewsRepository(this.newsWebServices);

  Future<List<Article>> getArticles(
      {required String country, required String category}) async {
    final webServicesData =
        await newsWebServices.getArticles(country: country, category: category);
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
}
