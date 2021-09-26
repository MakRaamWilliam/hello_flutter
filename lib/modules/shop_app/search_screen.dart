import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hello_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:hello_flutter/layout/shop_app/cubit/states.dart';
import 'package:hello_flutter/models/shop_model/home_model.dart';
import 'package:hello_flutter/models/shop_model/search_model.dart';
import 'package:hello_flutter/modules/shop_app/products_screen.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget{
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state){
        ShopCubit cubit = ShopCubit.getInstance(context);
        return Scaffold(
          appBar: AppBar(),
          body:  Column(
            children: [
              defaultFormField(
                  controller: searchController,
                  label: "search",
                  type: TextInputType.text,
                  prefix: Icons.search,
                  validText: "search can not be empty!",
                  onSubmit: (value){
                    cubit.getSearch(value);
                  }
              ),
              Expanded(
                  child:Conditional.single(
                      context: context,
                      conditionBuilder:(context)=> state is ShopSuccessSearchDataState,
                      widgetBuilder: (context)=> builderWidget(context,cubit.searchModel),
                      fallbackBuilder: (context)=> Center(child: CircularProgressIndicator())
                  ),

              ),
            ],
          ),
        );
      },
    );
  }
  Widget builderWidget(context, SearchModel model) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.58,
            children: List.generate(
              model.products.length,
                  (index) =>
                  buildGridProduct(model.products[index], context),
            ),
          ),
        ),

      ],
    ),
  );

  Widget buildGridProduct(ProductModel model, context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200.0,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  // if (model.discount != 0)
                  //   Text(
                  //     '${model.oldPrice.round()}',
                  //     style: TextStyle(
                  //       fontSize: 10.0,
                  //       color: Colors.grey,
                  //       decoration: TextDecoration.lineThrough,
                  //     ),
                  //   ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

}