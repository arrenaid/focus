part of 'model_bloc.dart';

// abstract
class ModelState extends Equatable{
  final List <DayRow> models;
  final Status? status;

  const ModelState({required this.models, required this.status});

  @override
  List<Object?> get props => [models, status];

  ModelState copyWith({
    List<DayRow>? models,
    Status? status
  }) {
    return ModelState(
        models: models ?? this.models,
        status: status ?? this.status);
  }
}
// class InsertModelState extends ModelState{
//   InsertModelState(super.model);
// }
// class GetModelState extends ModelState{
//   GetModelState(super.model);
// }