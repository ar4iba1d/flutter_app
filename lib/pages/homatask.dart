import 'package:flutter/material.dart';
import 'package:flutter_as/data/task.dart';
import 'package:flutter_as/domain/taskBloc.dart';
import 'package:flutter_as/domain/taskBlocProvider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TaskBloc taskBloc;
  final tasks = <Task>[
    Task('Test1', 'test2')
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = TaskBlocProvider.of(context);
    if (provider != null) {
      taskBloc = provider.taskBloc;
      taskBloc.fetchTasks();
    }
  }

  @override
  void dispose() {
    taskBloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Список задач'),
          leading: const Icon(Icons.task_alt),
          backgroundColor: Theme.of(context).primaryColor
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Container(
              decoration: const BoxDecoration(color: Color.fromRGBO(49, 47, 47, 0.8)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                title: Text(
                  task.title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Checkbox(
                  activeColor: Color.fromRGBO(49, 47, 47, 0.8),
                  value: task.completed,
                  onChanged: (value) {
                    taskBloc.updateTaskCompletion(task, value!);
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/newTask', arguments: task)
                      .then((editedTask) {
                    if (editedTask != null) {
                      taskBloc.updateTask(editedTask as Task);
                    }
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newTask').then((newTask) {
            if (newTask != null) {
              taskBloc.addTask(newTask as Task);
            }
          });
        },
        tooltip: 'Добавить задачу',
        backgroundColor: const Color.fromRGBO(49, 47, 47, 0.8),
        child: const Icon(Icons.add_box),
      ),
    );
  }
}