import 'package:atlas_news_app/models/article.dart';
import 'package:atlas_news_app/utils/atlas_colors.dart';
import 'package:atlas_news_app/widgets/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleRow extends StatelessWidget {
  final Article article;
  final double imageSize = 50.0;

  const ArticleRow({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri.parse(article.url);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        color: AtlasColors.cardBackgroundColor,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipOval(
                child: Image.network(
                  article.thumbnailImageUrl,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported, size: imageSize);
                  },
                ),
              ),
              const HorizontalSpace(byFactorOf: 2),
              Expanded(
                child: Text(
                  article.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
