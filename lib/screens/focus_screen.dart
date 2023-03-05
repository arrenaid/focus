import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/screens/statistic_screen.dart';
import '../bloc/focus_bloc.dart';
import '../bloc/model_bloc.dart';
import '../constants.dart';

class FocusScreen extends StatelessWidget {
  const FocusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(//todo remove provider
      create: (_) => FocusBloc(),
      child: const FocusPage(),
    );
  }
}
class FocusPage extends StatelessWidget {
  const FocusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FocusBloc,FocusState>(listener: (context,state){
      if(state is FocusCompleteState){
        context.read<ModelBloc>().insert(state.timerType);// todo test
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Finish', style: tsDef,),
              backgroundColor: Colors.red,));
      }
    },
      child: BlocBuilder<FocusBloc,FocusState> (
        builder: (context,state){
        return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if(state is FocusInitialState)...[
              Align(
                alignment: const FractionalOffset(0.2, 0.2),
                child:  Container(
                  decoration: const BoxDecoration(color: Colors.deepOrange),
                  padding: const EdgeInsets.all(5),
                  child: Text('${state.timerType.toString()}\nInitial',
                    style: tsDef,
                  ),
                ),
              ),
            ],
            if(state is FocusRunState)...[
              Align(
                alignment: const FractionalOffset(0.2, 0.2),
                child:  Container( decoration:
                const BoxDecoration(color: Colors.deepOrange),
                  padding: EdgeInsets.all(5),
                  child: Text('${state.timerType.toString()}\nRun',
                    style: tsDef,),
                ),
              ),
            ],
            if(state is FocusPauseState)...[
              Align(
                alignment: const FractionalOffset(0.2, 0.2),
                child:  Container( decoration: const BoxDecoration(color: Colors.deepOrange),
                  padding: EdgeInsets.all(5),
                  child: Text('${state.timerType.toString()}\nPause',
                    style: tsDef,
                  ),
                ),
              ),
            ],
            //clock
            Align(
              alignment: const FractionalOffset(0.5, 0.5),
              child:  Container( decoration: const BoxDecoration(color: Colors.deepOrange),
                padding: const EdgeInsets.all(5),
                child: Container(
                  width:  MediaQuery.of(context).size.width * 8 / 10 ,
                    child: Text(state.str, style: tsDef.copyWith(fontSize: 100),)),
              ),
            ),
            //button restart
            if(state is FocusPauseState)...[
              Align(
                alignment: const FractionalOffset(0.5, 0.72),
                child:  TextButton(onPressed: () {
                  state.timerType == pomodoro
                      ? context.read<FocusBloc>().add(const FocusResetEvent())
                      : context.read<FocusBloc>().add(const FocusChangeTypePomodoroEvent());
                },
                  child: state.timerType == pomodoro
                      ? const Text('RESTART', style: tsButton)
                      : const Text('POMODORO', style:tsButton),
                ),
              ),
            ],
          //icon button
          Align(
              alignment: const FractionalOffset(0.5, 0.85),
              child:IconButton(
                iconSize: 100,
            onPressed:
            state.isStart
                ? () => context.read<FocusBloc>().add(const FocusPauseEvent())
                : () => context.read<FocusBloc>().add(const FocusStartEvent()),
            icon: Icon( state.isStart
                ? Icons.pause_circle_outline_rounded
                : Icons.play_circle_outline_rounded,
              color: Colors.deepOrange,

            ),
          )),
            //Buttons cell
            Align(
              alignment: const FractionalOffset(0.5, 0.85),
              child: Container(
                width:  MediaQuery.of(context).size.width * 9 / 10 ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
          if(!state.isStart)...[
            TextButton(onPressed: () {
                      context.read<FocusBloc>().add(const FocusChangeTypeShortEvent());
                    },
                      child: const Text('SHORT', style: tsButton,),
                    ),],

          //          ElevatedButton(
          //            onLongPress: () => context.read<FocusBloc>().add(const FocusResetEvent()),
          // onPressed:state.isStart
          //     ? () => context.read<FocusBloc>().add(FocusPauseEvent())
          //     : () => context.read<FocusBloc>().add(FocusStartEvent()),
          // child:Text( state.isStart
          // ? 'Pause' : 'Start', style: TextStyle(fontSize: 25),
          //          ),
          //          ),
          if(!state.isStart)...[
            TextButton(
                         onPressed: () => context.read<FocusBloc>().add(const FocusChangeTypeLongEvent()),
                         child: const Text('LONG', style: tsButton,)),],
                  ],
                ),
              ),
            ),
            //bottom arrow
          Align(
          alignment: const FractionalOffset(0.5, 0.95),
          child: IconButton(
              iconSize: 50,

                onPressed: (){
                showModalBottomSheet(context: context, builder: (BuildContext context) {
                  return const StatScreen();
                },);
                },
                icon: Icon(Icons.keyboard_arrow_up_rounded)
            ),
          ),
          ],
        ),
      ),
    );
      },
      ),
    );
  }
}

