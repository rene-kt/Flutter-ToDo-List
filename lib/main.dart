import 'package:flutter/material.dart';
import 'package:FlutterToDoList/data/manipulating-data.dart';
import 'package:FlutterToDoList/widgets/item-builder.widget.dart';
import 'package:FlutterToDoList/widgets/alert-dialog.widget.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return ShowAlertDialog();
        });
  }
}

class _HomeState extends State<Home> {
  List toDoList = ManipulatingData.toDoList;

  refreshingThePage(String title, String desc, String date) {
    setState(() {
      ManipulatingData.addToDo(title, desc, date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: ItemBuilder(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          createAlertDialog(context);
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
