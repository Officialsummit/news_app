import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_today/helper/data.dart';
import 'package:news_today/helper/news.dart';
import 'package:news_today/helper/news_tiles.dart';
import 'package:news_today/models/article_model.dart';
import 'package:news_today/models/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_today/screens/category_view.dart';
import 'package:news_today/screens/loading_failed.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = List<CategoryModel>();
  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading = true;
  bool _showRefresh = false;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();

    handleScroll();
  }

  getNews() async {
    News newsObject = News();
    await newsObject.getNewsArticle();
    articles = newsObject.news;
    print(articles);
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  void showRefresh() {
    setState(() {
      _showRefresh = true;
    });
  }

  void hideRefresh() {
    setState(() {
      _showRefresh = false;
    });
  }

  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route());
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoadingFailed()));
  }

  void handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showRefresh();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideRefresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4D2640),
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'News',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'App',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        elevation: 0.0,
        actions: [
          Text(
            DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _showRefresh,
        child: RawMaterialButton(
          onPressed: () {
            setState(() {
              getNews();
            });
          },
          shape: const StadiumBorder(),
          fillColor: Colors.deepOrange,
          splashColor: Colors.green,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.refresh,
                size: 15,
                color: Colors.white,
              ),
              Text('Refresh'),
            ],
          ),
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: SpinKitChasingDots(
                  color: Colors.blue,
                  size: 100,
                ),
              ),
            )
          //categories container starts
          : SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      padding: EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryCards(
                            categoryName: categories[index].categoryName,
                            imageUrl: categories[index].imageUrl,
                          );
                        },
                      ),
                    ),
                    //News starts
                    Container(
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
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryCards extends StatelessWidget {
  final String imageUrl;
  final String categoryName;

  CategoryCards({
    this.imageUrl,
    this.categoryName,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryView(
                      categoryName: categoryName.toString().toLowerCase(),
                    )));
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Column(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              categoryName,
              style: GoogleFonts.raleway(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
