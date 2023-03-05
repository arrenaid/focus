import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus/bloc/focus_bloc.dart';
import 'package:focus/model/day_row.dart';
import 'package:intl/intl.dart';
import '../model/sqflite.dart';
part 'model_state.dart';
part 'model_event.dart';

enum Status { initial, error, loading, loaded, postAdded, postRemove }

class ModelBloc extends Bloc<ModelEvent,ModelState>{
  ModelBloc():super(
      ModelState(models: [] //DayRow(
    // day: DateFormat('yyyy-MM-dd').format(DateTime.now()), pomodoroCount: 0,
    // shortCount: 0,longCount: 0,tag: 'empty',)
          , status: Status.initial)
  ){
    on<InsertEvent>(_insertq);
    on<InitialModelEvent>(_onInit);
    //on<GetEvent>(load());
  }

  final dbHelper = DatabaseHelper.instance;

  _insertq(InsertEvent event, Emitter emit){
    // todo:
    emit(state.copyWith(models: [],status: Status.loaded));
  }
  _onInit(InitialModelEvent event, Emitter emit) {
    emit(state.copyWith(status: Status.initial));
    load();
    emit(state.copyWith(status: Status.loaded));
  }

  load() async {
    emit(state.copyWith(status: Status.loading));
    List<DayRow> models = [];
    List<Map<String, dynamic>> rows = await dbHelper.queryAllRows();
    if(rows.isNotEmpty){
      for (var row in rows){
        models.add(DayRow(
            id: row[DatabaseHelper.columnId],
            day: row[DatabaseHelper.columnDay],
            pomodoroCount: row[DatabaseHelper.columnPomodoroCount],
            longCount: row[DatabaseHelper.columnLongCount],
            shortCount: row[DatabaseHelper.columnShortCount],
            tag: row[DatabaseHelper.columnTag]));
      }
    }
    emit(state.copyWith(models: models,status: Status.loaded));
  }

  Future<void> insert(int timerType) async {
    emit(state.copyWith(status: Status.loading));
    var currentDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
    bool isResult = false;
    if(state.models.isEmpty){
      load();
    }
    if(state.models.isNotEmpty) {
      var removeModel;
      var addModel;
      for (var model in state.models) {
        if(model.day == currentDay){
          removeModel = model;
          switch(timerType){
            case pomodoro: model.pomodoroCount += 1;
            break;
            case short: model.shortCount += 1;
            break;
            case long: model.longCount += 1;
            break;
          }
          Map<String, dynamic> row = {
            DatabaseHelper.columnId: model.id,
            DatabaseHelper.columnDay: model.day,
            DatabaseHelper.columnPomodoroCount: model.pomodoroCount,
            DatabaseHelper.columnShortCount: model.shortCount,
            DatabaseHelper.columnLongCount: model.longCount,
            DatabaseHelper.columnTag: model.tag};
          await dbHelper.update(row);
          addModel = model;
          isResult = true;
          print('$model');//todo remove
        }
      }
      if(isResult) {
        List<DayRow> modelsResult = state.models;
        modelsResult.remove(removeModel);
        modelsResult.add(addModel);
        emit(state.copyWith(models: modelsResult, status: Status.loaded));
        return;
      }
    }

    //new row
    if(!isResult)    {
      DayRow model = DayRow(
        day: currentDay,
        pomodoroCount: timerType == pomodoro ? 1 : 0,
        shortCount: timerType == short ? 1 : 0,
        longCount: timerType == long ? 1 : 0,
        tag: 'test',
      );

      Map<String, dynamic> row = {
        DatabaseHelper.columnDay: model.day,
        DatabaseHelper.columnPomodoroCount: model.pomodoroCount,
        DatabaseHelper.columnShortCount: model.shortCount,
        DatabaseHelper.columnLongCount: model.longCount,
        DatabaseHelper.columnTag: model.tag
      };
      model.id = await dbHelper.insert(row);

      print('$model');//todo remove
      List<DayRow> models = state.models;
      models.add(model);
      emit(state.copyWith(models: models, status: Status.loaded));
    }
  }
}