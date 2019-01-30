import 'package:flutter/material.dart';

// part './projectView.dart';

class TodoAddView extends StatelessWidget {
  final Function addTodo;
  final Function changeAddingTodo;
  final String curr;
  final snackBar = SnackBar(content: Text('Added'));
  TodoAddView({this.addTodo, this.changeAddingTodo, this.curr = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: (val) => changeAddingTodo(val),
            decoration: InputDecoration(border: new OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Add Todo'),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(snackBar);
                  addTodo(curr);
                }),
          ),
        ),
        // new Text('$curr')
      ],
    );
  }
}
