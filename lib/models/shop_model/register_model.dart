class ShopRegisterModel
{
  late bool status;
  late String message;
  // UserData? data;

  ShopRegisterModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    // data = (json['data'] != null ? UserData.fromJson(json['data']) : null);

  }
}
