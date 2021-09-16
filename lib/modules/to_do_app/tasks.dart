
import 'package:flutter/material.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/components/constans.dart';

class tasks extends StatefulWidget{


  @override
  _tasksState createState() => _tasksState();
}

class _tasksState extends State<tasks> {
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
        itemBuilder: (context, index){
          print( "lis len in tasks class = ${taskslist.length}" );
          return TaskItem(
            title: taskslist[index]["title"],
            date: taskslist[index]["time"],
            time: taskslist[index]["date"],
          );
        },
        separatorBuilder:(context,index) => Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ),
        itemCount: taskslist.length
    );
  }
}