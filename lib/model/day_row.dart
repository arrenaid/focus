class DayRow{
  int? id;
  final String? day;
  int pomodoroCount;
  int shortCount;
  int longCount;
  final String? tag;

  DayRow({this.id,
      required this.day,
        required this.pomodoroCount,
        required this.shortCount,
        required this.longCount,
        required this.tag});

 @override
  String toString() {
    return  "DayRow - {$id, day: $day, pom: $pomodoroCount, sho: $shortCount, "
        "lon: $longCount, tag: $tag";
  }
}