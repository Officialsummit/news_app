import 'package:flutter/material.dart';
import 'package:news_today/screens/home_page.dart';

class LoadingFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Something went wrong please click below button to refresh'),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
