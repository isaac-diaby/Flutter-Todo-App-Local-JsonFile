part of '../todo_manager.dart';

class Todos {
  Todos(this.todos);
  List<Todo> todos;
  factory Todos.fromJson(Map<String, dynamic> json) {
    var todo = json['todos'] as List;
    List<Todo> arrayTodo = todo.map((i) => new Todo.fromJson(i)).toList();
   return new Todos(
     arrayTodo
  );
  }
}

class Todo {
  Todo({this.task, this.isDone});
  final String task;
  final bool isDone;
   factory Todo.fromJson(Map<String, dynamic> json) {
   return new Todo(
      task: json['task'],
      isDone: json['isDone']
  );
}
}