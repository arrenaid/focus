import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class NewSequenceScreen extends StatefulWidget {
  const NewSequenceScreen({Key? key}) : super(key: key);

  @override
  State<NewSequenceScreen> createState() => _NewSequenceScreenState();
}

class _NewSequenceScreenState extends State<NewSequenceScreen> {
  var items = ['first', 'end'];

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
            const SizedBox(height: 20,),
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
              const SizedBox(height: 20,),
              //configurator
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildSequenceCard(index, context);
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

              //save
          const SizedBox(
            height: 20,),
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
                  child:  const Text(
                    'save',
                    style:tsDef,
                  ),
                ),),
            ],
          ),
        ),
      ),
    );
  }

  Container buildSequenceCard(int index, BuildContext context) {
    return Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0,),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    //width: 60,
                    decoration: BoxDecoration(
                      color: col3,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: const [ BoxShadow(
                        offset: Offset(4.0, 4.0),
                        blurRadius: 8.0,
                        color:  col3),
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
                              boxShadow: const [ BoxShadow(
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 8.0,
                                  color:  col4),
                              ],
                            ),
                            child: const Center(
                              child: TextField(
                                style: tsButton,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration.collapsed(
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
                                    boxShadow: const [ BoxShadow(
                                        offset: Offset(4.0, 4.0),
                                        blurRadius: 8.0,
                                        color:  col4),
                                    ],
                                  ),
                                  child: const Center(
                                    child: TextField(
                                      style: tsButton,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration.collapsed(
                                        border: InputBorder.none,
                                        hintText: 'minutes',
                                        hintStyle: tsButton,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width:10),
                              Expanded(child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    (items.length -1) == index
                                        ? items.add('next $index')
                                        : items.removeAt(index);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 16),
                                      shadowColor:  col4,
                                  minimumSize: const Size.fromHeight(50),
                                  alignment: Alignment.center,
                                  shape: const StadiumBorder(),
                                  backgroundColor: col5,
                                ),
                                child:(items.length -1) == index
                                    ? const Icon(CupertinoIcons.add,color: col4)
                                    : const Icon(CupertinoIcons.delete_simple,color: col4)
                              )),
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
                  );
  }
}
