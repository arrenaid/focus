import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/constants.dart';
import '../bloc/model_bloc.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModelBloc,ModelState>(
      builder: (context,state) {
      return Scaffold(
        backgroundColor: Colors.black87,
        body: SafeArea(
          child: Column( //todo list all row
            children: [
              Text('statistics', style: tsDef,),

              if(state.models.isNotEmpty)...[
                Container(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.models.length,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index){
                        var data = state.models;
                       return Row(
                       children: [
                       Text(data[index].day.toString(),
                       style: tsDef.copyWith(fontSize: 20),),
                       const SizedBox(width: 20),
                       Text('POM: '+ data[index].pomodoroCount.toString(),
                       style: tsDef.copyWith(fontSize: 20)),
                         const SizedBox(width: 10),
                       Text('SHO: '+ data[index].shortCount.toString(),
                       style: tsDef.copyWith(fontSize: 20)),
                         const SizedBox(width: 10),
                       Text('LON: '+ data[index].longCount.toString(),
                       style: tsDef.copyWith(fontSize: 20)),
                       ],
                       );
                      }
                  ),
                ),
            ],
        if(state.models.isEmpty)...[const Text('Empty',style: tsDef,)]
            ],
          ),
        ),
      );
  }
  );
  }
}
