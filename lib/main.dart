import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:FlutterToDoList/data/manipulating-data.dart';

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
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime _dateTime;

  List toDoList = ManipulatingData.toDoList;
  var format = new DateFormat("dd/MM/yyyy");

  _createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
              elevation: 15.0,
              title: Text("Name your task"),
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Container(
                        height: 250.0,
                        child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              TextFormField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                  hintText: 'Type the title',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please, enter some text";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              TextFormField(
                                controller: descController,
                                decoration: const InputDecoration(
                                  hintText: 'Type the description',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please, enter some text";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              TextFormField(
                                controller: dateController,
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2022))
                                      .then((date) {
                                    setState(() {
                                      _dateTime = date;
                                      dateController.text = format.format(date);
                                    });
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: 'Select the due date'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please, select the due date";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: RaisedButton(
                                      color: Colors.lightBlueAccent,
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            ManipulatingData.addToDo(
                                                titleController.text,
                                                descController.text,
                                                dateController.text);
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                      child: Text('Submit')))
                            ]))))
              ]);
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
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(toDoList[index]["title"]),
            value: toDoList[index]["ok"],
            subtitle: Text(toDoList[index]["desc"]),
            secondary: Column(children: <Widget>[
              Icon(toDoList[index]["ok"] ? Icons.check : Icons.error),
              Text(
                "Due date:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              Text(
                toDoList[index]["date"],
                style: TextStyle(fontSize: 10.0),
              ),
            ]),
            onChanged: (bool value) {
              setState(() {
                toDoList[index]["ok"] = value;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _createAlertDialog(context);
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
