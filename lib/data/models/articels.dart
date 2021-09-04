class Articles {
  final List<dynamic> articles;
  final String status;

  Articles({
    required this.articles,
    required this.status,
  });

  factory Articles.fromJson(Map<String, dynamic> jsonData) {
    return Articles(
      articles: jsonData['articles'],
      status: jsonData['status'],
    );
  }
}
