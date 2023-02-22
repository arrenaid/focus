import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/focus_bloc.dart';

class FocusScreen extends StatelessWidget {
  const FocusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Finish')));
      }
      // if(state is FocusRunState){
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('run')));
      // }
      // if(state is FocusPauseState){
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pause')));
      // }
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
                child:  Container( decoration: BoxDecoration(color: Colors.deepOrange), padding: EdgeInsets.all(5),
                  child: Text('${state.timerType.toString()}\nInitial', style: TextStyle(fontSize: 50, color: Colors.black87,fontFamily: '' ),),
                ),//TimerWidget(waitTime: _waitTime,),
              ),
            ],
            if(state is FocusRunState)...[
              Align(
                alignment: const FractionalOffset(0.2, 0.2),
                child:  Container( decoration: BoxDecoration(color: Colors.deepOrange), padding: EdgeInsets.all(5),
                  child: Text('${state.timerType.toString()}\nRun', style: TextStyle(fontSize: 50, color: Colors.black87,fontFamily: '' ),),
                ),//TimerWidget(waitTime: _waitTime,),
              ),
            ],
            if(state is FocusPauseState)...[
              Align(
                alignment: const FractionalOffset(0.2, 0.2),
                child:  Container( decoration: BoxDecoration(color: Colors.deepOrange), padding: EdgeInsets.all(5),
                  child: Text('${state.timerType.toString()}\nPause', style: TextStyle(fontSize: 50, color: Colors.black87,fontFamily: '' ),),
                ),//TimerWidget(waitTime: _waitTime,),
              ),
            ],
            Align(
              alignment: const FractionalOffset(0.5, 0.5),
              child:  Container( decoration: BoxDecoration(color: Colors.deepOrange), padding: EdgeInsets.all(5),
                child: Text(state.str, style: TextStyle(fontSize: 80, color: Colors.black87,fontFamily: '' ),),
              ),//TimerWidget(waitTime: _waitTime,),
            ),
            Align(
              alignment: const FractionalOffset(0.5, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {
                    //start(short)
                    context.read<FocusBloc>().add(FocusChangeTypeShortEvent());
                  },
                    child: Text('Short', style: TextStyle(fontSize: 25),),),

                  IconButton(
                      iconSize: 95,
                      onPressed:
                      state.isStart
                          ? () => context.read<FocusBloc>().add(FocusPauseEvent())
                          : () => context.read<FocusBloc>().add(FocusStartEvent()),//state.isStart ? pause : () => start(isEnd? pomodoro : _currentTime),
                      icon: Icon( state.isStart
                          ? Icons.pause_circle_outline_rounded
                          : Icons.play_circle_outline_rounded,
                        //size: 100,
                        color: Colors.deepOrange, )),
                   TextButton(onPressed: () => context.read<FocusBloc>().add(FocusChangeTypeLongEvent()) /*start(long)*/, child: Text('Long', style: TextStyle(fontSize: 25),)),
                ],
              ),
            )
          ],
        ),
      ),
    );
      },
      ),
    );
  }
}

