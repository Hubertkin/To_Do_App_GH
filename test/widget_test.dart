// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todoapp/main.dart';
import 'package:todoapp/controllers/todo_controller.dart';

void main() {
  final TodoController _todoController = TodoController();

  test('should return 200', () {
    _todoController.getAllTodos();
  });
}
