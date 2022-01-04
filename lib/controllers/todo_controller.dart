import 'dart:convert';

import 'package:todoapp/services/todo_services.dart';
import 'package:todoapp/models/todo.dart';

class TodoController {
  final TodoService _todoService = TodoService();

  ///get all todo as a list of todos
  Future<List<Todo>> getAllTodos() async {
    List<Todo> todo = [];
    await _todoService.getAllTodosRequest().then((response) {
      int statusCode = response.statusCode;
      //  Map<String,dynamic> body = jsonDecode(response.body);
      if (statusCode == 200) {
        //success
        todo = todoFromJson(response.body);
      } else {
        //error
        todo = [];
      }
    });

    return todo;
  }
  Future<bool>createTodo({
    required String title,
    required String description,
    required DateTime deadline,
  })async{
    bool isSubmitted = false;
    await _todoService.createTodo(title:title,description:description,deadline:deadline,)
  }
}
