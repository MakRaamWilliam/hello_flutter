import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hello_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:hello_flutter/layout/shop_app/cubit/states.dart';
import 'package:hello_flutter/models/shop_model/categories_model.dart';
import 'package:hello_flutter/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
    listener: (context,state){},
    builder: (context,state ){
     ShopCubit cubit = ShopCubit.getInstance(context);
      return Conditional.single(
          context: context,
          conditionBuilder: (context)=> state is ShopSuccessCategoriesState,
          widgetBuilder: (context)=> ListView.separated(
              itemBuilder: (context, index) => BuilderWidget(cubit.categoriesModel.data.data[index]) ,
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.categoriesModel.data.data.length
          ),
        fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
      );
    },
    );

  }

Widget BuilderWidget(DataModel model){

    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:
        [
          Image(
            image: NetworkImage(model.image?? ""),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.name,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
}

}