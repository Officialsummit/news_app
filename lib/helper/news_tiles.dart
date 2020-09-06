import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_today/screens/articel_view.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String url;

  const NewsTile({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              newsUrl: url,
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Image.network(imageUrl),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: GoogleFonts.headlandOne(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(description),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
