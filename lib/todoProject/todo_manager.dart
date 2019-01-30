import 'dart:async' show Future;
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

import './views/projectView.dart';
part './tools/todojson.dart';

class TodoManager extends StatefulWidget {
  final Map<String, dynamic> initTodo;
  TodoManager([this.initTodo]);

  @override
  TodoProject createState() => TodoProject();
}

abstract class TodoManagerState extends State<TodoManager> {
  @protected
  List<Todo> todoArray = [];
  @protected
  String addNewTodoContextString;

  String fileName = 'todos.json'; // file that stores all todos and setting 
  File todoJsonFile;
  Directory dir;
  
  bool fileExists = false;

  @override
  void initState() {
    super.initState();
    _todoAssetInit();
  }

  _todoAssetInit() async { 
    todoJsonFile = await _localFile;
    fileExists = todoJsonFile.existsSync();
    if (fileExists) loadTodos();
  }
  @protected
  Future<String> get _localPath async { // gets the file path location
    //location of this app docs (can write to this path)
    final directory = await getApplicationDocumentsDirectory(); 
    return directory.path;
  }

  @protected
  Future<File> get _localFile async { // gets the file
    final path = await _localPath;
    return File('$path/$fileName');
  }


  @protected
  Future loadTodos() async {
    try {
      final file = await _localFile; // gets the file ref
      String jsonString = file.readAsStringSync(); // returns the contents of the json file
      print(jsonString);
      final jsonResponse = json.decode(jsonString); // converts the json to an object
      // print(jsonResponse);
      Todos data = Todos.fromJson(jsonResponse);
      /*
      passed the data to the Todos constructor 
      returning back the mapped and typed object
      print('debug $data');
      */
      setState(() => todoArray = data.todos); // saves to todos in todoArray
    } catch (e) {
      print('err loading');
      print(e);
      if (!fileExists)
        _createFile({
          'todos': [
            {"task": "Finish This App", "isDone": true},
            {"task": "hold on card to delete the todo when its not done", "isDone": false}
          ]
        });
    }
  }

  @protected
  Future writeNewTodo(context) async {
    var toAddData = {'task': context, 'isDone': false}; 
    /*
    makes a new todo ready to get saves into the text file
    passing it into the constructore makes sure its of that type
    */
    try {
    final file =  await _localFile; 
    String jsonString = file.readAsStringSync(); // stores the contexts of the file
    final jsonResponse = json.decode(jsonString);
    jsonResponse['todos'].add(toAddData);
    print(jsonResponse);


        file.writeAsStringSync(json.encode(jsonResponse));
    }catch (e) {
      print('tried adding new a todo got an error: $e');
    }

    loadTodos();
 
  }

  @protected
  _createFile(data) async {
    print('Creating file');
    final file = await _localFile;
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(data));
    loadTodos;
    return file;
  }

  @protected
  changeAddingTodoString(val) {
    setState(() {
      addNewTodoContextString = val;
    });
  }

  @protected
  void toggleDone(int index) async {
    final file =  await _localFile; 
    String jsonString = file.readAsStringSync(); // stores the contexts of the file
    var jsonResponse = json.decode(jsonString);
    jsonResponse['todos'][index]['isDone']
    = jsonResponse['todos'][index]['isDone'] ? false : true;
    // jsonResponse[todoArray.rem]
    print(jsonResponse['todos']);
    try {
        file.writeAsStringSync(json.encode(jsonResponse));
    }catch (e) {
      print('tried deleting a todo got an error: $e');
    }
    loadTodos();
  }

  @protected
  void removeTodo(int index) async {
    print(index);
    final file =  await _localFile; 
    String jsonString = file.readAsStringSync(); // stores the contexts of the file
    var jsonResponse = json.decode(jsonString);
    jsonResponse['todos'].removeAt(index);
    // jsonResponse[todoArray.rem]
    print(jsonResponse['todos']);
    try {
        file.writeAsStringSync(json.encode(jsonResponse));
    }catch (e) {
      print('tried deleting a todo got an error: $e');
    }
    loadTodos();
  }
}
