import 'package:flutter/material.dart';
import 'package:focus/pomodoro_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: PomodoroScreen(),
    );
  }
}
