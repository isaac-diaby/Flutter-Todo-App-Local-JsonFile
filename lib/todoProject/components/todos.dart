part of '../views/todoView.dart';

class CTodos extends StatelessWidget {
  final List<Todo> todos;
  final Function changeDoneTodo;
  final Function removeTodo;
  final snackBar = SnackBar(content: Text('deleted'));

  CTodos({this.todos, this.changeDoneTodo, this.removeTodo});

  @override
  Widget build(BuildContext context) {
    // print(todos);
    return ListView.builder(
        itemCount: todos?.length,
        padding: EdgeInsets.only(top: 32.0),
        itemBuilder: (BuildContext context, int i) => SafeArea(
              child: Column(
                children: <Widget>[
                  ListTile(
                    enabled: !todos[i].isDone,
                    onLongPress: () {removeTodo(i);
                    Scaffold.of(context).showSnackBar(snackBar);},
                    title: Text(todos[i]?.task),
                  ),
                  ListBody(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                                child:
                                Text(todos[i].isDone ? 'Redo' : 'Done'),
                                onPressed: () => changeDoneTodo(i)),
                          ),
                          // new Expanded(
                          //   child: new RaisedButton(
                          //       color: Colors.red,
                          //       child: new Text('Remove'),
                          //       onPressed:()=> removeTodo(i)),
                          // )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ));
  }
}
