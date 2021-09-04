import 'package:dio/dio.dart';

import '../../constants.dart';

class NewsWebServices {
  late Dio dio;

  NewsWebServices() {
    var option = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 8 * 1000,
      receiveTimeout: 5 * 1000,
    );

    dio = Dio(option);
  }

  Future<dynamic> getAllArticles() async {
    try {
      Response response =
          await dio.get('v2/top-headlines?country=eg&apiKey=$apiKey');

      if (response.statusCode == 200) {
        var jsonData = response.data;
        return jsonData;
      } else {
        print('Error Ocurred with StatusCode= ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> getArticlesByCategory(String category) async {
    try {
      Response response = await dio
          .get('v2/top-headlines?country=eg&category=$category&apiKey=$apiKey');

      if (response.statusCode == 200) {
        var jsonData = response.data;
        return jsonData;
      } else {
        print('Error Ocurred with StatusCode= ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
