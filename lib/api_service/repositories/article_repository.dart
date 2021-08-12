import 'package:dio/dio.dart';
import 'package:news_app/models/articleModel.dart';

class ArticleRepository {
  late final Dio dioClient;

  ArticleRepository({
    required this.dioClient,
  });

  Future<Map?>? getArticles({
    required int start,
    required int limit,
    String? contains,
  }) async {
    try {
      var response = await dioClient.get('/articles', queryParameters: {
        '_start': start,
        '_limit': limit,
        '_contains': contains,
      });

      return {
        "data" : response.data.map((element)=>ArticleModel.fromJson(element)).toList()
      };
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
      } else {
        // Something happened in setting up or sending the request that triggered an Error

        print(e.message);
      }
    }
  }
}
