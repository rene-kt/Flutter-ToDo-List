import 'package:flutter/material.dart';
import 'package:FlutterToDoList/data/manipulating-data.dart';

class ItemBuilder extends StatefulWidget {
  @override
  _ItemBuilderState createState() => _ItemBuilderState();
}

class _ItemBuilderState extends State<ItemBuilder> {
  List toDoList = ManipulatingData.toDoList;

  Widget buildItem(context, index) {
    return CheckboxListTile(
      title: Text(ManipulatingData.toDoList[index]["title"]),
      value: ManipulatingData.toDoList[index]["ok"],
      subtitle: Text(ManipulatingData.toDoList[index]["desc"]),
      secondary: Column(children: <Widget>[
        Icon(
            ManipulatingData.toDoList[index]["ok"] ? Icons.check : Icons.error),
        Text(
          "Due date:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
        Text(
          ManipulatingData.toDoList[index]["date"],
          style: TextStyle(fontSize: 10.0),
        ),
      ]),
      onChanged: (bool value) {
        setState(() {
          ManipulatingData.toDoList[index]["ok"] = value;
          ManipulatingData.saveData();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return buildItem(context, index);
        });
  }
}
