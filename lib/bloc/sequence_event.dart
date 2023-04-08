part of 'sequence_bloc.dart';

class SequenceEvent extends Equatable {

  @override
  List<Object?> get props => [];

}
class SaveSequence extends SequenceEvent{
  Sequence item;
  SaveSequence(this.item);

  @override
  List<Object?> get props => [item];
}
class RemoveSequence extends SequenceEvent{
  Sequence item;
  RemoveSequence(this.item);

  @override
  List<Object?> get props => [item];
}
class UpdateSequence extends SequenceEvent{
  Sequence before;
  Sequence after;
  UpdateSequence(this.before, this.after);

  @override
  List<Object?> get props => [before,after];
}