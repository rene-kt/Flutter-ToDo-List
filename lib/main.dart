import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
}

class _HomeState extends State<Home> {
  List toDoList = ManipulatingData.toDoList;
  ShowAlertDialog alert = ShowAlertDialog();

  Widget returnTextField() {
    return TextFormField(
      controller: alert.dateController,
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2022))
            .then((date) {
          setState(() {
            alert.dateTime = date;
            alert.dateController.text = alert.format.format(date);
          });
        });
      },
      decoration: InputDecoration(hintText: 'Select the due date'),
      validator: (value) {
        if (value.isEmpty) {
          return "Please, select the due date";
        } else {
          return null;
        }
      },
    );
  }

  Widget returnPadding() {
    return Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: RaisedButton(
            color: Colors.lightBlueAccent,
            onPressed: () {
              if (alert.formKey.currentState.validate()) {
                setState(() {
                  ManipulatingData.addToDo(alert.titleController.text,
                      alert.descController.text, alert.dateController.text);
                  Navigator.pop(context);
                });
              }
            },
            child: Text('Submit')));
  }

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return alert.createAlertDialog(
              context, returnTextField(), returnPadding());
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
            return ItemBuilder.buildItem(context, index);
          }),
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
