import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Messenger extends StatelessWidget {

  var names = ["Hossam Eldin","Mohamed Khaled","Mahmoud elsayed","Ahmed Ali",
               "Walid Zattot","Islam Ahmed","Hassan Abdlhamed","Fares Mhs"];

  Widget StoryBulider(){

    return
      Container(
      width: 50.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage("http://www.martacitterio.it/wp-content/uploads/2019/01/person2.jpg")
              ),
              CircleAvatar(
                radius: 5.0,
                backgroundColor: Colors.green,
              ),

            ],
          ),
          Text(""
              "Abdullah Mansour",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

  }
  Widget ChatBuilder(var name){
    return
      Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage("http://www.martacitterio.it/wp-content/uploads/2019/01/person2.jpg")
              ),
              CircleAvatar(
                radius: 5.0,
                backgroundColor: Colors.green,
              ),

            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Container(
            width: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                  ),
                ),
                Container(
                  child: Text(
                    "This is a message from Abdullah Mansour it is long",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          )

        ],
      );

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 20.0,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage("http://www.martacitterio.it/wp-content/uploads/2019/01/person2.jpg")
              ),
              SizedBox(
                width: 15.0,
              ),
             Text(
                 "Chats",
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 25.0,
                 color: Colors.black
               ),
             )
            ],
          ),
          actions: [
            IconButton(
              icon: CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.camera_alt
                ),
              ), onPressed: () {
                print("camera Pressed");
            },
            ),
            IconButton(
              icon: CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.blue,
                child: Icon(
                    Icons.edit
                ),
              ), onPressed: () {
              print("edit Pressed");
            },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  height: 30.0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      Text(
                         "search",
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        height: 100.0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index) {
                              return StoryBulider();
                            },
                            separatorBuilder: (context,index) {
                              return SizedBox(width: 8.0,);
                            },
                            itemCount: 15),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: [
                  ListView.separated(
                    shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return ChatBuilder(names[index]);
                      },
                      separatorBuilder: (context, index){
                        return SizedBox(height: 10.0,);
                      },
                      itemCount: 8)

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}