import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/modules/news_app/cubit/cubit.dart';
import 'package:hello_flutter/modules/news_app/cubit/states.dart';
import 'package:hello_flutter/modules/news_app/searchScreen.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/cubit/cubit.dart';
import 'package:hello_flutter/shared/network/local/cacheHelper.dart';
import 'package:hello_flutter/shared/network/remote/DioHelper.dart';


var scaffoldKey = GlobalKey<ScaffoldState>();

class newsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer< newsCubit, newsStates>(
    listener: (BuildContext context, newsStates state) {},
    builder: (BuildContext context, newsStates state) {
    newsCubit cubit = newsCubit.getInstance(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("news app"),
        actions: [
          IconButton(
              onPressed: (){
                NavgPushTo(context,
                searchScreen(),
                );
              },
              icon: Icon(Icons.search)
          ),
          IconButton(
              onPressed: (){
                AppCubit.getInstance(context).changeDarkTheme();
                 CacheHelper.putIsDark(key: "isDark",
                 value: AppCubit.getInstance(context).isDark
                 );

              },
              icon: Icon(Icons.brightness_6)
          )

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cubit.currNavIndex,
        onTap: (int index){
            cubit.chaneNavBarIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.business_sharp),
            label: "Business"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_volleyball_rounded),
            label: "Sports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: "Science"
          ),

        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: (){
      //     DioHelper.getData(
      //       url: 'v2/top-headlines',
      //       query:
      //       {
      //         'country':'eg',
      //         'category':'sports',
      //         'apiKey':'b7d0c7fbf578454297910549ae493772',
      //       },
      //     ).then((value) {
      //       print(value.data["articles"][0]["title"]);
      //       print(value.data.toString());
      //     }).
      //     catchError((error){
      //       print(error);
      //     });
      //   },
      // ),
      body: cubit.newsScreensIndex[cubit.currNavIndex],
    );

  }
    );
  }
}
