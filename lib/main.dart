import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_habit_tracker/providers/habit_provider.dart';
import 'package:simple_habit_tracker/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HabitProvider(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
