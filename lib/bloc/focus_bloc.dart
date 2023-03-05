import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'focus_state.dart';
part 'focus_event.dart';

const int pomodoro = 25;
const int short = 5;
const int long = 15;

class FocusBloc extends Bloc<FocusEvent,FocusState>{
  FocusBloc() : super(FocusInitialState(pomodoro,_updateStr(pomodoro)));

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
      yield* _mapStartToState(event);
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


  static String _updateStr( int time ){
    var minuteStr = (time ~/ 60).toString().padLeft(2,'0');
    var secondStr = (time % 60).toString().padLeft(2,'0');
    return '$minuteStr:$secondStr';
  }

  Stream<FocusState> _mapInitialToState(FocusInitialEvent event) async* {
    _waitTime = state.timerType;
  }

  Stream<FocusState> _mapStartToState(FocusStartEvent start) async*{

    if(_waitTime > 0){
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _waitTime -= 1;
        add(FocusTickedEvent(_updateStr(_waitTime)));
        if(_waitTime <= 0){
          add(const FocusStopEvent());
        }
      });
    }
  }

  Stream<FocusState> _mapPauseToState(FocusPauseEvent event) async* {
    if(state is FocusRunState){
      _timer?.cancel();
      yield FocusPauseState(state.timerType, _updateStr(_waitTime));
    }
  }

  Stream<FocusState> _mapResetToState(FocusResetEvent event) async* {
    _timer?.cancel();
      yield FocusResetState(state.timerType,_updateStr(_waitTime),state.isStart);
      add(const FocusInitialEvent());
      add(const FocusStartEvent());
  }
  Stream<FocusState> _mapChangeTypeLongToState(FocusChangeTypeLongEvent event) async* {
    _timer?.cancel();
    yield FocusInitialState(long,_updateStr(long));
    add(const FocusInitialEvent());
    add(const FocusStartEvent());
  }
  Stream<FocusState> _mapChangeTypeShortToState(FocusChangeTypeShortEvent event) async* {
    _timer?.cancel();
    yield  FocusInitialState(short,_updateStr(short));
    add(const FocusInitialEvent());
    add(const FocusStartEvent());
  }
  Stream<FocusState> _mapChangeTypePomodoroToState(FocusChangeTypePomodoroEvent event) async* {
    _timer?.cancel();
    yield  FocusInitialState(pomodoro,_updateStr(pomodoro));
    add(const FocusInitialEvent());
    add(const FocusStartEvent());
  }
  Stream<FocusState> _mapStopToState(FocusStopEvent event) async* {
    if(state is FocusRunState){
      _timer?.cancel();
       yield FocusCompleteState(state.timerType);
      yield FocusInitialState(pomodoro,_updateStr(pomodoro));
      add(const FocusInitialEvent());
    }
  }
  Stream<FocusState> _mapTickedToState(FocusTickedEvent event) async* {
    yield FocusRunState(state.timerType, _updateStr(_waitTime));
  }
}