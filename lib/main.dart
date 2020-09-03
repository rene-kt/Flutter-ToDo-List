import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = ['Renê', 'Ludy'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("To-Do List"),
          backgroundColor: Colors.lightBlueAccent,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: _toDoList.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(_toDoList[index]),
              value: _toDoList[index]["ok"],
              secondary: CircleAvatar(
                child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
              ),
              onChanged: (bool value) {},
            );
          },
        ));

    // ignore: dead_code

    Future<File> _getFile() async {
      final directory = await getApplicationDocumentsDirectory();
      return File("${directory.path}/data.json");
    }

    Future<File> _saveData() async {
      String data = json.encode(_toDoList);
      final file = await _getFile();
      return file.writeAsString(data);
    }

    Future<String> _readData() async {
      try {
        final file = await _getFile();

        return file.readAsString();
      } catch (e) {
        return "erro: " + e;
      }
    }
  }
}
