
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/modules/to_do_app/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../archived_tasks.dart';
import '../done_tasks.dart';
import '../tasks.dart';

class ToDoAppCubit extends Cubit<ToDoStates>{
  ToDoAppCubit() : super(ToDoInitialState());

  int navIndex = 0;
  List<Widget>     taskScreens = [tasks(), done_tasks(), archived_tasks()];
  List<Map> taskslist = [];
  late Database database;

  static ToDoAppCubit getInstance(context) => BlocProvider.of(context);

  void changeNavBar(int index){
    navIndex = index;
    emit(ToDoChangeBottomNavBarState());
  }

  void createToDoDataBase(String status)  {

    openDatabase(
        "todo.db",
        version: 1,
        onCreate: (db, version) async {
          db.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT,status TEXT)'
          );
          print("todo DB is created");
        },
        onOpen: (db) async {
          emit(ToDoLoadingDBState());
          print("DB open is ${db.isOpen}");
          print("DB path: ${db.path}");
          db.rawQuery('SELECT * FROM tasks where status = "$status" ').then((value) {
            taskslist = value;
            // print(taskslist);
            emit(ToDoGetDBState());
          }
          );
        }
    ).then((value) {
      database = value;
      emit(ToDoCreateDBState());
    });
  }

  Future<void> insertIntoTasksTable({
    required String title,
    required String time,
    required String date,
    required String status,
  }) async {
    database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title, time, date,status) VALUES("$title", "$time","$date","new")')
          .then(
              (insertvalue) {
                emit(ToDoInsertDBState());
                selectAllFromTasksTable(status);
          });
    });
  }

  Future<void> updateTasksTable({
    required int id,
    required String title,
    required String time,
    required String date,
    required String newstatus,
    required String oldstatus,
  }) async {
    database.rawUpdate(
        'UPDATE tasks SET status = "$newstatus" WHERE id = $id  '
    ).then(
              (updatevalue) {
            print(updatevalue);

            emit(ToDoUpdateDBState());
            selectAllFromTasksTable(oldstatus);
          });

  }

  Future<void> deleteTasksTable({
    required int id,
    required String title,
    required String time,
    required String date,
    required String status,
  }) async {
    database.rawUpdate(
        'delete from tasks WHERE id = $id '
    ).then(
            (deletevalue) {
          print(deletevalue);

          emit(ToDoUpdateDBState());
          selectAllFromTasksTable(status);
        });

  }


  void selectAllFromTasksTable(String status)  {

      database.rawQuery('SELECT * FROM tasks where status = "$status"').then((value) {
        taskslist = value;
        emit(ToDoGetDBState());
      });
  }


}