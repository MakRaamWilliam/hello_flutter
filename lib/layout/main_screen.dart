import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/layout/shop_app/shop_layout.dart';
import 'package:hello_flutter/layout/social_app/social_app_layout.dart';
import 'package:hello_flutter/layout/to_do_app/home_screen.dart';
import 'package:hello_flutter/modules/shop_app/on_boarding_screen.dart';
import 'package:hello_flutter/modules/shop_app/shop_log_in.dart';
import 'package:hello_flutter/modules/social_app/social_log_in.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/components/constans.dart';
import 'package:hello_flutter/shared/network/local/cacheHelper.dart';
import 'package:hello_flutter/shared/styles/colors.dart';

import 'news_app/newsScreen.dart';

class MainScreen extends StatelessWidget{
  late Widget widget;
  bool? isDark = CacheHelper.getBool(key: "isDark");
  bool? isBoarding = CacheHelper.getBool(key: "isBoarding");
  bool? isToken = CacheHelper.getBool(key: "isToken");
  String?  uid = CacheHelper.getString(key: "uid");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 80.0,
                  onPressed: (){
                    if(isBoarding == null) {
                      isBoarding = false;
                      widget = OnBoardingScreen();
                    }else{
                      if(isToken != null)
                        widget = ShopLayout();
                      else
                        widget = ShopLogInScreen();
                    }
                    defaultColor = Colors.deepOrange;
                    NavgPushToAndFinish(context, widget);
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                ),
                SizedBox(width: 20,),
                IconButton(
                  iconSize: 80.0,
                  onPressed: (){
                   widget = newsScreen();
                   NavgPushToAndFinish(context, widget);
                  },
                  icon: Icon(Icons.business),
                ),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 80.0,
                  onPressed: (){
                    widget = ToDo_home_screen();
                    NavgPushToAndFinish(context, widget);
                  },
                  icon: Icon(Icons.toc_sharp),
                ),
                SizedBox(width: 20,),
                IconButton(
                  iconSize: 80.0,
                  onPressed: (){
                    if(uid == null ){
                      widget = SocialLogInScreen();
                    }else{
                      Uid = uid!;
                      widget = SocialLayout();
                    }
                    NavgPushToAndFinish(context, widget);

                  },
                  icon: Icon(Icons.face),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

}