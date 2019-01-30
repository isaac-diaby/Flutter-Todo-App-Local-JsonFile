import '../todo_manager.dart';
import 'package:flutter/material.dart';
part '../components/todos.dart';

  class TodoView extends StatelessWidget {
  final List<Todo> todoViewState;
  final Function sToggleDone;
  final Function sremoveTodo;
  TodoView({this.todoViewState, this.sToggleDone, this.sremoveTodo});

  void toggleDone(int index) {
    sToggleDone(index);
  }

  void _removeTodo(int index) {
    sremoveTodo(index);
  }

  @override
  Widget build(BuildContext context) {
    return CTodos(
        todos: todoViewState,
        changeDoneTodo: toggleDone,
        removeTodo: _removeTodo);
  }
}
