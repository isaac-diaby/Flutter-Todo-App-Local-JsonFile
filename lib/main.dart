import 'package:flutter/material.dart';
import './todoProject/todo_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Application',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      
      home: TodoManager()
    );
  }
}