import 'package:flutter/material.dart';

class Todo {
  final String title;

  Todo({required this.title});
}

class TodoListApp extends StatelessWidget {
  final List<Todo> todos = [
    Todo(title: 'Task 1'),
    Todo(title: 'Task 2'),
    Todo(title: 'Task 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('To-Do App'),
        ),
        body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return TodoItem(todo: todos[index]);
          },
        ),
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;

  TodoItem({required this.todo});

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.todo.title,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: Checkbox(
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}

void main() {
  runApp(TodoListApp());
}