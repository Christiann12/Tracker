import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacttracer/process/triageBrainOffline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

String employeeNum = '';
String firstName = '';
String lastName = '';
String barangay = '';
String municipality = '';
String department = '';
String plant = '';
String manager = '';
String transpoMode = 'Transportation Mode';
String lobbyNum = 'Lobby Number';
String number6Ans = '';
String temperature = '';
String temptime2 = '';
String time2 = '';
bool yesState = false;
bool signature = false;
bool check1 = false;
bool check2 = false;
bool check3 = false;
bool check4 = false;
TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
TextEditingController controller3 = TextEditingController();
TextEditingController controller4 = TextEditingController();
TextEditingController controller5 = TextEditingController();
TextEditingController controller6 = TextEditingController();
TextEditingController controller7 = TextEditingController();
TextEditingController controller8 = TextEditingController();
TextEditingController controller9 = TextEditingController();
TextEditingController controller10 = TextEditingController();

TriageBrainOffline tBrainOffline = TriageBrainOffline();

class OffllineLobby extends StatefulWidget {
  @override
  _OffllineLobbyState createState() => _OffllineLobbyState();
}

class _OffllineLobbyState extends State<OffllineLobby> {
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    employeeNum = '';
    firstName = '';
    lastName = '';
    barangay = '';
    municipality = '';
    department = '';
    plant = '';
    manager = '';
    transpoMode = 'Transportation Mode';
    lobbyNum = 'Lobby Number';
    number6Ans = '';
    temperature = '';
    temptime2 = '';
    time2 = '';
    signature = false;
    check1 = false;
    check2 = false;
    check3 = false;
    check4 = false;
    yesState = false;
    controller1.clear();
    controller2.clear();
    controller3.clear();
    controller4.clear();
    controller5.clear();
    controller6.clear();
    controller7.clear();
    controller8.clear();
    controller9.clear();
    controller10.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Lobby Input'),
        backgroundColor: Colors.blue[200],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TextFormField(
              controller: controller1,
              maxLength: 6,
              validator: (val) => val.isEmpty ? 'Required Field' : null,
              onChanged: (val) {
                setState(() {
                  employeeNum = val;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: '',
                  hintStyle: TextStyle(fontSize: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[200]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[200]),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[200])),
                  hintText: 'Employee Number'),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: controller2,
                    validator: (val) => val.isEmpty ? 'Required Field' : null,
                    onChanged: (val) {
                      setState(() {
                        firstName = val;
                      });
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
                        hintText: 'First Name '),
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                height: 1,
                width: 3,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: controller3,
                    validator: (val) => val.isEmpty ? 'Required Field' : null,
                    onChanged: (val) {
                      setState(() {
                        lastName = val;
                      });
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
                        hintText: 'Last Name'),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                    color: Colors.blue[200],
                    style: BorderStyle.solid,
                    width: 0.80),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: transpoMode,
                  elevation: 3,
                  underline: Container(
                    height: 0,
                  ),
                  style: TextStyle(color: Colors.grey[600]),
                  onChanged: (String newValue) {
                    setState(() {
                      transpoMode = newValue;
                    });
                  },
                  items: <String>[
                    'Transportation Mode',
                    'Shuttle',
                    'Private Car'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                    color: Colors.blue[200],
                    style: BorderStyle.solid,
                    width: 0.80),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: lobbyNum,
                  elevation: 3,
                  underline: Container(
                    height: 0,
                  ),
                  style: TextStyle(color: Colors.grey[600]),
                  onChanged: (String newValue) {
                    setState(() {
                      lobbyNum = newValue;
                    });
                  },
                  items: <String>[
                    'Lobby Number',
                    'A4',
                    'A5',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TextFormField(
              controller: controller4,
              validator: (val) => val.isEmpty ? 'Required Field' : null,
              onChanged: (val) {
                temperature = val;
              },
              keyboardType: TextInputType.number,
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
                  hintText: 'Temperature'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: GestureDetector(
              onTap: () {
                DatePicker.showTimePicker(context, showTitleActions: true,
                    onConfirm: (date) {
                  temptime2 = '';
                  String tempText =
                      '${date.toString().substring(11, date.toString().length)}';
                  int tempNum = 1;
                  for (int i = 0; i <= tempText.length - 1; i++) {
                    if (tempText[i] == ':' && tempNum == 2) {
                      setState(() {
                        time2 = temptime2;
                      });
                      break;
                    } else {
                      temptime2 = '$temptime2${tempText[i]}';
                    }
                    if (tempText[i] == ':') {
                      tempNum++;
                    }
                  }
                }, currentTime: DateTime.now());
              },
              child: Container(
                height: 60.0,
                //width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue[200]),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                    child: Text(
                      time2 == '' ? 'Time in' : 'Time in: $time2',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
            ),
          ),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: controller5,
                    validator: (val) =>
                        val.isEmpty ? 'Enter your Barangay' : null,
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
                      hintText: "Barangay",
                    ),
                    onChanged: (val) {
                      setState(() {
                        barangay = val;
                      });
                    },
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: controller6,
                    validator: (val) =>
                        val.isEmpty ? 'Enter your municipality' : null,
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
                      hintText: "Municipality",
                    ),
                    onChanged: (val) {
                      setState(() {
                        municipality = val;
                      });
                    },
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: controller7,
                    validator: (val) =>
                        val.isEmpty ? 'Enter your Department' : null,
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
                      hintText: "Department",
                    ),
                    onChanged: (val) {
                      setState(() {
                        department = val;
                      });
                    },
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: controller8,
                    validator: (val) => val.isEmpty ? 'Enter your Plant' : null,
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
                      hintText: "Plant",
                    ),
                    onChanged: (val) {
                      setState(() {
                        plant = val;
                      });
                    },
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    controller: controller9,
                    validator: (val) =>
                        val.isEmpty ? 'Enter your Manager/Supervisor' : null,
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
                      hintText: "Manager/Supervisor",
                    ),
                    onChanged: (val) {
                      setState(() {
                        manager = val;
                      });
                    },
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    'Triage Questionnaire',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Container(
                    height: tBrainOffline.getAns6() == 'Yes' ? 1150 : 820,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tBrainOffline.getListLength(),
                      itemBuilder: (context, index) {
                        return Card(
                            child: Column(
                          children: <Widget>[
                            Text(
                              tBrainOffline.getTriadQuestion(index),
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            index == 5 && tBrainOffline.getListLength() == 8
                                ? Form(
                                    key: _formKey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        onChanged: (val) {
                                          number6Ans = val;
                                        },
                                        validator: (val) => val.isEmpty
                                            ? 'Required field'
                                            : null,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(fontSize: 15),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue[200]),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue[200]),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue[200])),
                                          hintText: "Place",
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                FlatButton(
                                  color: tBrainOffline.getColor1(index + 1),
                                  onPressed: () {
                                    setState(() {
                                      tBrainOffline.setColor(index + 1, 'Yes');
                                      tBrainOffline.setAnswer(index + 1, 'Yes');
                                    });
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                FlatButton(
                                  color: tBrainOffline.getColor2(index + 1),
                                  onPressed: () {
                                    setState(() {
                                      tBrainOffline.setColor(index + 1, 'No');
                                      tBrainOffline.setAnswer(index + 1, 'No');
                                      if (index == 5) {
                                        number6Ans = '';
                                      }
                                      //_mode = 'out';
                                      //print(_mode);
                                    });
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ));
                      },
                    ),
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    'Signs and Symptoms',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Text(
                      'Please check any applicable symptoms you experienced in the last 14 days.'),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Container(
                  height: 610,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tBrainOffline.getPart2Length(),
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(tBrainOffline.getPart2Questions(index)),
                        value: tBrainOffline.getBool(index),
                        onChanged: (newValue) {
                          setState(() {
                            tBrainOffline.setBool(index, newValue);
                            //triageCard.setBoolInBrainPart2(index, newValue);
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      );
                    },
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (val) {
                      tBrainOffline.setOtherSymptoms(val);
                    },
                    validator: (val) => val.isEmpty ? 'Required field' : null,
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
                      hintText: "Others please specify",
                    ),
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    'Health Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Text('Do you have any of the following?'),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Container(
                  height: 300,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tBrainOffline.getPart3Length(),
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                          title: Text(tBrainOffline.getPart3Questions(index)),
                          value: tBrainOffline.getPart2Bool(index),
                          onChanged: (newValue) {
                            setState(() {
                              tBrainOffline.setPart2Bool(index, newValue);
                              if (index == 4) {
                                tBrainOffline.setSpecificAllergyString('');
                                controller10.clear();
                              }
                              //triageCard.setBoolInBrainPart2(index, newValue);
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          secondary: index == 4
                              ? Form(
                                  child: Container(
                                  width: 180,
                                  height: 50,
                                  child: TextFormField(
                                    controller: controller10,
                                    onChanged: (val) {
                                      tBrainOffline
                                          .setSpecificAllergyString(val);
                                    },
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 15),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue[200]),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue[200]),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue[200])),
                                      hintText: "Specify",
                                    ),
                                  ),
                                ))
                              : null //  <-- lea //  <-- leading Checkbox
                          );
                    },
                  ),
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? Divider(
                  color: Colors.black,
                  thickness: 1,
                )
              : SizedBox(),
          transpoMode == 'Private Car'
              ? CheckboxListTile(
                  value: signature,
                  title: RichText(
                    text: TextSpan(
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'I'),
                          TextSpan(
                              text: ' $firstName $lastName',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: ' with employee number'),
                          TextSpan(
                              text: ' $employeeNum',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  ' declare that all answers I provide in this Triage Questionnaire are true and correct. I am also aware that I will be held responsible, liable, and might be severely punished if I came in with symptoms of COVID-19, identified as Confirmed, Suspect or Probable, part of the contact tracing in my community, or have contact or living with someone who is a COVID positive')
                        ]),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      signature = newValue;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                )
              : SizedBox(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: FlatButton(
              color: Colors.blue[200],
              onPressed: () {
                if (transpoMode == 'Private Car') {
                  //check part1
                  if (employeeNum != '' &&
                      firstName != '' &&
                      lastName != '' &&
                      lobbyNum != 'Lobby Number' &&
                      temperature != '' &&
                      time2 != '' &&
                      barangay != '' &&
                      municipality != '' &&
                      department != '' &&
                      plant != '' &&
                      manager != '') {
                    check1 = true;
                  } else {
                    check1 = false;
                  }
                  //check part2
                  if (tBrainOffline.getAns1() != '' &&
                      tBrainOffline.getAns2() != '' &&
                      tBrainOffline.getAns3() != '' &&
                      tBrainOffline.getAns4() != '' &&
                      tBrainOffline.getAns5() != '' &&
                      tBrainOffline.getAns6() != '') {
                    if (tBrainOffline.getAns6() == 'No') {
                      tBrainOffline.setAnswer(7, 'No');
                      tBrainOffline.setAnswer(8, 'No');
                      check2 = true;
                    } else if (tBrainOffline.getAns6() == 'Yes' &&
                        (tBrainOffline.getAns7() == '' ||
                            tBrainOffline.getAns8() == '' ||
                            number6Ans == '')) {
                      check2 = false;
                    } else {
                      check2 = true;
                    }
                  } else {
                    check2 = false;
                  }
                  // check part 3
                  if (tBrainOffline.getCheck5Part2() == true) {
                    if (tBrainOffline.getAllergy() != '') {
                      check3 = true;
                    } else {
                      check3 = false;
                    }
                  } else if (tBrainOffline.getCheck5Part2() == false) {
                    check3 = true;
                  }
                  //check part 4
                  if (signature == true) {
                    check4 = true;
                  } else {
                    check4 = false;
                  }
                  if (check1 == true &&
                      check2 == true &&
                      check3 == true &&
                      check4 == true) {
                    if(tBrainOffline.getAns1() == 'Yes'|| tBrainOffline.getAns2() == 'Yes' || tBrainOffline.getAns3() == 'Yes' || tBrainOffline.getAns4() == 'Yes' || tBrainOffline.getAns5() == 'Yes' || tBrainOffline.getAns6() == 'Yes'|| tBrainOffline.getAns8() == 'Yes'|| tBrainOffline.getAns8() == 'Yes' ||
                      tBrainOffline.getCheck1() == true || tBrainOffline.getCheck2()== true || tBrainOffline.getCheck3()== true || tBrainOffline.getCheck4()== true || tBrainOffline.getCheck5()== true || tBrainOffline.getCheck6()== true || tBrainOffline.getCheck7()== true || tBrainOffline.getCheck8()== true || tBrainOffline.getCheck9() == true || tBrainOffline.getCheck10() == true || tBrainOffline.getCheck11()== true){
                      yesState = true;
                    }
                    tBrainOffline.submitLobby(
                        yesState,
                        employeeNum,
                        firstName,
                        lastName,
                        barangay,
                        municipality,
                        department,
                        plant,
                        manager,
                        transpoMode,
                        lobbyNum,
                        temperature,
                        time2,
                        tBrainOffline.getAns1(),
                        tBrainOffline.getAns2(),
                        tBrainOffline.getAns3(),
                        tBrainOffline.getAns4(),
                        tBrainOffline.getAns5(),
                        tBrainOffline.getAns6(),
                        tBrainOffline.getAns7(),
                        tBrainOffline.getAns8(),
                        number6Ans,
                        tBrainOffline.getCheck1(),
                        tBrainOffline.getCheck2(),
                        tBrainOffline.getCheck3(),
                        tBrainOffline.getCheck4(),
                        tBrainOffline.getCheck5(),
                        tBrainOffline.getCheck6(),
                        tBrainOffline.getCheck7(),
                        tBrainOffline.getCheck8(),
                        tBrainOffline.getCheck9(),
                        tBrainOffline.getCheck10(),
                        tBrainOffline.getCheck11(),
                        tBrainOffline.getOtherSymp(),
                        tBrainOffline.getCheck1Part2(),
                        tBrainOffline.getCheck2Part2(),
                        tBrainOffline.getCheck3Part2(),
                        tBrainOffline.getCheck4Part2(),
                        tBrainOffline.getCheck5Part2(),
                        tBrainOffline.getAllergy());
                    tBrainOffline.reset();
                    Navigator.pop(context);
                    Toast.show('Success your record will be recorded', context,
                        duration: 5, gravity: Toast.BOTTOM);
                  } else {
                    Toast.show('Form is incomplete', context,
                        duration: 3, gravity: Toast.BOTTOM);
                  }
                } else if (transpoMode == 'Shuttle') {
                  if (employeeNum != '' &&
                      firstName != '' &&
                      lastName != '' &&
                      lobbyNum != 'Lobby Number' &&
                      temperature != '' &&
                      time2 != '') {
                    check1 = true;
                  } else {
                    check1 = false;
                  }
                  if (check1 == true) {
                    try {
                      var now = new DateTime.now();
                      
                      DocumentReference records = Firestore.instance
                          .collection('Lobby')
                          .document(
                              '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-$time2-$employeeNum-offline');
                      Firestore.instance.settings(persistenceEnabled: true);
                      records.setData({
                        'documentId' : '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-$employeeNum',
                        'transpoMode' : transpoMode,
                        'date' : DateFormat.yMd().format(now),
                        'timeIn' : time2,
                        'firstName' : firstName,
                        'lastName' : lastName,
                        'employeeNumber' : employeeNum,
                        'temperature' : '$temperature ˚C' ,
                        'lobbyNum' : lobbyNum,
                      });
                      Navigator.pop(context);
                      Toast.show(
                          'Success your record will be recorded', context,
                          duration: 5, gravity: Toast.BOTTOM);
                    } catch (e) {
                      Toast.show(e.message, context,
                          duration: 5, gravity: Toast.BOTTOM);
                    }
                    Toast.show('Success your record will be recorded', context,
                        duration: 5, gravity: Toast.BOTTOM);
                  } else {
                    Toast.show('Form is incomplete', context,
                        duration: 3, gravity: Toast.BOTTOM);
                  }
                }
                else{
                  Toast.show('Form is incomplete', context,
                        duration: 3, gravity: Toast.BOTTOM);
                }
              },
              child: Center(
                  child: Text('Submit', style: TextStyle(color: Colors.white))),
            ),
          )
        ],
      ),
    );
  }
}
