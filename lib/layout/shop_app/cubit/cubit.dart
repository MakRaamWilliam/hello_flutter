import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/layout/shop_app/cubit/states.dart';
import 'package:hello_flutter/models/shop_model/categories_model.dart';
import 'package:hello_flutter/models/shop_model/home_model.dart';
import 'package:hello_flutter/models/shop_model/search_model.dart';
import 'package:hello_flutter/models/shop_model/search_model.dart';
import 'package:hello_flutter/models/shop_model/search_model.dart';
import 'package:hello_flutter/modules/shop_app/categories_screen.dart';
import 'package:hello_flutter/modules/shop_app/favorites_screen.dart';
import 'package:hello_flutter/modules/shop_app/products_screen.dart';
import 'package:hello_flutter/modules/shop_app/settings_screen.dart';
import 'package:hello_flutter/shared/network/remote/shop_dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit getInstance(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late HomeModel homeModel;
  late SearchModel searchModel;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
    if(index == 0)
      getHomeData();
    if(index == 1 )
      getCategories();
  }

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    ShopDioHelper.getData(
      url: "home",
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      // print(homeModel.status);

      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

void getSearch(String text){
    emit(ShopLoadingSearchDataState());

    ShopDioHelper.postData(
      url: "products/search",
      data: {
        "text": text
      }

    ).then((value)
    {
      // print((value.data));
      searchModel = SearchModel.fromJson(value.data);
      // print(searchModel.status);


      emit(ShopSuccessSearchDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorSearchDataState());
    });

}

  late CategoriesModel categoriesModel;

  void getCategories() {
    emit(ShopLoadingCategoriesState());

    ShopDioHelper.getData(
        url: "categories"
    ).then((value) {
      // print(value.data);
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel.status);
      emit(ShopSuccessCategoriesState());

    }).catchError((error){
      emit(ShopErrorCategoriesState());
    });

  }

}