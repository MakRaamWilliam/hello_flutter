

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>{
   AppCubit() : super(AppInitialState());

   static AppCubit getInstance(context) => BlocProvider.of(context);

   bool isDark = false;

   void changeDarkTheme(){
     isDark = !isDark;
     emit(AppChangeThemeState());
   }

  }