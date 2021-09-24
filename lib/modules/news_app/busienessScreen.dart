import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hello_flutter/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class businessScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<newsCubit, newsStates>(
      listener: (context,state) {},
      builder: (context,state){
        return Conditional.single(
            context: context,
            conditionBuilder: (context)=> newsCubit.getInstance(context).businessList.length == 0,
            widgetBuilder: (context)=> Center(child: CircularProgressIndicator()),
            fallbackBuilder: (context)=> articleBuilder(

              context: context,
              isSearch: true,
              list: newsCubit.getInstance(context).businessList,
            )
        );

      },

    );
  }


}