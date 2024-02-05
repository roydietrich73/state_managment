import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_managment/aufgabe5.dart';
import 'package:state_managment/todo.dart';
import 'package:state_managment/todo_item.dart';
import 'package:state_managment/todo_list_app.dart';

class _TodoListAppState extends State<TodoListApp> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todos = (prefs.getStringList('todos') ?? []).map((title) {
        return Todo(title: title);
      }).toList();
    });
  }

  void _saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoTitles = todos.map((todo) => todo.title).toList();
    prefs.setStringList('todos', todoTitles);
  }

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
            return TodoItem(
              todo: todos[index],
              onTodoChanged: _onTodoChanged,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTodo,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();

        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            controller: controller,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String title = controller.text.trim();
                if (title.isNotEmpty) {
                  setState(() {
                    todos.add(Todo(title: title));
                  });
                  _saveTodos();
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _onTodoChanged(Todo todo) {
    setState(() {
      todo.isChecked = !todo.isChecked;
    });
    _saveTodos();
  }
}
