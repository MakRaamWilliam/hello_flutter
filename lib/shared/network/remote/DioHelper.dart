import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper
{
   static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
        connectTimeout:8000,
        receiveTimeout: 8000,

      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async
  {
    return await dio.get(
      url,
      queryParameters: query,


    );
  }
}
