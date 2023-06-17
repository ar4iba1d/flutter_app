import 'package:flutter/material.dart';
import 'package:flutter_as/domain/taskBloc.dart';
import 'package:flutter_as/domain/taskBlocProvider.dart';
import 'package:flutter_as/pages/addtask.dart';
import 'package:flutter_as/pages/homatask.dart';


void main() {
  runApp(TaskBlocProvider(
    taskBloc: TaskBloc(),
    appWidget: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black,
          ),
          primaryColor: const Color.fromARGB(255, 12, 12, 12),
          textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white))
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/newTask': (context) => const NewTask(),
      },
    );
  }
}
