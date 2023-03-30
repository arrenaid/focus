import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/model/step_sequence.dart';
import 'dart:math';
import '../constants.dart';

class NewSequenceScreen extends StatefulWidget {
  const NewSequenceScreen({Key? key}) : super(key: key);

  @override
  State<NewSequenceScreen> createState() => _NewSequenceScreenState();
}

class _NewSequenceScreenState extends State<NewSequenceScreen> {
  List<StepSeq> items = [StepSeq.empty()];
  // late String currentName;
  // late int currentMin;

  List<TextEditingController> _controllersText = [];
  List<TextEditingController> _controllersMin = [];

  @override
  void initState() {
    super.initState();
    // _controllerText.addListener(listenerName);
    // _controllerMin.addListener(listenerMin);
  }
  @override
  void dispose() {
    _controllersText.forEach((element) { element.dispose();});
    _controllersMin.forEach((element) {element.dispose();});

    super.dispose();
  }
  // void listenerName(){
  //   currentName = _controllerText.text;
  // }
  // void listenerMin(){
  //   String text = _controllerMin.text;
  //   print(text);
  //   currentMin = int.tryParse(text) ?? 0;
  // }
  @override
  Widget build(BuildContext context) {
    //Map<String, int> sequence ;//= ['start', 10] as Map<String, int>;

    return Scaffold(
      backgroundColor: col1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    iconSize: 40,
                    icon: const Icon(
                      CupertinoIcons.question,
                      color: col4,
                    ),
                  ),
                  const Text(
                    'new',
                    style: tsDef,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    iconSize: 40,
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: col4,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: col2,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(4.0, 4.0), blurRadius: 8.0, color: col3),
                  ],
                ),
                child:  const Center(
                  child: TextField(
                    style: tsButton,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: 'sequence name',
                      hintStyle: tsButton,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              //configurator
            if(items.isNotEmpty)...[
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildSequenceCard(index, context, items[index]);
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 40,
                  child: IconButton(
                    iconSize: 35,
                    icon: const Icon(
                      CupertinoIcons.arrow_down,
                      color: col4,
                    ),
                    onPressed: () {},
                  ),
                ),
                itemCount: items.length,
              ),
              ],
              //save
              const SizedBox(height: 40),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  style: ElevatedButton.styleFrom(
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 35, vertical: 16),
                    minimumSize: const Size.fromHeight(50),
                    alignment: Alignment.center,
                    shape: const StadiumBorder(),
                    backgroundColor: col5,
                  ),
                  child: const Text(
                    'save',
                    style: tsDef,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSequenceCard(int index, BuildContext context, StepSeq item) {
    if(index >= _controllersText.length) {//todo ref
      _controllersText.add(TextEditingController());
      _controllersMin.add(TextEditingController());
    }

    if(item.name != null && (items.length - 1) == index) {
      _controllersText[index].text = item.name!;
    }
    if(item.minute != null && (items.length - 1) == index) {
      _controllersMin[index].text = item.minute.toString();
    }
    // else if(items[index].name != null){
    //   _controllersText[index].text = items[index].name!;
    // }

    return Transform.rotate(
      angle: index % 2 == 0 ? -pi / 65 : pi / 55,
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        //width: 60,
        decoration: BoxDecoration(
          color: col3,
          borderRadius: BorderRadius.circular(35),
          boxShadow: const [
            BoxShadow(offset: Offset(4.0, 4.0), blurRadius: 8.0, color: col3),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: col1,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(4.0, 4.0), blurRadius: 8.0, color: col4),
                  ],
                ),
                child: Center(
                  child: TextField(
                    controller: _controllersText[index],
                    style: tsButton,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,

                    decoration: const InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: 'step name',
                      hintStyle: tsButton,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: col2,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(4.0, 4.0),
                              blurRadius: 8.0,
                              color: col4),
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          controller: _controllersMin[index],
                          style: tsButton,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'minutes',
                            hintStyle: tsButton,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: (items.length - 1) == index
                          ? dropdownSequence()
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  items.removeAt(index);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 16),
                                shadowColor: col4,
                                minimumSize: const Size.fromHeight(50),
                                alignment: Alignment.center,
                                shape: const StadiumBorder(),
                                backgroundColor: col5,
                              ),
                              child: const Icon(CupertinoIcons.delete_simple,
                                  color: col4))),
                ],
              ),
            ),
            Text(
              'step - $index',
              style: tsDef.copyWith(fontSize: 25, color: col2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownSequence() {
    List<String> list = [];
    if (!list.contains('add')) list.add('add');
    Set<StepSeq> set = items.toSet();
    list.addAll(List.generate(set.length, (index) => items[index].name ?? 'current' ));//todo
    //var indexOf = list.indexOf('add');
    String dropdownValue = list.first;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: col5,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: const [
          BoxShadow(offset: Offset(4.0, 4.0), blurRadius: 8.0, color: col4),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            CupertinoIcons.down_arrow,
            color: col4,
          ),
          elevation: 16,
          isExpanded: true,
          borderRadius: BorderRadius.circular(35),
          style: tsButton,
          alignment: AlignmentDirectional.center,
          dropdownColor: col2,
          onChanged: (value) {
            // This is called when the user selects an item.
            int parse = int.parse(_controllersMin.last.text);

            setState(() {
              //dropdownValue = value!;

              //save old
              items.last.name = _controllersText.last.text;
              items.last.minute = parse;

              if(value != list.first){
                int? indexSet = list.indexOf(value!) ?? null;//todo ref
                int indexOf = items.indexOf(set.elementAt(indexSet!)) ?? items.length;
                items.add(items[indexOf]);
              } else{
                items.add(StepSeq.empty());
                // print(_controllersText.last.text);
                // print(parse);
                //
                // items.add(StepSeq(name: _controllersText.last.text,
                //   minute: parse,
                //   position: 0, sequence: 0,));
              }


            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
