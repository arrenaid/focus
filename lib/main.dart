import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:focus/bloc/focus_bloc.dart';
import 'package:focus/bloc/model_bloc.dart';
import 'package:focus/bloc/sequence_bloc.dart';
import 'package:focus/screens/focus_screen.dart';
import 'model/sequence.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: FocusBloc()),
        BlocProvider.value(value: ModelBloc()..add(InitialModelEvent())),
        BlocProvider.value(value: SequenceBloc(SequenceState([
          Sequence(name: 'add', components: [])],Status.initial))),
      ],
      child: MaterialApp(
    title: 'Focus',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const FocusScreen(),
  ),
  );

  //after added multiblocprovider
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Focus',
  //     theme: ThemeData(
  //
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: const FocusScreen(),
  //   );
  // }
}
