
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/models/shop_model/login_model.dart';
import 'package:hello_flutter/models/shop_model/register_model.dart';
import 'package:hello_flutter/modules/shop_app/register_cubit/states.dart';
import 'package:hello_flutter/shared/components/constans.dart';
import 'package:hello_flutter/shared/network/remote/shop_dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegistersStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit getInstance(context) => BlocProvider.of(context);

  bool isPasswordSecure = true;
  late bool status;
  late String mess;

  void ChangePasswrodSecure(){
    isPasswordSecure = !isPasswordSecure;
    emit(ShopChangePasswordVisibilityState());
  }

  void RegisterClick({
    required String name,
    required String phone,
    required String email,
    required String password,
   }){
    emit(ShopRegisterLoadingState());
   //  ShopDioHelper.postData(
   //  url: Register,
   //  data: {
   //    'name': name,
   //    'phone': phone,
   //    'email': email,
   //    'password': password,
   //  }
   // ).then((value) {
   //    emit(ShopRegisterSuccessState());
   //    status = value.data['status'];
   //    mess = value.data['message'];
   //    print(status);
   //    print(mess);
   //  }).catchError((error){
   //    emit(ShopRegisterErrorState(error.toString()));
   //  });
   print("ooooooooooooo");
   FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password
        ).then((value) {
           print("objecttttttt");
           emit(ShopRegisterSuccessState());
           print(value.user!.email);
           print(value.user!.uid);
         }).catchError((error){
           emit(ShopRegisterErrorState(error.toString()));
           print(error.toString());
         });


    }

}