import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superspace/screens/homepage.dart';

class NewsCard extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;

  NewsCard({
    required this.imgUrl,
    required this.title,
    required this.description,
  });




  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imgUrl),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AutoSizeText(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 2, // Set the maximum number of lines
              minFontSize: 12, // Minimum font size to shrink to
              overflow: TextOverflow.ellipsis, // Handle text overflow with ellipsis
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(
                    imgUrl: imgUrl,
                    title: title,
                    description: description,
                  ),
                ),
              );
            },
            child: Text('Read More', style: TextStyle(color: Colors.purple)),
          ),
        ],
      ),
    );
  }
}