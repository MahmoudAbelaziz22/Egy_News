class Article {
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article(
      {required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  factory Article.fromJson(Map<String, dynamic> jsonData) {
    return Article(
      author: jsonData['author'],
      title: jsonData['title'],
      description: jsonData['description'],
      url: jsonData['url'],
      urlToImage: jsonData['urlToImage'],
      publishedAt: jsonData['publishedAt'],
      content: jsonData['content'],
    );
  }
}
