import 'dart:convert';

import 'package:news_today/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  getNewsArticle() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=b615b8a1c82e40bf8255f737bbcee9d6";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((article) {
        if (article['urlToImage'] != null && article['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: article['title'],
            description: article['description'],
            author: article['author'],
            content: article['content'],
            url: article['url'],
            urlTImage: article['urlToImage'],
            publishedDate: article['publishedAt'].toString(),
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNews {
  List<ArticleModel> categoryNews = [];

  Future<void> getCategoryNews(String cat) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$cat&apiKey=b615b8a1c82e40bf8255f737bbcee9d6";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((article) {
        if (article['urlToImage'] != null && article['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: article['title'],
            description: article['description'],
            author: article['author'],
            content: article['content'],
            url: article['url'],
            urlTImage: article['urlToImage'],
            publishedDate: article['publishedAt'].toString(),
          );
          categoryNews.add(articleModel);
        }
      });
    }
  }
}
