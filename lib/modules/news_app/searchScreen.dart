
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/modules/news_app/cubit/cubit.dart';
import 'package:hello_flutter/modules/news_app/cubit/states.dart';
import 'package:hello_flutter/shared/components/components.dart';

class searchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<newsCubit, newsStates>(
      listener: (context, state) {},
      builder: (context, state){
        newsCubit cubit = newsCubit.getInstance(context);
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
                onChange: (value){
                  cubit.getSearch(value);
                }
              ),
              Expanded(
                  child: articleBuilder(

                    context: context,
                    isSearch: true,
                    list: cubit.searchList,
                  )
              ),
            ],
        ),
        );
      },
    );
  }


}