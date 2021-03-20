import 'package:contacttracer/Widgets/triageCard.dart';
import 'package:contacttracer/process/triadBrain.dart';
import 'package:flutter/material.dart';

TriadBrain triadBrain = TriadBrain();
TriageCard triageCard = TriageCard();
TextEditingController controller1 = TextEditingController();

class Part3Questions extends StatefulWidget {
  void reset(){
    controller1.clear();
    triadBrain.reset();
  }
  @override
  _Part3QuestionsState createState() => _Part3QuestionsState();
}

class _Part3QuestionsState extends State<Part3Questions> {
  CheckboxListTile createCheckBox(int index) {
    return CheckboxListTile(
        title: Text(triadBrain.getPart3Questions(index)),
        value: triadBrain.getPart2Bool(index),
        onChanged: (newValue) {
          setState(() {
            triadBrain.setPart2Bool(index, newValue);
            triageCard.setBoolInBrainPart3(index, newValue);
            if (index == 4){
              triageCard.setAlleryString('');
              controller1.clear();
            }
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
        secondary: index == 4
            ? Form(
                child: Container(
                width: 180,
                height: 50,
                child: TextFormField(
                  controller: controller1,
                  onChanged: (val){
                    triageCard.setAlleryString(val);
                  },
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[200]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[200]),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[200])),
                    hintText: "Specify",
                  ),
                ),
              ))
            : null //  <-- leading Checkbox
        );
  }

  Widget getCheckBox() {
    List<CheckboxListTile> cardList = [];

    for (int x = 0; x <= triadBrain.getPart3Length() - 1; x++) {
      cardList.add(createCheckBox(x));
    }

    return new Column(children: cardList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[getCheckBox(),
      ],
    );
  }
}
