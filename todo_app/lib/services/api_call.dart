import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo.dart';

class APICall {
  static fetchTodos() async {
    var resp = await http.get(
      Uri.https('node-todo-api-yjo3.onrender.com', 'todos/'),
    );
    log(resp.body.toString());
  }

  static addTodo(Todo todo) async {
    Map data = {
      "id": DateTime.now().toIso8601String(),
      "task": todo.title,
      "completed": todo.isCompleted.toString(),
    };

    print(json.encode(data));
    var resp = await http.post(
      Uri.https('node-todo-api-yjo3.onrender.com', 'todos/'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    log(resp.statusCode.toString());
  }
}