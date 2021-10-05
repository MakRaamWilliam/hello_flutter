
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hello_flutter/layout/social_app/cubit/cubit.dart';
import 'package:hello_flutter/layout/social_app/cubit/states.dart';
import 'package:hello_flutter/shared/components/constans.dart';
import 'package:hello_flutter/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        SocialCubit cubit = SocialCubit.getInstance(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News Feeds',
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  // NavgPushTo(context, SearchScreen(),);
                },
              ),
            ],
          ),
          body: Conditional.single(
             context: context,
            conditionBuilder: (context) =>
            cubit.posts.length > 0  ,
            widgetBuilder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: EdgeInsets.all(
                      8.0,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                          ),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'communicate with friends',
                            // style: Theme.of(context).textTheme.subtitle1.copyWith(
                            //   color: Colors.white,
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(context,index,cubit.posts),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8.0,
                    ),
                    itemCount: cubit.posts.length,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
            fallbackBuilder: (context)=> Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildPostItem(context,index,posts) {
    SocialCubit cubit = SocialCubit.getInstance(context);
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            posts[index]['name'],
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                        posts[index]['dateTime'],
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              posts[index]['text'],
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
            ),
            if(posts[index]['postImage'] != null &&
                posts[index]['postImage'] != "" )
              Container(
                height: 400.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        posts[index]['postImage']
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                                  cubit.postsLikes[index].toString(),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat,
                              size: 16.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              cubit.postsComments[index].toString(),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(
                          userData.image ?? ProfImg
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Container(
                      width: 200,
                      child:
                      TextFormField(
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: ('write a comment ...'),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    cubit.commentClick(index, commentController.text);
                    commentController.text = "";
                  },
                ) ,
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                       cubit.myLikes[index]? Icons.favorite :Icons.favorite_border,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption,
                      ),
                    ],
                  ),
                  onTap: () {
                    if(cubit.myLikes[index])
                       cubit.dislikeClick(index);
                    else
                      cubit.likeClick(index);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
