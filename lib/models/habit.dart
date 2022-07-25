class Habit {
  final String id;
  final String title;
  final int totalTime;
  final int elapsedTime;
  double get progress => elapsedTime / totalTime;

  Habit({
    required this.id,
    required this.title,
    required this.totalTime,
    required this.elapsedTime,
  });
}
