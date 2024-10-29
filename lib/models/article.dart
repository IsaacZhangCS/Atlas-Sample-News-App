class Article {
  final String id;
  final String title;
  final String thumbnailImageUrl;
  final String url;

  Article({
    required this.id,
    required this.title,
    required this.thumbnailImageUrl,
    required this.url,
  });

  factory Article.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Article(
      id: documentId,
      title: data['title'],
      thumbnailImageUrl: data['thumbnailImageUrl'],
      url: data['url'],
    );
  }
}
