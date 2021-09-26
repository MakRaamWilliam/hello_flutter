import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/layout/news_app/newsScreen.dart';
import 'package:hello_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:hello_flutter/layout/shop_app/shop_layout.dart';
import 'package:hello_flutter/layout/to_do_app/home_screen.dart';
import 'package:hello_flutter/modules/bmi_app/BMICalculator.dart';
import 'package:hello_flutter/modules/counter_app/CounterScreen.dart';
import 'package:hello_flutter/layout/basic_apps/HomeScreen.dart';
import 'package:hello_flutter/modules/messenger_app/Messenger.dart';
import 'package:hello_flutter/modules/log_in_app/loginScreen.dart';
import 'package:hello_flutter/modules/news_app/cubit/cubit.dart';
import 'package:hello_flutter/modules/shop_app/products_screen.dart';
import 'package:hello_flutter/modules/shop_app/shop_log_in.dart';
import 'package:hello_flutter/shared/bloc_observer.dart';
import 'package:hello_flutter/shared/cubit/cubit.dart';
import 'package:hello_flutter/shared/cubit/states.dart';
import 'package:hello_flutter/shared/network/local/cacheHelper.dart';
import 'package:hello_flutter/shared/network/remote/news_dio_helper.dart';
import 'package:hello_flutter/shared/network/remote/shop_dio_helper.dart';
import 'package:hello_flutter/shared/styles/themes.dart';

import 'package:hello_flutter/modules/shop_app/on_boarding_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
         BlocProvider(create: (context) => ShopCubit()..getHomeData(),)

    ],
       child: BlocConsumer< AppCubit, AppStates>(
           listener: (context,state) {},
           builder: (context, state) {
             late Widget widget;
             bool? isDark = CacheHelper.getBool(key: "isDark");
             bool? isBoarding = CacheHelper.getBool(key: "isBoarding");
             bool? isToken = CacheHelper.getBool(key: "isToken");

             if(isDark == null)
               isDark = false;
             if(isBoarding == null) {
               isBoarding = false;
               widget = OnBoardingScreen();
             }else{
               if(isToken != null)
                  widget = ShopLayout();
               else
                 widget = ShopLogInScreen();
             }
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

