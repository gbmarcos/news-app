
import 'package:dio/dio.dart';

var options = BaseOptions(
  baseUrl: 'https://api.spaceflightnewsapi.net/v3',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dioClient = Dio(options);