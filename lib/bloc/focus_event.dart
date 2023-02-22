part of 'focus_bloc.dart';

abstract class FocusEvent extends Equatable{
  const FocusEvent();

  @override
  List<Object?> get props => [];
}
class FocusStartEvent extends FocusEvent{
  const FocusStartEvent();
}
class FocusPauseEvent extends FocusEvent{
  const FocusPauseEvent();
}
class FocusResetEvent extends FocusEvent{
  const FocusResetEvent();
}
class FocusStopEvent extends FocusEvent{
  const FocusStopEvent();
}
class FocusChangeTypeShortEvent extends FocusEvent{
  const FocusChangeTypeShortEvent();
}
class FocusChangeTypeLongEvent extends FocusEvent{
  const FocusChangeTypeLongEvent();
}
class FocusTickedEvent extends FocusEvent{
  final String str;
  const FocusTickedEvent(this.str);

  @override
  List<Object?> get props => [str];
}
