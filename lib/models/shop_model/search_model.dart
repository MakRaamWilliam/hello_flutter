
import 'package:hello_flutter/models/shop_model/home_model.dart';

class SearchModel {

  late bool status;
   // SearchDataModel? data;
  List<ProductModel> products = [];

  SearchModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    // data = SearchDataModel.fromJson(json['data']['data']);
    json['data']['data'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });

  }

}

class SearchDataModel {
  List<ProductModel> products = [];


  SearchDataModel.fromJson(Map<String, dynamic> json)
  {

    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
  }

}