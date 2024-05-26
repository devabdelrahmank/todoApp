import 'package:flutter/material.dart';
import 'package:todo_app/Cubit/Cubit.dart';

Widget defultTextFromFiled({
  bool obscureText = false, // T
  TextEditingController? controller, // T
  String? text, // T
  IconData? iconDataPrifix, // T
  Color? containerColor, // T
  Function()? onTap, // T
  TextInputType? type, // T
  String? Function(String?)? valeditor, // T
  double radius = 12, // T
  double? fontSizelabel, // T
  InputBorder border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12))), // T
  Color? colorstyle, // T
}) {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
      color: containerColor,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: TextFormField(
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(
            fontSize: fontSizelabel,
            fontWeight: FontWeight.bold,
            color: colorstyle),
        prefixIcon: Icon(iconDataPrifix),
        border: border,
      ),
      keyboardType: type,
      obscureText: obscureText,
      controller: controller,
      validator: valeditor,
      onTap: onTap,
    ),
  );
}

Widget defultTasks(Map model, BuildContext context) {
  return
      // backgroundColor: Color.fromARGB(255, 66, 74, 75),
      // appBar: AppBar(
      //   title: Text('hellow'),
      //   backgroundColor: Colors.black,
      // ),
      // body:
      Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 30),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color.fromARGB(255, 255, 233, 64),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22),
                      ),
                      color: model['color'] == 0
                          ? Colors.black
                          : model['color'] == 1
                              ? const Color.fromARGB(255, 55, 137, 148)
                              : model['color'] == 2
                                  ? Colors.blue
                                  : model['color'] == 3
                                      ? Colors.green
                                      : Colors.deepOrange,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      //   decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            model['title'],
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 55, 137, 148)),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            model['note'],
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .updateDatbase(status: 'archive', id: model['id']);
                  },
                  icon: const Icon(
                    Icons.archive,
                    size: 30,
                    color: Color.fromARGB(255, 55, 137, 148),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .updateDatbase(status: 'done', id: model['id']);
                  },
                  icon: const Icon(
                    Icons.done_outline_outlined,
                    size: 30,
                    color: Color.fromARGB(255, 55, 137, 148),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
//model['color']