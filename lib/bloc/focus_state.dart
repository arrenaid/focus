part of 'focus_bloc.dart';

abstract class FocusState extends Equatable {
  final timerType;
  final isStart;
  final String visibleResult;
  final String millisecondsRes;

  FocusState(this.timerType, this.visibleResult, this.millisecondsRes, this.isStart);

  @override
  List<Object?> get props => [timerType,visibleResult,millisecondsRes,isStart];
}

class FocusInitialState extends FocusState {
  FocusInitialState(int timerType, String res , String milli) :
        super(timerType, res, milli, false);
  @override
  String toString() => 'FocusInitialState { str: $visibleResult }';
}
class FocusResetState extends FocusState {
  FocusResetState(int timerType, String res , String milli, bool isStart) :
        super(timerType, res, milli, isStart);

  @override
  String toString() => 'FocusResetState { str: $visibleResult }';
}
class FocusRunState extends FocusState {
  FocusRunState(int timerType,  String res , String milli) :
        super(timerType, res, milli, true);

  @override
  String toString() => 'FocusRunState { str: $visibleResult }';
}
class FocusPauseState extends FocusState {
  FocusPauseState(int timerType,  String res , String milli) :
        super(timerType, res, milli, false);

  @override
  String toString() => 'FocusPauseState { str: $visibleResult }';
}
class FocusChangeTypeState extends FocusState {
  FocusChangeTypeState(int timerType,  String res , String milli) :
        super(timerType, res, milli, false);

  @override
  String toString() => 'FocusPauseState { str: $visibleResult }';
}
class FocusCompleteState extends FocusState {
  FocusCompleteState(int timerType) : super(timerType, '00:00', '00', false);

  @override
  String toString() => 'FocusCompleteState {  }';
}

