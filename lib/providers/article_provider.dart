import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/article_service.dart';

class ArticleProvider with ChangeNotifier {
  final ArticleService _articleService = ArticleService();

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _articleService.fetchArticles();
    } catch (error) {
      _error = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
