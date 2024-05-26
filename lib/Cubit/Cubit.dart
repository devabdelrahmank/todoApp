// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Cubit/Statts.dart';
import 'package:todo_app/Modules/Archivehome.dart';
import 'package:todo_app/Modules/Donefilehome.dart';
import 'package:todo_app/Modules/Taskshome.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
//

  int currentindex = 0;
  List<Widget> Screen = [
    const Taskhome(),
    const Donehome(),
    const archivehome(),
  ];
  List<String> ttitle = [
    "Tasks",
    "Done ",
    "Archive",
  ];

  void currentBottomNavigation(int index) {
    currentindex = index;
    emit(AppChangeBottomNav());
  }

//
  int Select_color = 0;
  void select_Color(int index) {
    Select_color == index
        ? const Icon(
            Icons.done,
            color: Colors.white,
            size: 20,
          )
        : Container();

    emit(ColorChange());
  }

  List<Map> newtaskks = [];
  List<Map> done = [];
  List<Map> archive = [];

  Database? database;
  void createDatabase() {
    openDatabase(
      'todddo.db',
      version: 1,
      onCreate: (database, version) {
//id int
//color String
//title String
//note  String

        database
            .execute(
                'CREATE TABLE taskk(id INTEGER PRIMARY KEY, color INTEGER,title TEXT, note TEXT, status TEXT)')
            .then((value) {})
            .catchError((Error) {});
      },
      onOpen: (database) {
        getDataFromdatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCrateDatabase());
    });
  }

  insertDatabase({
    required int Select_color,
    required String title,
    required String note,
  }) {
    database?.transaction((txn) {
      return txn
          .rawInsert(
              "INSERT INTO taskk(color,title,note,status) VALUES($Select_color,'$title','$note','new') ")
          .then((value) {
        emit(AppInsertDatabase());

        getDataFromdatabase(database);
      }).catchError((error) {});
    });
  }

  void getDataFromdatabase(database) {
    newtaskks = [];
    done = [];
    archive = [];

    database!.rawQuery("SELECT * FROM taskk").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newtaskks.add(element);
        else if (element['status'] == 'done')
          done.add(element);
        else
          archive.add(element);
      });

      emit(AppGetDatabase());
    });
  }

  void updateDatbase({
    required String status,
    required int id,
  }) {
    database!.rawUpdate(
        'UPDATE taskk SET status = ? WHERE id = ?', [status, id]).then((value) {
      getDataFromdatabase(database);
      emit(AppUpdateDatabase());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM taskk WHERE id = ?', [id]).then((value) {
      getDataFromdatabase(database);
      emit(AppDeleteDatabase());
    });
  }

  //
  bool isShowen = false;
  IconData iconData = Icons.edit;
  //
  void changeIconShoww({
    required bool isSHOW,
    required IconData icon,
  }) {
    isShowen = isSHOW;
    iconData = icon;
    emit(ChangeIconShow());
  }

  int Colornum = 0;
  void changeColor(index) {
    Colornum = index;
    emit(ChangColor());
  }
  //
}
