import 'package:flutter/material.dart';
import 'package:FlutterToDoList/data/manipulating-data.dart';
import 'package:FlutterToDoList/widgets/item-builder.widget.dart';
import 'package:intl/intl.dart';

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
  List toDoList = ManipulatingData.toDoList;

  var format = new DateFormat("dd/MM/yyyy");
  DateTime dateTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Widget createAlertDialog(context) {
    return SimpleDialog(title: Text("Name your task"), children: <Widget>[
      Form(
          key: formKey,
          child: Container(
              height: 250.0,
              width: 300.0,
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
                            dateTime = date;
                            dateController.text = format.format(date);
                          });
                        });
                      },
                      decoration:
                          InputDecoration(hintText: 'Select the due date'),
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
                              if (formKey.currentState.validate()) {
                                setState(() {
                                  ManipulatingData.addToDo(titleController.text,
                                      descController.text, dateController.text);
                                  Navigator.of(context).pop();
                                });
                              }
                            },
                            child: Text('Submit')))
                  ]))))
    ]);
  }

  showAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return createAlertDialog(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ItemBuilder(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showAlertDialog(context);
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
