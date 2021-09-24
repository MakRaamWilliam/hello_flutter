import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ShopDioHelper
{
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        connectTimeout:8000,
        receiveTimeout: 8000,
        headers: {
          'Content-Type':'application/json'
        }

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

  static Future<Response> postData({
    required String url,
    required Map<String,dynamic> data,
  }) async
  {
    return await dio.post(
      url,
      data:data
    );
  }


}
