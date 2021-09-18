
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hello_flutter/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class archived_tasks extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, ToDoStates>(
        listener: (BuildContext context, ToDoStates state) {},
        builder: (BuildContext context, ToDoStates state) {
          var taskslist = AppCubit.getInstance(context).taskslist;

          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>taskslist.length == 0 ,
            widgetBuilder: (context) =>
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        size: 100.0,
                        color: Colors.grey,
                      ),
                      Text(
                        'No Tasks Yet, Please Add Some Tasks',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
            fallbackBuilder: (context) =>
                ListView.separated(
                    itemBuilder: (context, index) {
                      return ArchieveTaskItem(
                        id: taskslist[index]["id"],
                        title: taskslist[index]["title"],
                        date: taskslist[index]["time"],
                        time: taskslist[index]["date"],
                        cubit: AppCubit.getInstance(context),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                    itemCount: taskslist.length
                )

          );
        }
    );
  }


}