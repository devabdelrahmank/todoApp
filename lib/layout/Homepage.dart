// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Cubit/Cubit.dart';
import 'package:todo_app/Cubit/Statts.dart';
import 'package:todo_app/Shared/components.dart';

// ignore: must_be_immutable, camel_case_types
class Home_page extends StatelessWidget {
  Home_page({super.key});

  // ignore: non_constant_identifier_names
  int Select_Color = 0;

  //
  TextEditingController titleControler = TextEditingController();

  TextEditingController noteControler = TextEditingController();

  //
  var scafffoldKey = GlobalKey<ScaffoldState>();

  var formkeey = GlobalKey<FormState>();

  //
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is AppInsertDatabase) {
            Navigator.pop(context);
            formkeey.currentState!.reset();
          }
        },
        builder: (context, state) => Scaffold(
          key: scafffoldKey,
          appBar: AppBar(
            title: Text(
              AppCubit.get(context).ttitle[AppCubit.get(context).currentindex],
            ),
            backgroundColor: const Color.fromARGB(255, 55, 137, 148),
          ),
          //
          body:
              AppCubit.get(context).Screen[AppCubit.get(context).currentindex],
          //
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).currentindex,
            backgroundColor: const Color.fromARGB(255, 55, 137, 148),
            onTap: (index) {
              AppCubit.get(context).currentBottomNavigation(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: 'Tasks'),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.done_all,
                  color: Colors.white,
                ),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive,
                  color: Colors.white,
                ),
                label: 'Archive',
              ),
            ],
          ),
          //
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //   print('Select_Color=$Select_Color');
              if (AppCubit.get(context).isShowen) {
                if (formkeey.currentState!.validate()) {
                  AppCubit.get(context).insertDatabase(
                    Select_color: Select_Color,
                    title: titleControler.text,
                    note: noteControler.text,
                  );
                }
              } else {
                scafffoldKey.currentState!
                    .showBottomSheet((context) => SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: Form(
                            key: formkeey,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      children:
                                          List<Widget>.generate(5, (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Select_Color = index;
                                            // print('index=$index');
                                            print('index=$Select_Color');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor: index == 0
                                                  ? Colors.black
                                                  : index == 1
                                                      ? const Color.fromARGB(
                                                          255, 55, 137, 148)
                                                      : index == 2
                                                          ? Colors.blue
                                                          : index == 3
                                                              ? Colors.green
                                                              : Colors
                                                                  .deepOrange,
                                              child: Select_Color == index
                                                  ? const Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )
                                                  : Container(),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: defultTextFromFiled(
                                        controller: titleControler,
                                        text: 'Title',
                                        iconDataPrifix: Icons.title,
                                        valeditor: (value) {
                                          if (value!.isEmpty) {
                                            return 'enter any title';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: defultTextFromFiled(
                                        controller: noteControler,
                                        text: 'Note',
                                        iconDataPrifix: Icons.notes_outlined,
                                        valeditor: (p0) {
                                          if (p0!.isEmpty) {
                                            return 'Enter Any Note ';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ))
                    .closed
                    .then((value) {
                  AppCubit.get(context)
                      .changeIconShoww(isSHOW: false, icon: Icons.edit);
                });
                AppCubit.get(context)
                    .changeIconShoww(isSHOW: true, icon: Icons.add);
              }
            },
            backgroundColor: const Color.fromARGB(255, 55, 137, 148),
            child: Icon(AppCubit.get(context).iconData),
          ),
        ),
      ),
    );
  }
}
