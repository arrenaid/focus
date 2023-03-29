import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/screens/new_sequence_screen.dart';
import '../constants.dart';

class SequenceScreen extends StatelessWidget {
  const SequenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> sequence = [ 'pomo\ndoro', 'add', 'pomo\ndoro', 'empty',];
    return Scaffold(
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
              children: List.generate(sequence.length,
                      (index) =>  SequenceCell( index: index, name: sequence[index], isSelected: index == 0,),
              ),
            ),
          )

        ]
    ),
      ),
    ));
  }

}

class SequenceCell  extends StatelessWidget{
  const SequenceCell({super.key, required this.index, required this.name, required this.isSelected});

  final int index;
  final bool isSelected;
  final String name;
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
              MaterialPageRoute(builder: (context) => const NewSequenceScreen())
          ),
          child: Center(
            child: Text(name, style: tsDef,),
          ),

        ),
      ),
    );
  }

  double getAngle(int index){
    double result;
    Random random = Random();
    var angle = random.nextInt(80) + 20;
    result =  ((index / 2) % 2 )== 0
        ? ( index % 2 == 0 ? -pi/angle : pi/angle)
        :(index % 2 == 0? pi/angle : -pi/angle);
    return result;
  }
}
