import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../data/models/article.dart';
import '../../widget/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsScreen extends StatefulWidget {
  static const String routName = '/news_details';
  final Article article;

  const NewsDetailsScreen({Key? key, required this.article}) : super(key: key);

  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool isLoading = true;
  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'EgyNews',
          style: TextStyle(
            color: MyColors.myGreen,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            onPageFinished: (pageUrl) {
              setState(() {
                isLoading = false;
              });
            },
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.article.url,
          ),
          isLoading ? LoadingIndicator() : SizedBox(),
        ],
      ),
    );
  }
}
