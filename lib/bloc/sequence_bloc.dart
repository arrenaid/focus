import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/sequence.dart';
import 'model_bloc.dart';
part 'sequence_state.dart';
part 'sequence_event.dart';

class SequenceBloc extends Bloc<SequenceEvent,SequenceState>{
  SequenceBloc(super.initialState){
    on<SaveSequence> (_save);
    on<RemoveSequence> (_remove);
    on<UpdateSequence> (_update);
  }
  _save(SaveSequence event, Emitter emit){
    emit(state.copyWith(status: Status.loading));
    var result = state.items;
    result.add(event.item);
    emit(SequenceState(result,Status.loaded));
  }
  _remove(RemoveSequence event, Emitter emit){
    emit(state.copyWith(status: Status.loading));
    var result = state.items;
    result.remove(event.item);
    emit(SequenceState(result,Status.loaded));
  }
  _update(UpdateSequence event, Emitter emit){
    emit(state.copyWith(status: Status.loading));
    var result = state.items;
    int index = result.indexOf(event.before);
    result[index] = event.after;
    emit(SequenceState(result,Status.loaded));
  }
}