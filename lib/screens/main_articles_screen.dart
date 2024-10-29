import 'package:atlas_news_app/providers/article_provider.dart';
import 'package:atlas_news_app/utils/atlas_colors.dart';
import 'package:atlas_news_app/utils/atlas_strings.dart';
import 'package:atlas_news_app/widgets/article_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainArticlesScreen extends StatefulWidget {
  const MainArticlesScreen({super.key});

  @override
  State<MainArticlesScreen> createState() => _MainArticlesScreenState();
}

class _MainArticlesScreenState extends State<MainArticlesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  Future<void> _refreshArticles(BuildContext context) async {
    final articleProvider = Provider.of<ArticleProvider>(context, listen: false);
    await articleProvider.fetchArticles();
  }

  void _onSearchChanged(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm.toLowerCase();
    });
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: const InputDecoration(
          hintText: AtlasStrings.searchBarHintText,
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildBody(ArticleProvider articleProvider) {
    final filteredArticles =
        articleProvider.articles.where((article) => article.title.toLowerCase().contains(_searchTerm)).toList();

    Widget buildContent() {
      if (articleProvider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (articleProvider.error.isNotEmpty) {
        return const Center(child: Text(AtlasStrings.errorMessage));
      } else if (filteredArticles.isEmpty) {
        return const Center(child: Text(AtlasStrings.noArticlesMessage));
      } else {
        return Expanded(
          child: ListView.builder(
            itemCount: filteredArticles.length,
            itemBuilder: (context, index) {
              return ArticleRow(article: filteredArticles[index]);
            },
          ),
        );
      }
    }

    return Column(
      children: [
        _buildSearchBar(),
        buildContent(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      backgroundColor: AtlasColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          AtlasStrings.appTitle,
          style: TextStyle(
            color: AtlasColors.onPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AtlasColors.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshArticles(context),
        child: _buildBody(articleProvider),
      ),
    );
  }
}
