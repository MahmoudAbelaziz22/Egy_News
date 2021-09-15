import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

class NewsCard extends StatelessWidget {
  final String imgUrl, text, date;
  final Function onPress;
  final Function onSavedPress;
  final Function onSharePress;
  final int? id;

  const NewsCard(
      {required this.id,
      required this.imgUrl,
      required this.text,
      required this.date,
      required this.onPress,
      required this.onSharePress,
      required this.onSavedPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Stack(children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: Image(
                  width: double.infinity,
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headline5,
                  maxLines: 3,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    onPress();
                  },
                  child: Text(
                    'Show Details',
                    style: TextStyle(color: MyColors.myGreen, fontSize: 18),
                  )),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 15,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              iconSize: 24,
              color: MyColors.myGreen,
              onPressed: () {
                onSavedPress();
              },
              icon: id == 0
                  ? Icon(
                      Icons.bookmark_outline_outlined,
                    )
                  : Icon(
                      Icons.bookmark,
                    ),
            ),
          ),
        ),
        Positioned(
          top: 80,
          right: 15,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              iconSize: 24,
              color: MyColors.myGreen,
              onPressed: () {
                onSharePress();
              },
              icon: Icon(Icons.share),
            ),
          ),
        )
      ]),
    );
  }
}
