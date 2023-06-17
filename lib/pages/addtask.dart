import 'package:flutter/material.dart';
import 'package:flutter_as/data/task.dart';


class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Task? taskToEdit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskToEdit = ModalRoute.of(context)?.settings.arguments as Task?;
      if (taskToEdit != null) {
        _titleController.text = taskToEdit!.title;
        _descriptionController.text = taskToEdit!.description;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('Добавить задачу'),
          backgroundColor: Theme.of(context).primaryColor
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onChanged: (value) {
                taskToEdit?.title = value;
              },
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Заголовок',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              onChanged: (value) {
                taskToEdit?.description = value;
              },
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Описание',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String newTitle = _titleController.text;
                String newDescription = _descriptionController.text;
                Task newTask = Task(newTitle, newDescription);
                if (taskToEdit != null) {
                  newTask.completed = taskToEdit!.completed;
                  Navigator.pop(context, newTask);
                } else {
                  Navigator.pop(context, newTask);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Сохранить'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
