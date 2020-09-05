import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class ManipulatingData {
  static List toDoList = [];

  static Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  static Future<File> saveData() async {
    String data = json.encode(toDoList);
    final file = await getFile();
    return file.writeAsString(data);
  }

  static Future<String> readData() async {
    try {
      final file = await getFile();

      return file.readAsString();
    } catch (e) {
      return "erro: " + e;
    }
  }

  static void addToDo(String title, String desc, String date) {
    Map<String, dynamic> newToDo = Map();
    newToDo["title"] = title;
    newToDo["desc"] = desc;
    newToDo["date"] = date;
    newToDo["ok"] = false;
    toDoList.add(newToDo);
    saveData();
  }
}
