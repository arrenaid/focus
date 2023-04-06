import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/bloc/sequence_bloc.dart';
import 'package:focus/model/component.dart';
import 'dart:math';
import '../constants.dart';
import '../model/sequence.dart';

///проблемы:кнопка разделитьель,
/// - после добавления нового элемента появлятеся клавиатура
/// -
class NewSequenceScreen extends StatefulWidget {
  const NewSequenceScreen({Key? key}) : super(key: key);

  @override
  State<NewSequenceScreen> createState() => _NewSequenceScreenState();
}

class _NewSequenceScreenState extends State<NewSequenceScreen> {
  List<Component> items = [Component.controller(TextEditingController(),
      TextEditingController())
  ];
  final TextEditingController _controllerText = TextEditingController();
  bool isChange = false;
  late Sequence sequence;

  // late String currentName;
  // late int currentMin;

  // List<TextEditingController> _controllersText = [];
  // List<TextEditingController> _controllersMin = [];

  @override
  void initState() {
    super.initState();
     _controllerText.addListener((){});
    // _controllerMin.addListener(listenerMin);
  }

  @override
  void dispose() {
    items.forEach((element) {
      if(element.controllerName != null) element.controllerName!.dispose();
      element.controllerName = null;
    });
    items.forEach((element) {
      if(element.controllerMin != null) element.controllerMin!.dispose();
      element.controllerMin = null;
    });
    _controllerText.dispose();
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

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if (arguments.isNotEmpty) {
      isChange = true;
      sequence = arguments['sequence'] as Sequence;
      items.clear();
      items.addAll(sequence.components);
      for (var element in items) {
        element.controllerName = TextEditingController(text: element.name);
        element.controllerMin = TextEditingController(text: element.minute.toString());
      }
      _controllerText.text = sequence.name;
    }


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
                  Text(
                    isChange? 'change': 'new',
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
                child: Center(
                  child: TextField(
                    controller: _controllerText,
                    style: tsButton,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration.collapsed(
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
                  separatorBuilder: (context, index) =>
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          iconSize: 35,
                          icon: const Icon(
                            CupertinoIcons.arrow_down,
                            color: col4,
                          ),
                          onPressed: () => dropdownSequence,
                        ),
                      ),
                  itemCount: items.length,
                ),
              ],
              //save
              if(items.length > 1)...[
                const SizedBox(height: 40),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed:() => isChange ? saveChange(context): saveSequence(context),
                  style: ElevatedButton.styleFrom(
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 35, vertical: 16),
                    minimumSize: const Size.fromHeight(50),
                    alignment: Alignment.center,
                    shape: const StadiumBorder(),
                    backgroundColor: col5,
                  ),
                  child: Text(
                    isChange?'CHANGE':'SAVE',
                    style: tsButton,
                  ),
                ),
              ),],
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSequenceCard(int index, BuildContext context, Component item) {
    // if(index >= _controllersText.length) {//todo ref
    //   _controllersText.add(TextEditingController());
    //   _controllersMin.add(TextEditingController());
    // }

    // if(item.name != null && (items.length - 1) == index) {
    //   _controllersText[index].text = item.name!;
    // }
    // if(item.minute != null && (items.length - 1) == index) {
    //   _controllersMin[index].text = item.minute.toString();
    // }

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
                    controller: item.controllerName,
                    style: tsButton,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,

                    decoration: const InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: 'Name component',
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
                          controller: item.controllerMin,
                          style: tsButton,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'Minutes',
                            hintStyle: tsButton,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: (items.length - 1) == index
                          ?  dropdownSequence()
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
              'Component №$index',
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
    Set<Component> set = items.toSet();
    Component? elementEmpty;

    for (int i = 0; i < set.length; i++) {
      if (set.elementAt(i).name == null) elementEmpty = set.elementAt(i);
    }
    try {
      if (elementEmpty != null) {
        set.remove(elementEmpty);
      }
    }catch(e){print(e);}
    list.addAll(List.generate(set.length, (index) => set.elementAt(index).name ?? 'emptyX0')); //todo в списке новый элемент всегда пустой, и он последний. получается что последний элемент нельзя клонировать
    // var indexOf = list.indexOf('add');
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

            if(items.last.controllerMin!.text.isNotEmpty
              && items.last.controllerName!.text.isNotEmpty ){

            setState(() {
              //dropdownValue = value!;
              //save old
              items.last.name = items.last.controllerName!.text;
              int parse = int.parse(items.last.controllerMin!.text);
              items.last.minute = parse;

              if (value != list.first) {
                int indexSet = list.indexOf(value!);
                int indexOf = items.indexOf(set.elementAt(--indexSet));
                items.add(items[indexOf]);
              } else {
                items.add(Component.controller(
                  TextEditingController(), TextEditingController(),));
                // print(_controllersText.last.text);
                // print(parse);
                //
                // items.add(StepSeq(name: _controllersText.last.text,
                //   minute: parse,
                //   position: 0, sequence: 0,));
              }
            }
            );
            } else{
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fill in the fields', style: tsButton,),
                    backgroundColor: col2,));
            }
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

  void saveChange(BuildContext context) {

  }

  void saveSequence(BuildContext context) {
    if(_controllerText.text.isNotEmpty) {
      if(items.last.controllerName!.text.isNotEmpty
          && items.last.controllerMin!.text.isNotEmpty ){
      items.last.name = items.last.controllerName!.text;
      items.last.minute = int.parse(items.last.controllerMin!.text);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Fill in the fields component${items.length-1}', style: tsButton,),
              backgroundColor: col2,));
        return;
      }
      Sequence item = Sequence(name: _controllerText.text, components: items);
      context.read<SequenceBloc>().add(SaveSequence(item));
      Navigator.pop(context, 'OK');
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter sequence name', style: tsButton,),
            backgroundColor: col2,));
    }
  }
}
