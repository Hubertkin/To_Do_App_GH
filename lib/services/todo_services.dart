import 'package:http/http.dart';

class TodoService {
  final String baseUrl = 'https://tan-misty-elephant.cyclic.app/';

  //get all todos
  Future<Response> getAllTodosRequest() async {
    return await get(
      Uri.parse('$baseUrl/todos'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
    );
  }

  //create a todo
  Future<Response> createTodo({
    required String title,
    required String description,
    required DateTime deadline,
  }) async {
    Map<String, dynamic> body = {
      'title': title,
      'description': description,
      'deadline': deadline,
    };
    return await post(Uri.parse('$baseUrl/todos'), body: body);
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
    return await patch(Uri.parse('$baseUrl/todos/$id'), body: body);
  }

  ///delete  a todo
  Future<Response> deleteTodo(String id) async {
    return await delete(Uri.parse('$baseUrl/todos/$id'));
  }
}
