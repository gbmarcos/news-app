
import 'package:dio/dio.dart';

var options = BaseOptions(
  baseUrl: 'https://api.spaceflightnewsapi.net/v3',
  connectTimeout: 30000,
  receiveTimeout: 30000,
);

Dio dioClient = Dio(options);