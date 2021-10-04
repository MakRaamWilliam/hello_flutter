import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/layout/social_app/cubit/cubit.dart';
import 'package:hello_flutter/models/social_app/user_data.dart';
import 'package:hello_flutter/modules/social_app/log_in_cubit/states.dart';
import 'package:hello_flutter/shared/components/constans.dart';
import 'package:hello_flutter/shared/network/local/cacheHelper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit getInstance(context) => BlocProvider.of(context);

  bool isPasswordSecure = true;

  void ChangePasswrodSecure(){
    isPasswordSecure = !isPasswordSecure;
    emit(SocialChangePasswordVisibilityState());
  }
  String errorMsg = "";
  late SocialUserData userData;

  void loginClick({
  required String email,
  required String password,
  }){
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
            Uid = value.user!.uid;
            CacheHelper.putString(key: "uid", value: Uid);
            emit(SocialLoginSuccessState());
            close();
            SocialCubit()..getUSerData();
    }).catchError((error){
        emit(SocialLoginErrorState(error.toString()));
        errorMsg = error.toString();
        // print(error.toString());
      });

    }
}

