part of 'model_bloc.dart';
abstract class ModelEvent extends Equatable{

  @override
  List<Object?> get props => [];
}
class InitialModelEvent extends ModelEvent{}
class InsertEvent extends ModelEvent{}
class GetEvent extends ModelEvent{}