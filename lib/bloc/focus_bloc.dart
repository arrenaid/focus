import 'dart:async';
import 'dart:isolate';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'focus_state.dart';
part 'focus_event.dart';

const int pomodoro = 25000;
const int short = 5000;
const int long = 15000;
const int tick = 25;


class FocusBloc extends Bloc<FocusEvent,FocusState>{
  FocusBloc() : super(FocusInitialState(pomodoro,_updateStrAlt(pomodoro),'00'));

  // The callback for our alarm
  @pragma('vm:entry-point')
  static Future<void> callback() async {
    // developer.log('Alarm fired!');
    // // Get the previous cached count and increment it.
    // final prefs = await SharedPreferences.getInstance();
    // final currentCount = prefs.getInt(countKey) ?? 0;
    // await prefs.setInt(countKey, currentCount + 1);

    // // This will be null if we're running in the background.
    // uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    // uiSendPort?.send(null);
  }
  @pragma('vm:entry-point')
  static void printHello() {
    final DateTime now = DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
  }

  Timer ? _timer;
  int _waitTime = pomodoro;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  @override
  Stream<FocusState> mapEventToState(
      FocusEvent event,
      ) async* {
    if(event is FocusStartEvent){
      yield* _mapStartAlternativeTick(event);
    }else if(event is FocusInitialEvent){
      yield* _mapInitialToState(event);
    } else if(event is FocusPauseEvent){
      yield* _mapPauseToState(event);
    } else if(event is FocusResetEvent){
      yield* _mapResetToState(event);
    } else if(event is FocusTickedEvent){
      yield* _mapTickedToState(event);
    } else if(event is FocusStopEvent){
      yield* _mapStopToState(event);
    } else if(event is FocusChangeTypeLongEvent){
      yield* _mapChangeTypeLongToState(event);
    } else if(event is FocusChangeTypeShortEvent){
      yield* _mapChangeTypeShortToState(event);
    } else if(event is FocusChangeTypePomodoroEvent){
      yield* _mapChangeTypePomodoroToState(event);
    }
  }

  showAlarm() async*{

  }

  // static String _updateStr( int time ){
  //   var minuteStr = (time ~/ 60).toString().padLeft(2,'0');
  //   var secondStr = (time % 60).toString().padLeft(2,'0');
  //   return '$minuteStr:$secondStr';
  // }
  static String _updateStrAlt( int time ){
    var minuteStr = ((time/1000) ~/ 60).toString().padLeft(2,'0');
    var secondStr = ((time/1000) % 60).toInt().toString().padLeft(2,'0');
    return '$minuteStr:$secondStr';
  }
  String getMilliSec(){
    return ((_waitTime % 1000) ~/10).toInt().toString().padLeft(2,'0');
  }

  Stream<FocusState> _mapInitialToState(FocusInitialEvent event) async* {
    _waitTime = state.timerType;
  }

  Stream<FocusState> _mapStartToState(FocusStartEvent start) async*{

    if(_waitTime > 0){
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _waitTime -= 1;
        add(FocusTickedEvent(_updateStrAlt(_waitTime)));
        if(_waitTime <= 0){
          add(const FocusStopEvent());
        }
      });
    }
  }
  Stream<FocusState>  _mapStartAlternativeTick(FocusStartEvent start) async*{
    if(_waitTime > 0){
      _timer = Timer.periodic(const Duration(milliseconds: tick), (timer) {
        _waitTime -= tick;
        add(FocusTickedEvent(_updateStrAlt(_waitTime)));
        if(_waitTime <= 0){
          add(const FocusStopEvent());
        }
      });
    }
  }

  Stream<FocusState> _mapPauseToState(FocusPauseEvent event) async* {
    if(state is FocusRunState){
      _timer?.cancel();
      yield FocusPauseState(state.timerType, _updateStrAlt(_waitTime), getMilliSec());
    }
  }

  Stream<FocusState> _mapResetToState(FocusResetEvent event) async* {
    _timer?.cancel();
      yield FocusResetState(state.timerType,_updateStrAlt(_waitTime), getMilliSec(),state.isStart);
      add(const FocusInitialEvent());
      add(const FocusStartEvent());
  }
  Stream<FocusState> _mapChangeTypeLongToState(FocusChangeTypeLongEvent event) async* {
    _timer?.cancel();
    yield FocusInitialState(long,_updateStrAlt(long),'00');
    add(const FocusInitialEvent());
    add(const FocusStartEvent());
  }
  Stream<FocusState> _mapChangeTypeShortToState(FocusChangeTypeShortEvent event) async* {
    _timer?.cancel();
    yield  FocusInitialState(short,_updateStrAlt(short),'00');
    add(const FocusInitialEvent());
    add(const FocusStartEvent());
  }
  Stream<FocusState> _mapChangeTypePomodoroToState(FocusChangeTypePomodoroEvent event) async* {
    _timer?.cancel();
    yield  FocusInitialState(pomodoro,_updateStrAlt(pomodoro),'00');
    add(const FocusInitialEvent());
    add(const FocusStartEvent());
  }
  Stream<FocusState> _mapStopToState(FocusStopEvent event) async* {
    if(state is FocusRunState){
      _timer?.cancel();
       yield FocusCompleteState(state.timerType);
      yield FocusInitialState(pomodoro,_updateStrAlt(pomodoro),'00');
      add(const FocusInitialEvent());
    }
  }
  Stream<FocusState> _mapTickedToState(FocusTickedEvent event) async* {
    yield FocusRunState(state.timerType, _updateStrAlt(_waitTime),getMilliSec());
  }
}