import 'package:flutter/material.dart';
import 'package:FlutterToDoList/data/manipulating-data.dart';

class ItemBuilder extends StatefulWidget {
  @override
  _ItemBuilderState createState() => _ItemBuilderState();
}

class _ItemBuilderState extends State<ItemBuilder> {
  List toDoList = ManipulatingData.toDoList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment(-0.9, 0.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            direction: DismissDirection.startToEnd,
            key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
            child: CheckboxListTile(
              title: Text(ManipulatingData.toDoList[index]["title"]),
              value: ManipulatingData.toDoList[index]["ok"],
              subtitle: Text(ManipulatingData.toDoList[index]["desc"]),
              secondary: Column(children: <Widget>[
                Icon(ManipulatingData.toDoList[index]["ok"]
                    ? Icons.check
                    : Icons.error),
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
            ),
            onDismissed: (direction) {
              setState(() {
                ManipulatingData.removingData(index);

                final snack = SnackBar(
                  content: Text(
                      "Task: \"${ManipulatingData.lastRemoved["title"]}\" removed"),
                  action: SnackBarAction(
                    label: "Undo",
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        ManipulatingData.toDoList.insert(
                            ManipulatingData.lastRemovedPosition,
                            ManipulatingData.lastRemoved);
                        ManipulatingData.saveData();
                      });
                    },
                  ),
                  duration: Duration(seconds: 4),
                  backgroundColor: Colors.lightBlueAccent,
                );
                Scaffold.of(context).showSnackBar(snack);
              });
            },
          );
        });
  }
}
