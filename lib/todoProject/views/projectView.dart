import 'package:flutter/material.dart';

import './todoAddView.dart'; 
import './todoView.dart';
import '../todo_manager.dart';

class TodoProject extends TodoManagerState with SingleTickerProviderStateMixin  {
 TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            title: Text('Simple Todos With Local Json'),
            centerTitle: true,
            bottom: TabBar(
              controller: controller,
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.add)),
              ],
            )),
        body:  TabBarView(controller: controller, children: <Widget>[
           TodoView(
               todoViewState: todoArray,
              sToggleDone: toggleDone,
              sremoveTodo: removeTodo),
           TodoAddView(
            addTodo: writeNewTodo,
            changeAddingTodo: changeAddingTodoString,
            curr: addNewTodoContextString,
          )
        ]));
  }
  }