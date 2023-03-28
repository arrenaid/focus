import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/constants.dart';
import '../bloc/model_bloc.dart';
import 'package:focus/model/day_row.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModelBloc, ModelState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: col1,
        body: SafeArea(
          child: ListView(
            //todo list all row
            children: [
              const Text(
                'statistics',
                style: tsDef,
                textAlign: TextAlign.center,
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  boxBuild(1, 50.0, false,
                  Text('1')),
                  boxBuild(1, 50.0, false,
                      Text('2')),
                  boxBuild(1, 50.0, false,
                      Text('3')),
                  boxBuild(1, 50.0, false,
                      Text('4')),
                ],
              ),
              if (state.models.isNotEmpty) ...[
                ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.models.length,
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    var data = state.models;
                    return buildRow(data[index], index);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 5),
                ),
              ],
              if (state.models.isEmpty) ...[
                const Text(
                  'Empty',
                  style: tsDef,
                )
              ]
            ],
          ),
        ),
      );
    });
  }

  Widget buildRow(DayRow data, int index) {
    double size = 80;
    var split = data.day.toString().split('-');
    var month = split[1];
    var day = split[2];
    return Container(
      height: size,
      decoration: BoxDecoration(
       // borderRadius: BorderRadius.circular(20),
        gradient: gradient,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Transform.rotate(
            angle: index % 2 == 0 ? -pi / (30 + index) : pi / (45 + index),
            child: Container(
              height: size,
              width: size,
              // decoration: BoxDecoration(
              //       color: col2,
              //   border: Border.all( color: col4,width: 5)
              // ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      day,
                      style: tsDef.copyWith(fontSize: 60),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      month,
                      style: tsDef.copyWith(
                          color: col1, letterSpacing: 20, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //const SizedBox(width: 20),
          boxBuild(index, size, false,
          Text('POM\n${data.pomodoroCount}',
                    style: tsStat,
            textAlign: TextAlign.center,
          ),
          ),
          // SizedBox(width: 20),
          boxBuild(index, size,true,
            Text('SHO\n${data.shortCount}',
                style: tsStat,
            textAlign: TextAlign.center,),
          ),
          //const SizedBox(width: 10),
          boxBuild(index, size, false,
            Text('LON\n${data.longCount}',
                style: tsStat,
            textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
  Widget boxBuild(index, size,bool isInverse, Widget up, ){
    return Transform.rotate(
      angle: index % 2 == 0 && isInverse ? -pi / (45) : pi / (45),
      child: Container(
        width: size,
        height: size,
        // decoration: BoxDecoration(
        //   color: col2.withOpacity(0.6),
        //   border: Border.all(width: 2, color: col3),
        //   //borderRadius: BorderRadius.circular(10),
        // ),
        child: Center(
          child: up,
        ),
      ),
    );
  }
}
