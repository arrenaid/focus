part of 'focus_bloc.dart';

abstract class FocusState extends Equatable {
  // final int waitTime;
  // final int currentTime;
  // final int oldTime;
  final timerType;
  final isStart /*= false*/;
  // final isEnd = false;
  final String str;

  FocusState(/*this.waitTime, this.currentTime, this.oldTime,*/this.timerType, this.str, this.isStart);

  @override
  List<Object?> get props => [/*waitTime, currentTime, oldTime,*/ str];
}

class FocusInitialState extends FocusState {
  FocusInitialState(int timerType,String str) : super(timerType, str, false);

  @override
  String toString() => 'FocusInitialState { str: $str }';
}
class FocusResetState extends FocusState {
  FocusResetState(int timerType, String str, bool isStart) : super(timerType, str, isStart);

  @override
  String toString() => 'FocusResetState { str: $str }';
}
class FocusRunState extends FocusState {
  FocusRunState(int timerType, String str) : super(timerType, str, true);

  @override
  String toString() => 'FocusRunState { str: $str }';
}
class FocusPauseState extends FocusState {
  FocusPauseState(int timerType, String str) : super(timerType, str, false);

  @override
  String toString() => 'FocusPauseState { str: $str }';
}
class FocusChangeTypeState extends FocusState {
  FocusChangeTypeState(int timerType, String str) : super(timerType, str, false);

  @override
  String toString() => 'FocusPauseState { str: $str }';
}
class FocusCompleteState extends FocusState {
  FocusCompleteState(int timerType) : super(timerType, '00:00', false);

  @override
  String toString() => 'FocusPauseState {  }';
}

