import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/modules/shop_app/cubit/states.dart';
import 'package:hello_flutter/shared/components/constans.dart';
import 'package:hello_flutter/shared/network/remote/shop_dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit getInstance(context) => BlocProvider.of(context);

  void loginClick({
  required String user,
  required String password,
  }){
    emit(ShopLoginLoadingState());
    ShopDioHelper.postData(
        url: Login,
        data: {
          'email':user,
          'password': password
        }).then((value) {
          print(value.data);
          emit(ShopLoginSuccessState());
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });

  }
}