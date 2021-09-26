import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_flutter/modules/news_app/webPageScreen.dart';
import 'package:hello_flutter/modules/to_do_app/cubit/cubit.dart';
import 'package:hello_flutter/modules/to_do_app/cubit/states.dart';


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


void NavgPushTo(context,Widget widget){


    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context){
            return widget;
          },
        )
    );

}

void NavgPushToAndFinish(context,Widget widget){

  Navigator.pushAndRemoveUntil(
       context,
      MaterialPageRoute(
        builder: (context){
          return widget;
        },
      ),
       (Route<dynamic> route)=> false,
  );

}

void defaultToast({
  required String msg,
  Toast length = Toast.LENGTH_SHORT,
  Color color = Colors.red,
  Color textColor = Colors.white,
  double fontSize = 16.0,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: length,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: textColor,
      fontSize: fontSize
  );


}


Widget TaskItem({
  required int id,
  required String title,
  required String time,
  required String date,
  required ToDoAppCubit cubit,
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
  required ToDoAppCubit cubit,
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
  required ToDoAppCubit cubit,
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

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 2.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(
    List<dynamic> list,
    index,
    context,
    )
{
  return InkWell(
    onTap: (){
      NavgPushTo(context, webPageScreen(url: list[index]['url']));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: NetworkImage(
                  list[index]["urlToImage"] != null? '${list[index]["urlToImage"]}' :
                  'https://neteco.gr/wp-content/uploads/2019/09/technews.jpg'
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${list[index]["title"]} ",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1 ,
              ),
              Text( list[index]["author"] != null? "${list[index]["author"]}": "" ,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text( list[index]["publishedAt"] != null? "${list[index]["publishedAt"]}": "" ,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

            ],
          ),
        ),

      ],
    ),
  );
}

Widget articleBuilder({
   required List<dynamic> list,
   required context,
   required isSearch,
  }
    ) =>
    Conditional.single(
      context: context,
      conditionBuilder:(context) => true,
      widgetBuilder: (context) =>
          ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildArticleItem(list,index,context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: list.length,
          ),
      fallbackBuilder: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),

    );