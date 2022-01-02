import 'package:todoapp/services/todo_services.dart';

class TodoController {
  final TodoService _todoService = TodoService();

  getAllTodos() async {
    await _todoService.getAllTodosRequest().then((response) {
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        //success
      } else {
        //error
      }
    });
  }
}
