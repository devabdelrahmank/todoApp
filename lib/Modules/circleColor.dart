// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todo_app/Cubit/Cubit.dart';

class CircleColor extends StatefulWidget {
  const CircleColor({
    super.key,
    required this.selectColor,
  });
  final int selectColor;
  @override
  State<CircleColor> createState() => _CircleColorState();
}

class _CircleColorState extends State<CircleColor> {
  int selectColor = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            AppCubit.get(context).changeColor(index);
            // print('index=$index');
            print('Select_color=${AppCubit.get(context).Select_color}');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: index == 0
                  ? Colors.black
                  : index == 1
                      ? const Color.fromARGB(255, 55, 137, 148)
                      : index == 2
                          ? Colors.blue
                          : index == 3
                              ? Colors.green
                              : Colors.red,
              child: selectColor == index
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
    );
  }
}
