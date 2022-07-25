import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  List<Habit> _habits = [];
  List<Habit> get habits => UnmodifiableListView(_habits);
  void loadHabits() {
    _habits = [];
  }

  void addHabit({required String title, required Duration time}) {
    final habit = Habit(
        id: const Uuid().v4(),
        title: title,
        totalTime: time.inSeconds,
        elapsedTime: 0);
    _habits.add(habit);
    notifyListeners();
  }

  void removeHabit({required String id}) {
    _habits.removeWhere((habit) => habit.id == id);
    notifyListeners();
  }

  void editHabit({
    required String id,
    required String title,
    required Duration time,
  }) {
    final index = _habits.indexWhere((element) => element.id == id);
    _habits[index] =
        Habit(id: id, title: title, elapsedTime: 0, totalTime: time.inSeconds);
    notifyListeners();
  }
}
