import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hello_flutter/layout/social_app/cubit/cubit.dart';
import 'package:hello_flutter/layout/social_app/cubit/states.dart';
import 'package:hello_flutter/models/social_app/user_data.dart';
import 'package:hello_flutter/modules/social_app/edit_profile.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/components/constans.dart';
import 'package:image_picker/image_picker.dart';

class SocialUserScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        SocialCubit cubit = SocialCubit.getInstance(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              4.0,
                            ),
                            topRight: Radius.circular(
                              4.0,
                            ),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              CoverImg,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                          userData.image??ProfImg,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                userData.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                userData.bio??"bio",
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '265',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '64',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Add Photos',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      NavgPushTo(context, EditProfile(userData: userData,),);
                    },
                    child: Icon(
                      Icons.edit,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );


  }


}