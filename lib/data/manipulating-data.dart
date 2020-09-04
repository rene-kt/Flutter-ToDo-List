import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class ManipulatingData {
  static List toDoList = [];

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> saveData() async {
    String data = json.encode(toDoList);
    final file = await getFile();
    return file.writeAsString(data);
  }

  Future<String> readData() async {
    try {
      final file = await getFile();

      return file.readAsString();
    } catch (e) {
      return "erro: " + e;
    }
  }

  static void addToDo(String title, String desc, String date) {
    print("ENTROU NO METODO");
    Map<String, dynamic> newToDo = Map();
    newToDo["title"] = title;
    newToDo["desc"] = desc;
    newToDo["date"] = date;
    newToDo["ok"] = false;
    toDoList.add(newToDo);
  }
}
