import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String imgUrl, text;
  final Function onPress;

  const NewsCard(
      {required this.imgUrl, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          onPress();
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  padding: EdgeInsets.all(8),
                  child: Image(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 20),
                      maxLines: 3,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
