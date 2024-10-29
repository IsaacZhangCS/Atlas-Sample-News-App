import 'package:atlas_news_app/models/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This service class will fetch the Article from our firestore DB
class ArticleService {
  static const collectionName = 'articles';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Queries the "articles" collection and gets all the associated article documents,
  // maps them to our Article model class, and returns a List<Article>
  Future<List<Article>> fetchArticles() async {
    QuerySnapshot snapshot = await _firestore.collection(collectionName).get();
    return snapshot.docs
        .map(
          (doc) => Article.fromFirestore(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }
}
