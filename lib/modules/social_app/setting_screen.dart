import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/layout/social_app/cubit/cubit.dart';
import 'package:hello_flutter/layout/social_app/cubit/states.dart';
import 'package:hello_flutter/modules/social_app/social_log_in.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/network/local/cacheHelper.dart';
import 'package:bloc/bloc.dart';

class SocialSetting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){

        return  Column(
          children: [
            Text("Setting"),
            TextButton(
                onPressed: () {
                  CacheHelper.removeData(key: "uid");
                  SocialCubit.getInstance(context).logOutClick();
                  NavgPushToAndFinish(context, SocialLogInScreen());
                },
                child: Text("Log out")
            ),

          ],
        );
      },
    );

  }


}