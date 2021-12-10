import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
  String selectedItem = 'todo';

  final List<Map<String, dynamic>> _unCompletedData = [];

  final List<Map<String, dynamic>> _CompletedData = [];

  final List<Map<String, dynamic>> data = [
    {
      'title': 'Curabitur euismod leo in rutrum scelerisque .',
      'description': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at imperdiet ante, eget feugiat magna. Curabitur euismod leo in rutrum scelerisque. Vivamus fermentum mi vitae pulvinar ultricies. Duis congue finibus dui, quis tristique magna dignissim vitae. Aenean at quam mauris. Etiam vulputate, magna sit amet ornare consequat, lectus nisi tincidunt elit, vel mattis dolor metus nec ante. Fusce dignissim dui ac massa lobortis, nec tempus arcu porttitor. Nulla congue eros sed sapien malesuada, at varius lectus dignissim. Donec at magna sed sem euismod porta. Cras et nunc eget sem rutrum ultricies eu vitae augue. Maecenas eros augue, volutpat id elit sit amet, sollicitudin bibendum sem",
      'date_time': 'Yesterday',
      'status': true
    },
    {
      'title': 'Fusce at imperdiet ante, eget feugiat magna.',
      'description': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at imperdiet ante, eget feugiat magna. Curabitur euismod leo in rutrum scelerisque. Vivamus fermentum mi vitae pulvinar ultricies. Duis congue finibus dui, quis tristique magna dignissim vitae. Aenean at quam mauris. Etiam vulputate, magna sit amet ornare consequat, lectus nisi tincidunt elit, vel mattis dolor metus nec ante. Fusce dignissim dui ac massa lobortis, nec tempus arcu porttitor. Nulla congue eros sed sapien malesuada, at varius lectus dignissim. Donec at magna sed sem euismod porta. Cras et nunc eget sem rutrum ultricies eu vitae augue. Maecenas eros augue, volutpat id elit sit amet, sollicitudin bibendum sem",
      'date_time': 'Today',
      'status': false
    },
    {
      'title': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'description': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at imperdiet ante, eget feugiat magna. Curabitur euismod leo in rutrum scelerisque. Vivamus fermentum mi vitae pulvinar ultricies. Duis congue finibus dui, quis tristique magna dignissim vitae. Aenean at quam mauris. Etiam vulputate, magna sit amet ornare consequat, lectus nisi tincidunt elit, vel mattis dolor metus nec ante. Fusce dignissim dui ac massa lobortis, nec tempus arcu porttitor. Nulla congue eros sed sapien malesuada, at varius lectus dignissim. Donec at magna sed sem euismod porta. Cras et nunc eget sem rutrum ultricies eu vitae augue. Maecenas eros augue, volutpat id elit sit amet, sollicitudin bibendum sem",
      'date_time': 'Tomorrow',
      'status': false
    },
    {
      'title': 'Donec rutrum risus lobortis massa condimentum.',
      'description': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at imperdiet ante, eget feugiat magna. Curabitur euismod leo in rutrum scelerisque. Vivamus fermentum mi vitae pulvinar ultricies. Duis congue finibus dui, quis tristique magna dignissim vitae. Aenean at quam mauris. Etiam vulputate, magna sit amet ornare consequat, lectus nisi tincidunt elit, vel mattis dolor metus nec ante. Fusce dignissim dui ac massa lobortis, nec tempus arcu porttitor. Nulla congue eros sed sapien malesuada, at varius lectus dignissim. Donec at magna sed sem euismod porta. Cras et nunc eget sem rutrum ultricies eu vitae augue. Maecenas eros augue, volutpat id elit sit amet, sollicitudin bibendum sem",
      'date_time': 'Mon. 15 Dec .21',
      'status': false
    },
    {
      'title': 'Aenean consequat vel tellus nec rutrum.',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce at imperdiet ante, eget feugiat magna. Curabitur euismod leo in rutrum scelerisque. Vivamus fermentum mi vitae pulvinar ultricies. Duis congue finibus dui, quis tristique magna dignissim vitae. Aenean at quam mauris. Etiam vulputate, magna sit amet ornare consequat, lectus nisi tincidunt elit, vel mattis dolor metus nec ante. Fusce dignissim dui ac massa lobortis, nec tempus arcu porttitor. Nulla congue eros sed sapien malesuada, at varius lectus dignissim. Donec at magna sed sem euismod porta. Cras et nunc eget sem rutrum ultricies eu vitae augue. Maecenas eros augue, volutpat id elit sit amet, sollicitudin bibendum sem',
      'date_time': 'Today',
      'status': true
    },
  ];

  @override
  void initState() {
    for (Map<String, dynamic> element in data) {
      if (!element['status']) {
        _unCompletedData.add(element);
      } else {
        _CompletedData.add(element);
      }
    }
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                SizedBox(width: 400, child: TodoListViewWidget(selectedItem: selectedItem, unCompletedData: _unCompletedData, completedData: _CompletedData)),
                Expanded(
                  child: Container(
                    color: Colors.red,
                  ),
                )
              ],
            );
          }
        },
      ),
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
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        return TaskCardWidget(
                          dateTime: _CompletedData[index]['date_time'],
                          description: _CompletedData[index]['description'],
                          title: _CompletedData[index]['title'],
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
    required List<Map<String, dynamic>> unCompletedData,
    required List<Map<String, dynamic>> completedData,
  })   : _unCompletedData = unCompletedData,
        _CompletedData = completedData,
        super(key: key);
  final String selectedItem;
  final List<Map<String, dynamic>> _unCompletedData;
  final List<Map<String, dynamic>> _CompletedData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return TaskCardWidget(
            dateTime: selectedItem == 'todo' ? _unCompletedData[index]['date_time'] : _CompletedData[index]['date_time'],
            title: selectedItem == 'todo' ? _unCompletedData[index]['title'] : _CompletedData[index]['title'],
            description: selectedItem == 'todo' ? _unCompletedData[index]['description'] : _CompletedData[index]['description'],
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
  final String dateTime;

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
              color: customColor(date: dateTime),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    date: dateTime,
                  ),
                ),
                Text(
                  dateTime,
                  style: TextStyle(
                    color: customColor(
                      date: dateTime,
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
