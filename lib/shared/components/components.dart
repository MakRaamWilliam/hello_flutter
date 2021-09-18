import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/modules/to_do_app/cubit/cubit.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defultTextForm
(
{
  required TextEditingController controller,
  required TextInputType textInputType,
  Function(String value)?  onFieldSubmitted,
  InputDecoration? decoration,
  String validText ="Can not be empty!",

})
{
return TextFormField(
        controller: controller,
        keyboardType: textInputType,
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (value!.isEmpty)
            return validText;
          return null;
        },
        decoration: decoration,
        );

}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String value)? onSubmit,
  Function(String value)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required String validText,
  required String label,
  IconData? prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: (value) {
        if (value!.isEmpty)
          return validText;
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget TaskItem({
  required int id,
  required String title,
  required String time,
  required String date,
  required AppCubit cubit,
}){

  return
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
           Checkbox(
             value: false,
             onChanged: (newValue) {
               cubit.updateTasksTable(title: title, time: time, date: date,
                   newstatus: "done",
                   oldstatus: "new",
                 id: id,
               );
             }
           ),
          CircleAvatar(
            radius: 40.0,
            child: Center(
              child: Text(
                "$time",
              ),
            ),
            // backgroundColor: Colors.blueAccent,
          ),
          SizedBox(width: 15.0,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${title}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                    "${date}"
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    cubit.deleteTasksTable(
                      id: id,
                        title: title,
                        time: time,
                        date: date,
                        status: "new"
                    );
                  },
                  icon: Icon(Icons.delete),
                ),

                IconButton(
                    onPressed: (){
                      cubit.updateTasksTable(title: title, time: time, date: date,
                          newstatus: "archive",
                          oldstatus: "new",
                          id:id,
                      );

                    },
                    icon: Icon(Icons.archive)
                ),
              ],
            ),
          ),
        ],
      ),
    );

}

Widget DoneTaskItem({
  required int id,
  required String title,
  required String time,
  required String date,
  required AppCubit cubit,
}){

  return
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
              onPressed: () {
                cubit.deleteTasksTable(
                    id: id,
                    title: title,
                    time: time,
                    date: date,
                    status: "done"
                );
              },
            icon: Icon(Icons.delete),
          ),
          CircleAvatar(
            radius: 40.0,
            child: Center(
              child: Text(
                "$time",
              ),
            ),
            // backgroundColor: Colors.blueAccent,
          ),
          SizedBox(width: 15.0,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${title}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                    "${date}"
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: (){
                      cubit.updateTasksTable(title: title, time: time, date: date,
                          newstatus: "archive",
                          oldstatus: "done",
                        id: id,
                      );

                    },
                    icon: Icon(Icons.archive)
                ),
              ],
            ),
          ),
        ],
      ),
    );

}

Widget ArchieveTaskItem({
  required int id,
  required String title,
  required String time,
  required String date,
  required AppCubit cubit,
}){

  return
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              cubit.updateTasksTable(
                id: id,
                  title: title,
                  time: time,
                  date: date,
                  newstatus: "new",
                oldstatus: "archive"
              );
            },
            icon: Icon(Icons.add),
          ),
          CircleAvatar(
            radius: 40.0,
            child: Center(
              child: Text(
                "$time",
              ),
            ),
            // backgroundColor: Colors.blueAccent,
          ),
          SizedBox(width: 15.0,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${title}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                    "${date}"
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    cubit.deleteTasksTable(
                        id: id,
                        title: title,
                        time: time,
                        date: date,
                        status: "archive"
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ),
    );

}