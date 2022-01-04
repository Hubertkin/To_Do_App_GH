import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'controllers/todo_controller.dart';

class CreateTodoView extends StatelessWidget {
  CreateTodoView({Key? key}) : super(key: key);
  final TodoController _todoController = TodoController();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  DateTime? myDate;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          ' Create To-do',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          TextFormField(
            controller: _titleController,
            maxLines: 1,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Color.fromRGBO(37, 43, 103, 1),
              )),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(37, 43, 103, 1),
                ),
              ),
              hintText: 'Please enter your title',
              labelText: 'Title',
              labelStyle: TextStyle(
                color: Color.fromRGBO(37, 43, 103, 1),
                fontWeight: FontWeight.w600,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Title field is required!';
              }
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Color.fromRGBO(37, 43, 103, 1),
              )),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(37, 43, 103, 1),
                ),
              ),
              hintText: 'Please enter your description',
              labelText: 'Description',
              labelStyle: TextStyle(
                color: Color.fromRGBO(37, 43, 103, 1),
                fontWeight: FontWeight.w600,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Description field is required !';
              }
            },
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    ).then((selectedDate) {
                      final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

                      _dateController.text = _dateFormat.format(selectedDate!);
                      myDate = selectedDate;
                    });
                  },
                  controller: _dateController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromRGBO(37, 43, 103, 1),
                    )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(37, 43, 103, 1),
                      ),
                    ),
                    hintText: 'Please enter your date',
                    labelText: 'Date',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(37, 43, 103, 1),
                      fontWeight: FontWeight.w600,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Date field is required!';
                    }
                  },
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: TextFormField(
                  controller: _timeController,
                  maxLines: 1,
                  onTap: () {
                    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((selectedTime) {
                      _timeController.text = selectedTime!.format(context);
                      myDate!.add(
                        Duration(
                          hours: selectedTime.hour,
                          minutes: selectedTime.minute,
                        ),
                      );
                      print(selectedTime);
                    });
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromRGBO(37, 43, 103, 1),
                    )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(37, 43, 103, 1),
                      ),
                    ),
                    hintText: 'Please enter your time',
                    labelText: 'Time',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(37, 43, 103, 1),
                      fontWeight: FontWeight.w600,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Time field is required!';
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 35),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromRGBO(37, 43, 103, 1),
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //send data to backend
                  print('success');
                  print(_titleController.text);
                  print(_descriptionController.text);
                  print(_dateController.text + ' ' + _timeController.text);
                  print(myDate);
                  bool isSent = await _todoController.createTodo(title: _titleController.text, description: _descriptionController.text, deadline: myDate!);
                  if (isSent) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color.fromRGBO(37, 43, 103, 1),
                        content: Text('Todo added successfully!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Failed to add a new todo'),
                      ),
                    );
                  }
                } else {
                  //validation failed!
                  print('failed!');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('All fields are required!'),
                    ),
                  );
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              )),
        ]),
      ),
    );
  }
}
