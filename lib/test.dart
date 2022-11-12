// // ignore: unused_import
// import 'package:flutter/material.dart';

// void main() {
//   var dizi = [1, 2, 3];

//   // ignore: unused_element
//   //yazdir(item) {
//   // ignore: avoid_print
//   //print('{$dizi.indexOf(item)}.eleman: $item');

//   for (var i in dizi) {
//     // ignore: avoid_print
//     print('${dizi.indexOf(i)}.eleman : $i');
//   }
// }

import 'package:flutter/material.dart';

class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: CircleAvatar(
        child: Text(todo.name[0]),
      ),
      title: Text(todo.name, style: _getTextStyle(todo.checked)),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  // ignore: non_constant_identifier_names
  final List<Todo> _todos = <Todo>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
      ),
      // ignore: avoid_unnecessary_containers
      body: ListView.builder(
        itemCount: _todos.length,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemBuilder: (BuildContext context, int index) {
          _todos.map((Todo todo) {
            return TodoItem(
              todo: todo,
              onTodoChanged: _handleTodoChange,
            );
          }).toList();
          return Dismissible(
            background: Container(
              color: Colors.green,
            ),
            key: ValueKey(_todos[index]),
            onDismissed: (DismissDirection direction) {
              setState(() {
                _todos.removeAt(index);
              });
            },
            child: ListTile(
              title: Text(
                'Item ${_todos[index]}',
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          title: Row(
            children: [
              const Text('Yapacaklarını Listeye Ekle'),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            // ignore: avoid_unnecessary_containers
            Container(
              child: Stack(
                children: [
                  TextButton(
                    child: const Text('Ekle'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _addTodoItem(_textFieldController.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo list',
      home: TodoList(),
    );
  }
}

void main() => runApp(const TodoApp());
