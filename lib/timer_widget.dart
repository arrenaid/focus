import 'package:flutter/material.dart';
class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key, required this.waitTime}) : super(key: key);
  final int waitTime;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    return Center( child: Container(),);
  }
}
