import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_today/helper/news.dart';
import 'package:news_today/helper/news_tiles.dart';
import 'package:news_today/models/article_model.dart';

class CategoryView extends StatefulWidget {
  final String categoryName;
  CategoryView({@required this.categoryName});
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  void getCategoryNews() async {
    CategoryNews newsObject = CategoryNews();
    await newsObject.getCategoryNews(widget.categoryName);
    setState(() {
      articles = newsObject.categoryNews;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.categoryName.toString().toUpperCase(),
        ),
      ),
      backgroundColor: Color(0xFF4D2640),
      body: _loading
          ? Container(
              child: Center(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 100,
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: ListView.builder(
                //  controller: _scrollController,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewsTile(
                    imageUrl: articles[index].urlTImage,
                    title: articles[index].title,
                    description: articles[index].description,
                    url: articles[index].url,
                  );
                },
              ),
            ),
    );
  }
}
