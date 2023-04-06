import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/bloc/sequence_bloc.dart';
import 'package:focus/model/sequence.dart';
import 'package:focus/screens/new_sequence_screen.dart';
import '../constants.dart';

class SequenceScreen extends StatelessWidget {
  const SequenceScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Sequence> sequence = [
      Sequence(name: 'pomo\ndoro', components: []),
      Sequence(name: 'add', components: [])];

    return BlocBuilder<SequenceBloc,SequenceState>(
       buildWhen: (prevState, currentState) => (prevState != currentState),
builder: (context, state){
          // List<Sequence> sequence = [
          //   Sequence(name: 'add', components: []),];
          // sequence.addAll(state.items);
          //twin = state.items;
     return
        Scaffold(
        backgroundColor: col1,
        body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            //direction: Axis.vertical,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('sequence', style: tsDef,),
                IconButton(onPressed: () =>Navigator.of(context).pop(),
                  iconSize: 40,
                  icon: const Icon( CupertinoIcons.back, color: col4,),
                ),
              ],
            ),
            Expanded(
              child: GridView.count(crossAxisCount: 2,
                children: List.generate(state.items.length,//sequence.length,
                      (index) => index == (0)
                          ? SequenceAdd(index: index)
                          : SequenceCell(index: index,
                          name: state.items[index].name /*sequence[index].name*/,
                          isSelected: index == 0,
                          sequence: state.items[index],
                        ),
                ),
              ),
            )

          ]
      ),
        ),
      ));
}
    );
  }

}
class SequenceAdd  extends StatelessWidget {
  const SequenceAdd({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: SequenceCell.getAngle(index),//index % 2== 0 ? pi/35: - pi/35,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:  col3,
          borderRadius: BorderRadius.circular(35),
          boxShadow: const [BoxShadow(
            offset: Offset(4.0, 4.0),
            blurRadius: 8.0,
            color: col3,),
          ],
        ),

        child: InkWell(
          borderRadius: BorderRadius.circular(35),
          onTap: () =>  Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewSequenceScreen()),
          ),
          child: const Center(
            child: Icon(CupertinoIcons.add,size: 80,color: col2,),
          ),

        ),
      ),
    );
  }
}

class SequenceCell  extends StatelessWidget{
  const SequenceCell({super.key, required this.index, required this.name, required this.isSelected, required this.sequence});

  final int index;
  final bool isSelected;
  final String name;
  final Sequence sequence;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: getAngle(index),//index % 2== 0 ? pi/35: - pi/35,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? col3: col2,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [BoxShadow(
              offset: const Offset(4.0, 4.0),
              blurRadius: 8.0,
              color:  isSelected ? col2: col3,),
          ],
        ),

        child: InkWell(
          borderRadius: BorderRadius.circular(35),
          onTap: () =>  Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const NewSequenceScreen();
              },
                  settings: RouteSettings(
                      arguments: {
                        'sequence': sequence,
                      }
                  ),
              )
          ),
          child: Center(
            child: Text(name, style: tsDef,),
          ),

        ),
      ),
    );
  }

  static double getAngle(int index){
    double result;
    Random random = Random();
    var angle = random.nextInt(80) + 20;
    result =  ((index / 2) % 2 )== 0
        ? ( index % 2 == 0 ? -pi/angle : pi/angle)
        :(index % 2 == 0? pi/angle : -pi/angle);
    return result;
  }
}
