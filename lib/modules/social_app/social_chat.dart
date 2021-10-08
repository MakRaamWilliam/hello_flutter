import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hello_flutter/layout/social_app/cubit/cubit.dart';
import 'package:hello_flutter/layout/social_app/cubit/states.dart';
import 'package:hello_flutter/layout/social_app/social_app_layout.dart';
import 'package:hello_flutter/models/shop_model/login_model.dart';
import 'package:hello_flutter/models/social_app/user_data.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/components/constans.dart';

import 'chat_body.dart';

class SocialChat extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SocialCubit cubit = SocialCubit.getInstance(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Chats"),
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder:(context)=> state is SocialSuccessAllUserDataState,
              widgetBuilder:(context)=> ListView.separated(
                  itemBuilder:(context,index) =>  itemBuilder(
                    context: context,users: cubit.users,
                      index: index,usersId: cubit.usersId,
                  ),
                  separatorBuilder: (context,index) => myDivider(),
                  itemCount: cubit.users.length,
              ),
              fallbackBuilder: (context)=> Center(child: CircularProgressIndicator())
            ),
          );
        }
    );
  }
  Widget itemBuilder({
  required context,
  required List<SocialUserData> users,
  required List<String> usersId,

    required int index,
}){

    return  InkWell(
      onTap: (){
        NavgPushTo(context, ChatBody(
            user: users[index], userId: usersId[index],),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              backgroundImage: NetworkImage(
                  users[index].image??ProfImg
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child:  Text(
                users[index].name,
                style: Theme.of(context).textTheme.bodyText1
              ),
            ),
          ],
        ),
      ),
    );

  }
}