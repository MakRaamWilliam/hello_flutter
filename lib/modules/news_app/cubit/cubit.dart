
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/modules/news_app/cubit/states.dart';
import 'package:hello_flutter/shared/network/remote/DioHelper.dart';
import 'package:sqflite/sqflite.dart';

import '../busienessScreen.dart';
import '../scienceScreen.dart';
import '../sportsScreen.dart';


class newsCubit extends Cubit<newsStates>{
  newsCubit() : super(newsInitialState());

  late Database database;
  int currNavIndex =0;
  List<Widget> newsScreensIndex = [
    businessScreen(),
    sporstScreen(),
    sciencetScreen(),
  ];

  static newsCubit getInstance(context) => BlocProvider.of(context);

  void chaneNavBarIndex(int index){
    currNavIndex = index;
    if(index == 0)
      getBusiness();
    else if(index == 1)
      getSports();
    else if(index == 2)
      getScience();

  }
  List<dynamic> businessList = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    if(businessList.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'business',
          'apiKey':'b7d0c7fbf578454297910549ae493772',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        businessList = value.data['articles'];
        print(businessList[0]['title']);

        emit(newsChangeBottomNavBarState());
        emit(NewsGetBusinessSuccessState());

      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else
    {
      emit(newsChangeBottomNavBarState());
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sportsList = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sportsList.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'b7d0c7fbf578454297910549ae493772',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        sportsList = value.data['articles'];
        print(sportsList[0]['title']);

        emit(newsChangeBottomNavBarState());
        emit(NewsGetSportsSuccessState());

      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else
    {
      emit(newsChangeBottomNavBarState());
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> scienceList = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(scienceList.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'science',
          'apiKey':'b7d0c7fbf578454297910549ae493772',
        },
      ).then((value)
      {
        print(value.data['articles'][0]['title']);
        scienceList = value.data['articles'];
        print(scienceList[0]['title']);

        emit(newsChangeBottomNavBarState());
        emit(NewsGetScienceSuccessState());

      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else
    {
      emit(newsChangeBottomNavBarState());
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> searchList = [];

  void getSearch(String searchValue)
  {
    emit(NewsGetSearchLoadingState());

      DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q':'$searchValue',
          'apiKey':'b7d0c7fbf578454297910549ae493772',
        },
      ).then((value)
      {
        print(value.data['articles'][0]['title']);
        searchList = value.data['articles'];
        print(searchList[0]['title']);

        emit(newsChangeBottomNavBarState());
        emit(NewsGetSearchSuccessState());

      }).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });

  }


}