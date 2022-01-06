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
    }).catchError((onError) {
      print(onError);
    });

    return todo;
  }

  /// add a new todo
  Future<bool> createTodo({
    required String title,
    required String description,
    required DateTime deadline,
  }) async {
    bool isSubmitted = false;
    await _todoService
        .createTodo(
      title: title,
      description: description,
      deadline: deadline,
    )
        .then((response) {
      int statusCode = response.statusCode;
      print(response.statusCode);
      print(response.body);
      if (statusCode == 200) {
        //success
        isSubmitted = true;
      } else {
        //error
        isSubmitted = false;
      }
    }).catchError((onError) {
      print(onError);
      isSubmitted = false;
    });
    return isSubmitted;
  }

  ///update Todo completion(isCompleted = true)
  Future<bool> updateIsCompleted({required String id}) async {
    bool isUpdated = false;
    await _todoService.updateStatus(id).then((response) {
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        //success
        isUpdated = true;
      } else {
        //error
        isUpdated = false;
      }
    }).catchError((onError) {
      //error
      print(onError);
      isUpdated = false;
    });
    return isUpdated;
  }

  // delete a todo
  Future<bool> deleteTodo(String id) async {
    bool isDeleted = false;
    await _todoService.deleteTodo(id).then((response) {
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        //success
        isDeleted = true;
      } else {
        //error
        isDeleted = false;
      }
    }).catchError((onError) {
      //error
      print(onError);
      isDeleted = false;
    });
    return isDeleted;
  }

  //get a todo
  Future<Todo?> getTodo(String id) async {
    Todo? todo;
    await _todoService.getTodo(id).then((response) {
      int statusCode = response.statusCode;
      Map<String, dynamic> body = jsonDecode(response.body);
      if (statusCode == 200) {
        todo = Todo.fromJson(body);
      } else {
        todo = null;
      }
    });
    return todo;
  }
}
