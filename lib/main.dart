import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:hello_flutter/layout/social_app/cubit/cubit.dart';
import 'package:hello_flutter/layout/social_app/social_app_layout.dart';
import 'package:hello_flutter/modules/news_app/cubit/cubit.dart';
import 'package:hello_flutter/modules/shop_app/shop_log_in.dart';
import 'package:hello_flutter/shared/bloc_observer.dart';
import 'package:hello_flutter/shared/components/constans.dart';
import 'package:hello_flutter/shared/cubit/cubit.dart';
import 'package:hello_flutter/shared/cubit/states.dart';
import 'package:hello_flutter/shared/network/local/cacheHelper.dart';
import 'package:hello_flutter/shared/network/remote/news_dio_helper.dart';
import 'package:hello_flutter/shared/network/remote/shop_dio_helper.dart';
import 'package:hello_flutter/shared/styles/themes.dart';

import 'modules/social_app/social_log_in.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  NewsDioHelper.init();
  ShopDioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return
     MultiBlocProvider(
       providers: [BlocProvider(create: (context) => AppCubit()),
         BlocProvider(create: (context) => newsCubit()..getBusiness(),),
         BlocProvider(create: (context) => ShopCubit()..getHomeData(),),
         BlocProvider(create: (context) => SocialCubit()..getUSerData(),),
       ],
       child: BlocConsumer< AppCubit, AppStates>(
           listener: (context,state) {},
           builder: (context, state) {
             late Widget widget;
             bool? isDark = CacheHelper.getBool(key: "isDark");
             bool? isBoarding = CacheHelper.getBool(key: "isBoarding");
             bool? isToken = CacheHelper.getBool(key: "isToken");
             String?  uid = CacheHelper.getString(key: "uid");

             if(uid == null ){
               widget = SocialLogInScreen();
             }else{
               Uid = uid;
               widget = SocialLayout();
             }
             // if(isDark == null)
             //   isDark = false;
             // if(isBoarding == null) {
             //   isBoarding = false;
             //   widget = OnBoardingScreen();
             // }else{
             //   if(isToken != null)
             //      widget = ShopLayout();
             //   else
             //     widget = ShopLogInScreen();
             // }
             return  MaterialApp(
               home: Directionality
                 (
                   textDirection: TextDirection.ltr,
                   child: widget
               ),
               theme: lightTheme,
               darkTheme: darkTheme,
               themeMode: ThemeMode.light,
               // dark ? ThemeMode.dark : ThemeMode.light ,
             );
           }
       ),
     );

  }

}

