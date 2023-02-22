import 'dart:async';

import 'package:flutter/material.dart';
import 'package:focus/timer_widget.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  Timer ? _timer;
  late int _waitTime;
  late int _currentTime;
  late int _oldTime;
  var isStart = false;
  var isEnd = false;
  late String str;

  final int pomodoro = 25;
  final int short = 5;
  final int long = 15;

  @override
  void initState() {
    _waitTime = pomodoro;
    _currentTime = pomodoro;
    _oldTime = pomodoro;
    _updateStr();
    super.initState();
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool changeTime(int time){
    _oldTime = _currentTime;
    _currentTime = time;
    return isChangeTime();
  }

  bool isChangeTime() => _currentTime != _oldTime;

  void start(int time){
    if(changeTime(time) || isEnd){
      if(isEnd) isEnd = false;
      _timer?.cancel();
      _waitTime = _currentTime;
      _updateStr();
    }
    if(_waitTime > 0){
      setState(() { isStart = true; });
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _waitTime -= 1;
        _updateStr();
        if(_waitTime <= 0){
          isEnd = true;
          pause();
        }
      });
    }
  }
  void pause(){
    _timer?.cancel();
    setState(() {
      isStart = false;
    });
  }

  void _updateStr(){
    var minuteStr = (_waitTime ~/ 60).toString().padLeft(2,'0');
    var secondStr = (_waitTime % 60).toString().padLeft(2,'0');
    setState(() {
      str = '$minuteStr:$secondStr';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: const FractionalOffset(0.5, 0.5),
              child:  Container( decoration: BoxDecoration(color: Colors.deepOrange), padding: EdgeInsets.all(5),
                child: Text(str, style: TextStyle(fontSize: 80, color: Colors.black87,fontFamily: '' ),),
              ),//TimerWidget(waitTime: _waitTime,),
            ),
            Align(
              alignment: const FractionalOffset(0.5, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {
                    start(short);
                    },
                    child: Text('Short', style: TextStyle(fontSize: 25),),),

                  IconButton(
                    iconSize: 95,
                      onPressed: isStart ? pause : () => start(isEnd? pomodoro : _currentTime),
                      icon: Icon( isStart
                      ? Icons.pause_circle_outline_rounded
                      : Icons.play_circle_outline_rounded,
                    //size: 100,
                    color: Colors.deepOrange, )),
                  TextButton(onPressed: () => start(long), child: Text('Long', style: TextStyle(fontSize: 25),)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
