// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Cubit/Cubit.dart';
import 'package:todo_app/Cubit/Statts.dart';
import 'package:todo_app/Shared/components.dart';

// ignore: camel_case_types
class archivehome extends StatelessWidget {
  const archivehome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        final tasks = AppCubit.get(context).archive;
        return ConditionalBuilder(
          condition: tasks.isNotEmpty,
          builder: (context) {
            return ListView.separated(
              itemBuilder: (ctx, index) => defultTasks(tasks[index], context),
              separatorBuilder: ((context, index) => Container(
                    width: double.infinity,
                    height: 3,
                    color: Colors.grey,
                  )),
              itemCount: tasks.length,
            );
          },
          fallback: (context) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.archive_outlined,
                    size: 50,
                    color: Color.fromARGB(255, 55, 137, 148),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
