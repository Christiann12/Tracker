
import 'package:contacttracer/Widgets/triageCard.dart';
import 'package:contacttracer/process/triadBrain.dart';
import 'package:flutter/material.dart';

TriadBrain triadBrain = TriadBrain();
TriageCard triageCard = TriageCard();

class Part2Questions extends StatefulWidget {
  void reset(){
    triadBrain.reset();
  }
  @override
  _Part2QuestionsState createState() => _Part2QuestionsState();
}

class _Part2QuestionsState extends State<Part2Questions> {

  CheckboxListTile createCheckBox(int index){
    return CheckboxListTile(
      title: Text(triadBrain.getPart2Questions(index)),
      value: triadBrain.getBool(index),
      onChanged: (newValue) {
        setState(() {
          triadBrain.setBool(index, newValue);
          triageCard.setBoolInBrainPart2(index, newValue);
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }

  Widget getCheckBox(){
    List<CheckboxListTile> cardList = [];

    for(int x = 0; x <= triadBrain.getPart2Length()-1; x++){
      cardList.add(createCheckBox(x));
    }

    return new Column(children: cardList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getCheckBox()
      ],
    );
  }
}
