part of 'sequence_bloc.dart';

class SequenceState extends Equatable{
  final List<Sequence> items;
  final Status? status;

  const SequenceState(this.items, this.status);

  @override
  List<Object?> get props => [items];

  SequenceState copyWith({
    List<Sequence>? items,
    Status? status
  }) {
    return SequenceState(
        items ?? this.items,
        status ?? this.status);
  }

}