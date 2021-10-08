import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/models/shop_model/login_model.dart';
import 'package:hello_flutter/modules/shop_app/log_in_cubit/states.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/components/constans.dart';
import 'package:hello_flutter/shared/network/remote/shop_dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit getInstance(context) => BlocProvider.of(context);

  bool isPasswordSecure = true;
  late ShopLoginModel shopLoginModel;

  void ChangePasswrodSecure(){
    isPasswordSecure = !isPasswordSecure;
    emit(ShopChangePasswordVisibilityState());
  }

  void loginClick({
  required String email,
  required String password,
  }){
    emit(ShopLoginLoadingState());
    ShopDioHelper.postData(
        url: Login,
        data: {
          'email':email,
          'password': password
        }).then((value) {
          shopLoginModel = ShopLoginModel.fromJson(value.data);
          emit(ShopLoginSuccessState(shopLoginModel));
          print(shopLoginModel.status);
          print(shopLoginModel.message);
       }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
      print(error.toString());
    });

    // FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
    //     .then((value) {
    //         emit(ShopLoginSuccessState(shopLoginModel));
    //         print(value.user!.email);
    //         print(value.user!.uid);
    //      }).catchError((error){
    //     emit(ShopLoginErrorState(error.toString()));
    //     print(error.toString());
    //   });



    }
}