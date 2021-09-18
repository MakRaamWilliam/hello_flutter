
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/modules/to_do_app/archived_tasks.dart';
import 'package:hello_flutter/modules/to_do_app/cubit/cubit.dart';
import 'package:hello_flutter/modules/to_do_app/cubit/states.dart';
import 'package:hello_flutter/modules/to_do_app/done_tasks.dart';
import 'package:hello_flutter/modules/to_do_app/tasks.dart';
import 'package:hello_flutter/shared/components/components.dart';
import 'package:hello_flutter/shared/components/constans.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';


var scaffoldKey = GlobalKey<ScaffoldState>();
var taskNameController = TextEditingController();
var taskTimeController = TextEditingController();
var taskDateController = TextEditingController();
var formkeys = GlobalKey<FormState>();
List<String> navStatus = ["new","done","archive"];

bool isBottomSheetShow = false;

class home_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createToDoDataBase("new"),

        child: BlocConsumer<AppCubit, ToDoStates>(
            listener: (BuildContext context, ToDoStates state) {},
            builder: (BuildContext context, ToDoStates state) {
              AppCubit cubit = AppCubit.getInstance(context);

              return Scaffold(
                  key: scaffoldKey,
                  appBar: AppBar(
                    title: Text("TO DO App"),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      if (isBottomSheetShow) {
                        Navigator.pop(context);
                        isBottomSheetShow = false;
                      } else {
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
                                              prefix: Icons
                                                  .watch_later_outlined,
                                              onTap: () {
                                                showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                ).then((value) {
                                                  taskTimeController.text =
                                                      value!.format(context)
                                                          .toString();
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
                                                  lastDate: DateTime.parse(
                                                      '2025-01-01'),
                                                ).then((value) {
                                                  // taskDateController.text =
                                                  //     DateFormat.yMMMd().format(value);
                                                  taskDateController.text =
                                                      value!.day.toString() +
                                                          "-" +
                                                          value.month.toString()
                                                          + "-" +
                                                          value.year.toString();
                                                });
                                              }
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          defaultButton(
                                            onPressed: () {
                                              if (formkeys.currentState!
                                                  .validate()) {
                                                print("Task: " +
                                                    taskNameController.text);
                                                print("Time:" +
                                                    taskTimeController.text);
                                                print("Date:" +
                                                    taskDateController.text);
                                                cubit.insertIntoTasksTable(
                                                    title: taskNameController
                                                        .text,
                                                    time: taskTimeController
                                                        .text,
                                                    date: taskDateController
                                                        .text,
                                                  status: navStatus[cubit.navIndex],
                                                );

                                                Navigator.pop(context);
                                                isBottomSheetShow = false;
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
                    currentIndex: cubit.navIndex,
                    onTap: (index) {
                      cubit.selectAllFromTasksTable(navStatus[index]);
                      cubit.changeNavBar(index);
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
                      conditionBuilder: (context) =>
                      !(state is ToDoLoadingDBState)  ,
                      widgetBuilder: (context) =>
                      cubit.taskScreens[cubit.navIndex],
                      fallbackBuilder: (context) =>
                          Center(child: CircularProgressIndicator())
                  )


              );
            }
        )
    );
  }





  // void createDataBase() async {
  //   database = await openDatabase(
  //       "testDB.db",
  //       version: 1,
  //       onCreate: (db, version) async {
  //         db.execute(
  //             'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)'
  //         );
  //         print("DB is created");
  //       },
  //       onOpen: (db) {
  //         print("DB open is ${db.isOpen}");
  //         print("DB path: ${db.path}");
  //       }
  //
  //   );
  // }


  // Future<void> deleteAllFromTable() async {
  //   int count = await database.rawDelete('Delete FROM Test');
  //   print(count);
  // }

}
