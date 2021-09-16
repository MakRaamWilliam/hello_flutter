
import 'package:flutter/material.dart';
import 'package:hello_flutter/modules/to_do_app/archived_tasks.dart';
import 'package:hello_flutter/modules/to_do_app/done_tasks.dart';
import 'package:hello_flutter/modules/to_do_app/tasks.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/components/constans.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';



class home_screen extends StatefulWidget {
  @override
  _home_screenState createState() => _home_screenState();
}
int navIndex = 0;
List<Widget>     taskScreens = [
  tasks(), done_tasks(), archived_tasks()];
late Database database;

var scaffoldKey = GlobalKey<ScaffoldState>();
var taskNameController = TextEditingController();
var taskTimeController = TextEditingController();
var taskDateController = TextEditingController();
var formkeys = GlobalKey<FormState>();

bool isBottomSheetShow = false;

class _home_screenState extends State<home_screen> {

  @override
  void initState(){
       createToDoDataBase();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("TO DO App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(isBottomSheetShow){
            Navigator.pop(context);
            isBottomSheetShow = false;
          }else {
            isBottomSheetShow = true;
            scaffoldKey.currentState!.showBottomSheet(
                    (context) =>
                    SingleChildScrollView(
                      child: Form(
                        key: formkeys,
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                controller: taskNameController,
                                type: TextInputType.text,
                                validText: "name can not be empty",
                                label: "task name",
                                prefix: Icons.title,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaultFormField(
                                  controller: taskTimeController,
                                  type: TextInputType.datetime,
                                  validText: "Time can not be empty",
                                  label: "task time",
                                  prefix: Icons.watch_later_outlined,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      taskTimeController.text =
                                          value!.format(context).toString();
                                      print(value.format(context));
                                    });
                                  }
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaultFormField(
                                  controller: taskDateController,
                                  type: TextInputType.datetime,
                                  validText: "Date can not be empty",
                                  label: "task Date",
                                  prefix: Icons.date_range,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2025-01-01'),
                                    ).then((value) {
                                      // taskDateController.text =
                                      //     DateFormat.yMMMd().format(value);
                                      taskDateController.text =
                                          value!.day.toString() + "-" +
                                              value.month.toString()
                                              + "-" + value.year.toString();
                                    });
                                  }
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaultButton(
                                  onPressed: (){
                                    if(formkeys.currentState!.validate()) {
                                      print("Task: " + taskNameController.text);
                                      print("Time:" + taskTimeController.text);
                                      print("Date:" + taskDateController.text);
                                      insertIntoTasksTable(
                                          title: taskNameController.text,
                                          time: taskTimeController.text,
                                          date: taskDateController.text
                                      );
                                    }

                                  },
                                  text: "add",
                              )

                            ],
                          ),
                        ),
                      ),
                    )
            );
          }
        },
        child: Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomNavigationBar(
       elevation: 15.0,
        currentIndex: navIndex,
        onTap: (index){
         setState(() {
           navIndex = index;
           print(navIndex);
         });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
            label: "To do"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.offline_pin),
            label: "Done"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive),
            label: "Archived"
          ),

        ],
      ),
      body: Conditional.single(
          context: context,
          conditionBuilder:(context)=> taskslist.length > 0,
          widgetBuilder: (context)=> taskScreens[navIndex],
          fallbackBuilder: (context)=> Center(child: CircularProgressIndicator())
      )
          // Column(
          //   children: [
          //     taskScreens[navIndex],
          //     IconButton(
          //         onPressed: (){
          //           selectAllFromTasksTable();
          //         },
          //       icon: Icon(Icons.search),
          //       color: Colors.green,
          //       iconSize: 40.0,
          //     ),
          //     IconButton(
          //       onPressed: (){
          //         deleteAllFromTable();
          //       },
          //       icon: Icon(Icons.remove),
          //       color: Colors.red,
          //       iconSize: 40.0,
          //
          //     ),
          //
          //
          //   ],
          // )

    );
  }

  void createDataBase() async{
    database = await openDatabase(
      "testDB.db",
      version: 1,
      onCreate: (db,version) async{
        db.execute(
            'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)'
        );
        print("DB is created");
      },
      onOpen: (db){
        print("DB open is ${db.isOpen}");
        print("DB path: ${db.path}");
    }

    );
    }
  void createToDoDataBase() async{
    database = await openDatabase(
        "todo.db",
        version: 1,
        onCreate: (db,version) async{
          db.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT,status TEXT)'
          );
          print("todo DB is created");
        },
        onOpen: (db) async {
          print("DB open is ${db.isOpen}");
          print("DB path: ${db.path}");
          db.rawQuery('SELECT * FROM tasks').then((value) {
            taskslist = value;

            return value;
          }
          );
          print(taskslist.length);
        }

    );

  }
  Future<void> insertIntoTasksTable({
     required String title,
     required String time,
     required String date,
     }) async {
     database.transaction( (txn) async {
       txn.rawInsert(
          'INSERT INTO tasks(title, time, date,status) VALUES("$title", "$time","$date","new")').then(
              (insertvalue) {
                database.rawQuery('SELECT * FROM tasks').then( (selectvalue) {
                  Navigator.pop(context);
                  setState(() {
                    isBottomSheetShow = false;
                    taskslist = selectvalue;
                  });
                  return selectvalue;
                });
              });
    });
  }
  Future<List<Map>> selectAllFromTasksTable() async {
     taskslist = await database.rawQuery('SELECT * FROM tasks');
     print(taskslist);
     return taskslist;
  }
  Future<void> deleteAllFromTable() async {
    int count = await database.rawDelete('Delete FROM Test');
    print(count);
  }

}
