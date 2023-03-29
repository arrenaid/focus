import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/constants.dart';
import '../bloc/model_bloc.dart';
import 'package:focus/model/day_row.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModelBloc, ModelState>(builder: (context, state) {
      List<DayRow> data = state.models.reversed.toList();
      double topBoxSize = MediaQuery.of(context).size.width /5;
      return Scaffold(
        backgroundColor: col1,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const BouncingScrollPhysics(),
            children: [
              const Text(
                'statistics',
                style: tsDef,
                textAlign: TextAlign.center,
              ),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  boxBuild( topBoxSize,  pi / 45, isFill: true,
                      RichText(
                        text: TextSpan(
                          text: data.length.toString(),
                          style: tsStat.copyWith(fontSize: 45),
                          children: <TextSpan>[
                            TextSpan(
                                text: '\nall day',
                                style: tsStat.copyWith(fontSize: 15)),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Text('${data.length}',
                      //       style: tsStat.copyWith(fontSize: 45),
                      //     textAlign: TextAlign.center,),
                      //     Text('all day',
                      //       style: tsStat.copyWith(fontSize: 15),
                      //       textAlign: TextAlign.center,),
                      //
                      //   ],
                      // )
                  ),
                  boxBuild( topBoxSize,  -pi / 45 , Text('2'), isFill: true),
                  boxBuild( topBoxSize, -pi / 65, Text('3'), isFill: true),
                  boxBuild( topBoxSize, pi / 85, Text('4') , isFill: true),
                ],
              ),
              const SizedBox(height: 10),
              if (state.models.isNotEmpty) ...[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.models.length,
                  itemBuilder: (context, index) {
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
        borderRadius: BorderRadius.circular(20),
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
          boxBuild(
            size,
            index % 2 == 0 ? -pi / (45) : pi / (45),
            // Text(
            //   'POM\n${data.pomodoroCount}',
            //   style: tsStat,
            //   textAlign: TextAlign.center,
            // ),
            RichText(
              text: TextSpan(
                text: data.pomodoroCount.toString(),
                style: tsStat.copyWith(fontSize: 45),
                children: <TextSpan>[
                  TextSpan(
                      text: '\nPOMODORO',
                      style: tsStat.copyWith(fontSize: 15)),
                ],
              ),
              textAlign: TextAlign.center,
            ),

          ),
          // SizedBox(width: 20),
          boxBuild(
            size,
            index % 2 != 0 ? -pi / (45) : pi / (45),
            // Text(
            //   'SHO\n${data.shortCount}',
            //   style: tsStat,
            //   textAlign: TextAlign.center,
            // ),
            RichText(
              text: TextSpan(
                text: 'SHORT\n',
                style: tsStat.copyWith(fontSize: 15),
                children: <TextSpan>[
                  TextSpan(text: data.shortCount.toString(), style: tsStat),
                ],
              ),
              textAlign: TextAlign.center,
            ),

          ),
          //const SizedBox(width: 10),
          boxBuild(
            size,
            index % 2 == 0 ? -pi / (45) : pi / (45),
            RichText(
              text: TextSpan(
                text:'LONG\n',
                style: tsStat.copyWith(fontSize: 15),
                children: <TextSpan>[
                  TextSpan(text: data.longCount.toString(), style: tsStat),
                ],
              ),
              textAlign: TextAlign.center,
            ),

          ),
        ],
      ),
    );
  }

  Widget boxBuild(size, double angle, Widget widget, {bool isFill = false}) {
    return Transform.rotate(
      angle: angle, //index % 2 == 0 && isInverse ? -pi / (45) : pi / (45),
      child: Container(
        width: size,
        height: size,
        decoration: isFill
            ? BoxDecoration(
                //color: col2.withOpacity(0.6),
                gradient: gradient,
                border: Border.all(width: 2, color: col2),
                borderRadius: BorderRadius.circular(25),
              )
            : null,
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}
