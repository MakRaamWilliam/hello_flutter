import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/models/social_app/user_data.dart';
import 'package:hello_flutter/shared/components/constans.dart';

class ChatUser extends StatelessWidget {

  late SocialUserData user;
  late String userId;

  ChatUser({
    required this.user,
    required this.userId,
  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate:SliverChildListDelegate(
                [
                  Center(child: Container(
                      margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                      padding: EdgeInsets.all(8),
                      child: Text(
                          '${user.bio}',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                  )),
                  SizedBox(height: 500,)
                ]
              ),

          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          user.name,
        ),
        background: Hero(
          tag: userId,
          child: Image.network(
            user.image?? ProfImg,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }


}