import 'package:flutter/material.dart';

class ShowTriage extends StatelessWidget {
  final String ans1;
  final String ans2;
  final String ans3;
  final String ans4;
  final String ans5;
  final String ans6;
  final String ans6Place;
  final String ans7;
  final String ans8;
  final bool ans9;
  final bool ans10;
  final bool ans11;
  final bool ans12;
  final bool ans13;
  final bool ans14;
  final bool ans15;
  final bool ans16;
  final bool ans17;
  final bool ans18;
  final bool ans19;
  final String ans20;
  final bool ans21;
  final bool ans22;
  final bool ans23;
  final bool ans24;
  final bool ans25;
  final String ans26;
  final String first;
  final String last;
  final String employeeNum;
  final String municipality;
  final String barangay;
  final String department;
  final String plant;
  final String manager;
  ShowTriage(
      {Key key,
      @required this.ans1,
      @required this.ans2,
      @required this.ans3,
      @required this.ans4,
      @required this.ans5,
      @required this.ans6,
      @required this.ans6Place,
      @required this.ans7,
      @required this.ans8,
      @required this.ans9,
      @required this.ans10,
      @required this.ans11,
      @required this.ans12,
      @required this.ans13,
      @required this.ans14,
      @required this.ans15,
      @required this.ans16,
      @required this.ans17,
      @required this.ans18,
      @required this.ans19,
      @required this.ans20,
      @required this.ans21,
      @required this.ans22,
      @required this.ans23,
      @required this.ans24,
      @required this.ans25,
      @required this.ans26,
      @required this.first,
      @required this.last,
      @required this.employeeNum,
      @required this.municipality,
      @required this.barangay,
      @required this.department,
      @required this.plant,
      @required this.manager,
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('Triage Answers'),
      ),
      body: Container(    
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$first $last',style: TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Employee Number $employeeNum',style: TextStyle(fontSize: 14),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Municipality: $municipality',style: TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Barangay: $barangay',style: TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Department: $department',style: TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Plant: $plant',style: TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Manager: $manager',style: TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Exposure and Travel History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Question1: $ans1'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Question2: $ans2'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Question3: $ans3'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Question4: $ans4'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Question5: $ans5'),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Question6: $ans6'),
                    ),
                    ans6Place == '' ? SizedBox(width: 0,) : 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Travelled to: $ans6Place'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Question7: $ans7'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Question8: $ans8'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Signs and Symptoms', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans9 == true ? 'Body Aches: Yes' : 'Body Aches: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans10 == true ? 'Chills: Yes' : 'Chills: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans11 == true ? 'Cough: Yes' : 'Cough: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans12 == true ? 'Diarrhea: Yes' : 'Diarrhea: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans13 == true ? 'Fatigue: Yes' : 'Fatigue: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans14 == true ? 'Fever: Yes' : 'Fever: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans15 == true ? 'Headaches: Yes' : 'Headaches: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans16 == true ? 'Nasal Congestion: Yes' : 'Nasal Congestion: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans17 == true ? 'Shortness of Breath: Yes' : 'Shortness of Breath: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans18 == true ? 'Sore throat: Yes' : 'Sore Throat: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans19 == true ? 'Vommiting: Yes' : 'Vommiting: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans20 == '' ? 'Others: No answer' : 'Others: $ans20'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Health Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                 Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(ans21 == true ? 'Allergy: Yes' : 'Allergy: No'),
                    ),
                    ans21 == false ? SizedBox(width: 0,) : 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Allergy is: $ans26'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans22 == true ? 'Asthma: Yes' : 'Asthma: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans23 == true ? 'Diabetes: Yes' : 'Diabetes: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans24 == true ? 'Hypertension: Yes' : 'Hypertension: No'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ans25 == true ? 'Pregnant: Yes' : 'Pregnant: No'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}