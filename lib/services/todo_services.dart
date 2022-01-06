import 'package:http/http.dart';

import 'dart:convert';

class TodoService {
  final String baseUrl = 'https://tan-misty-elephant.cyclic.app';

  //get all todos
  Future<Response> getAllTodosRequest() async {
    return await get(Uri.parse('$baseUrl/todos'));
  }

  //create a todo
  Future<Response> createTodo({
    required String title,
    required String description,
    required DateTime deadline,
  }) async {
    UsersTodo usersTodo = UsersTodo(
      title: title,
      description: description,
      deadline: deadline,
    );
    Map<String, dynamic> body = {
      'title': title,
      'description': description,
      'deadline': deadline.toString(),
    };
    return await post(Uri.parse('$baseUrl/todos'), body: jsonEncode(usersTodo));
  }

  ///get todo by id(one todo)
  Future<Response> getTodo(String id) async {
    return await get(Uri.parse('$baseUrl/todos/$id'));
  }

  ///update iscompleted(patch)
  Future<Response> updateStatus(String id) async {
    Map<String, dynamic> body = {
      'isCompleted': true,
    };
    return await patch(Uri.parse('$baseUrl/todos/$id'), body: json.encode(body));
  }

  ///delete  a todo
  Future<Response> deleteTodo(String id) async {
    return await delete(Uri.parse('$baseUrl/todos/$id'));
  }
}

class UsersTodo {
  String title;
  String description;
  DateTime deadline;

  UsersTodo({required this.title, required this.description, required this.deadline});

  Map toJson() => {
        'title': title,
        'description': description,
        'deadline': deadline,
      };
}
