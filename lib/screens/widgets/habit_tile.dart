import 'package:flutter/material.dart';
import 'package:simple_habit_tracker/models/habit.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:simple_habit_tracker/providers/habit_provider.dart';

class HabitTile extends StatefulWidget {
  const HabitTile({
    Key? key,
    required this.habit,
  }) : super(key: key);
  final Habit habit;

  @override
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  Timer? _timer;
  bool _isActive = false;
  late int _elapsedTime;
  @override
  void initState() {
    _elapsedTime = widget.habit.elapsedTime;
    super.initState();
  }

  void startCounter() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  void pauseCounter() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    if (_timer != null) _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.delete,
          color: Colors.red.shade300,
        ),
        Icon(
          Icons.delete,
          color: Colors.red.shade300,
        ),
      ]),
      key: ValueKey(widget.habit.id),
      onDismissed: (_) =>
          context.read<HabitProvider>().removeHabit(id: widget.habit.id),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              spreadRadius: 1.0,
              color: Colors.grey.shade400,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircularProgressIndicator(
                    value: _elapsedTime / widget.habit.totalTime,
                    color: Colors.grey.shade900,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_isActive) {
                          pauseCounter();
                        } else {
                          startCounter();
                        }
                        _isActive = !_isActive;
                      });
                    },
                    icon: Icon(
                      (_isActive) ? Icons.pause : Icons.play_arrow,
                      color: Colors.grey.shade900,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.habit.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 2.5),
                  Text(
                    '${Duration(seconds: _elapsedTime).toString().substring(2, 7)} = ${(_elapsedTime * 100 / widget.habit.totalTime).round()}%',
                    style: TextStyle(color: Colors.grey.shade500),
                  )
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    final controller =
                        TextEditingController(text: widget.habit.title);
                    Duration time = Duration(seconds: widget.habit.totalTime);
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
                                      context.read<HabitProvider>().editHabit(
                                          id: widget.habit.id,
                                          title: controller.value.text,
                                          time: time);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                          color: Colors.grey.shade900),
                                    )),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(
                                      'Cancel',
                                      style:
                                          TextStyle(color: Colors.red.shade300),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10.0)
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
        ),
      ),
    );
  }
}
