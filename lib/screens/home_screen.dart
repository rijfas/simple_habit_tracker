import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_habit_tracker/providers/habit_provider.dart';
import 'package:simple_habit_tracker/screens/widgets/habit_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HabitProvider>().loadHabits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Simple Habbit Tracker'),
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
      ),
      body: Consumer<HabitProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemBuilder: (context, index) => HabitTile(
            habit: provider.habits[index],
          ),
          itemCount: provider.habits.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final controller = TextEditingController();
          Duration time = const Duration(minutes: 5);
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'Habit Title',
                          focusColor: Colors.grey.shade900),
                    ),
                  ),
                  const Text(
                    'Habit Time:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoTimerPicker(
                    initialTimerDuration: const Duration(minutes: 5),
                    onTimerDurationChanged: (value) => time = value,
                    mode: CupertinoTimerPickerMode.hm,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            context.read<HabitProvider>().addHabit(
                                title: controller.value.text, time: time);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.grey.shade900),
                          )),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red.shade300),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10.0)
                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.grey.shade900,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
