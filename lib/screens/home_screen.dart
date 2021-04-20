import 'dart:async';

import 'package:flutter/material.dart';

import 'package:todo/helpers/drawer_navigation.dart';
import 'package:todo/models1/todo.dart';
import 'package:todo/screens/todo_screen.dart';

import 'package:todo/services1/todo_service.dart';

class HomeScreen extends StatefulWidget {

 

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService;

  List<Todo> _todoList = List<Todo>();

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todoService = TodoService();
    _todoList = List<Todo>();

    var todos = await _todoService.readTodos();

    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }

  getValue(int val) {
    return ((val == 1) ? true : false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
      ),
      backgroundColor: Colors.white,
      drawer: DrawerNavigation(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Card(
                color: Colors.lightBlue[400],
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                  value: getValue(_todoList[index].isFinished),
                  onChanged: (value) {
                    setState(() {
                      if (_todoList[index].isFinished == 1) {
                        setState(() {
                          _todoList[index].isFinished = 0;
                        });
                      } else {
                        _todoList[index].isFinished = 1;
                        _todoService.deleteTodo(_todoList[index].id);
                        Timer(
                          Duration(seconds: 1),
                          () => Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                              builder: (context) => HomeScreen())),
                              
                        );
                      }
                    });
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_todoList[index].title ?? 'No Title')
                    ],
                  ),
                  subtitle: Text(_todoList[index].category ?? 'No Category'),
                  secondary: Text(_todoList[index].todoDate ?? 'No Date'),
                )),
          );
        },
        itemCount: _todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context,  rootNavigator: true)
            .push(MaterialPageRoute(builder: (context) => TodoScreen())),
        child: Icon(Icons.add),
        
      ),
    );
  }
}
