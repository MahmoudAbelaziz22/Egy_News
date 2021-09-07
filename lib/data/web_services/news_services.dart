import 'package:dio/dio.dart';

import '../../constants.dart';

class NewsWebServices {
  late Dio dio;

  NewsWebServices() {
    dio = Dio();
  }

  Future<dynamic> getArticles(
      {required String country, required String category}) async {
    try {
      Response response = await dio.get(baseUrl, queryParameters: {
        "apiKey": apiKey,
        "country": country,
        "category": category
      });

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
