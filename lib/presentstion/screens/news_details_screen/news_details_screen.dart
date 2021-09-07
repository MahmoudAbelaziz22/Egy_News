import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/data/models/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const String routName = '/news_details';
  final Article article;

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  const NewsDetailsScreen({Key? key, required this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('EgyNews'),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: article.url,
      ),
    );
  }
}
