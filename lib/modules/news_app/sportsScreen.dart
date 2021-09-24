import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hello_flutter/modules/news_app/cubit/cubit.dart';
import 'package:hello_flutter/modules/news_app/cubit/states.dart';
import 'package:hello_flutter/shared/components/components.dart';

class sporstScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<newsCubit, newsStates>(
      listener: (context,state) {},
      builder: (context,state){
        return Conditional.single(
            context: context,
            conditionBuilder: (context)=> state is ! NewsGetSportsSuccessState,
            widgetBuilder: (context)=> Center(child: CircularProgressIndicator()),
            fallbackBuilder: (context)=> articleBuilder(

                context: context,
              isSearch: true,
              list: newsCubit.getInstance(context).sportsList,
            )
        );

      },

    );

  }


}