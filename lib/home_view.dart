import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'controllers/todo_controller.dart';
import 'models/todo.dart';
import 'utils.dart';

import 'create_todo_view.dart';

//stl- stateless widget
//stf- staeful widget
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TodoController _todoController = TodoController();
  String selectedItem = 'todo';

  final List<Todo> _unCompletedData = [];

  final List<Todo> _CompletedData = [];

  @override
  void initState() {
    _todoController.getAllTodos().then((List todos) {
      for (Todo element in todos) {
        if (!element.isCompleted) {
          _unCompletedData.add(element);
        } else {
          _CompletedData.add(element);
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false, //used to move ur app title to left if u r using ios simulator
        title: const Text(
          'My tasks',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Center(
            child: FlutterLogo(
          size: 40,
        )),
        actions: [
          PopupMenuButton<String>(
              icon: const Icon(Icons.menu),
              onSelected: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text('Todo'),
                    value: 'todo',
                  ),
                  const PopupMenuItem(
                    child: Text('Completed'),
                    value: 'completed',
                  ),
                ];
              }),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CreateTodoView();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(37, 43, 103, 1),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              SizedBox(width: constraints.maxWidth / 2, child: TodoListViewWidget(selectedItem: selectedItem, unCompletedData: _unCompletedData, completedData: _CompletedData)),
              Expanded(
                child: Container(
                  color: Colors.red,
                ),
              ),
            ],
          );
        }
        return TodoListViewWidget(selectedItem: selectedItem, unCompletedData: _unCompletedData, completedData: _CompletedData);
      }),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16,
          ),
          child: InkWell(
            onTap: () {
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) {
                    if (_CompletedData.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.info,
                            size: 50,
                          ),
                          Text('You don\'t have any completed Task!'),
                        ],
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        return TaskCardWidget(
                          dateTime: _CompletedData[index].deadline,
                          description: _CompletedData[index].description,
                          title: _CompletedData[index].title,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: _CompletedData.length,
                    );
                  });
            },
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(37, 43, 103, 1),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Completed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_CompletedData.length}',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TodoListViewWidget extends StatelessWidget {
  const TodoListViewWidget({
    Key? key,
    required this.selectedItem,
    required List<Todo> unCompletedData,
    required List<Todo> completedData,
  })   : _unCompletedData = unCompletedData,
        _CompletedData = completedData,
        super(key: key);
  final String selectedItem;
  final List<Todo> _unCompletedData;
  final List<Todo> _CompletedData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return TaskCardWidget(
            dateTime: selectedItem == 'todo' ? _unCompletedData[index].deadline : _CompletedData[index].deadline,
            title: selectedItem == 'todo' ? _unCompletedData[index].title : _CompletedData[index].title,
            description: selectedItem == 'todo' ? _unCompletedData[index].description : _CompletedData[index].description,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 5,
          );
        },
        itemCount: selectedItem == 'todo' ? _unCompletedData.length : _CompletedData.length);
  }
}

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
  }) : super(key: key);
  final String title;
  final String description;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outlined,
              size: 30,
              color: customColor(date: deadline(date: dateTime)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: const Color.fromRGBO(37, 43, 103, 1),
                    ),
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Row(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: customColor(
                    date: deadline(date: dateTime),
                  ),
                ),
                Text(
                  deadline(date: dateTime),
                  style: TextStyle(
                    color: customColor(
                      date: deadline(date: dateTime),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
