import 'package:atlas_news_app/providers/article_provider.dart';
import 'package:atlas_news_app/screens/main_articles_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  // We add this because of our call to Firebase.initializeApp()
  // This ensures we have an instance of WidgetsBinding for Firebase call
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleProvider()..fetchArticles(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MainArticlesScreen(),
      ),
    );
  }
}
