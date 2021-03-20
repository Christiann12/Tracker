import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacttracer/Widgets/showtriagewidget.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

String roomName = 'Room Name';
String temptime1 = '';
String time1 = '';
String temptime2 = '';
String time2 = '';
String employeeNum = '';
DateTime _dateTime;
DateTime _dateTime1;
String bday = '';
String bday1 = '';
int noofyes = 0;
class SearchTriageData extends StatefulWidget {
  @override
  _SearchTriageDataState createState() => _SearchTriageDataState();
}

class _SearchTriageDataState extends State<SearchTriageData> {
  List<DataRow> cardList = [];
  List<List<String>> csvData = [
    <String>['Name', 'Employee#','Municipality','Barangay','Department','Plant','Manager','Question1','Question2','Question3','Question4','Question5','Question6','Travelled to','Question7','Question8','Body Aches','Chills','Cough','Diarrhea','Fatigue','Fever','Headaches','Nasal Congestion','Shortness of Breath','Sore throat','Vommiting','Others','Allergy','Allergy is','Asthma','Diabetes','Hypertension','Pregnant', 'Date'],
  ];
   DataRow dataContainer(
      String name,
      String lastName,
      String employeeNum,
      String location,
      String date,
      String ans1,
      String ans2,
      String ans3,
      String ans4,
      String ans5,
      String ans6,
      String ans6Place,
      String ans7,
      String ans8,
      bool ans9,
      bool ans10,
      bool ans11,
      bool ans12,
      bool ans13,
      bool ans14,
      bool ans15,
      bool ans16,
      bool ans17,
      bool ans18,
      bool ans19,
      String ans20,
      bool ans21,
      bool ans22,
      bool ans23,
      bool ans24,
      bool ans25,
      String ans26,
      String municipality,
      String barangay,
      String department,
      String plant,
      String manager,) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          '$name $lastName',
          style: TextStyle(fontSize: 10),
        )),
        DataCell(
          Text(
          '$employeeNum',
          style: TextStyle(fontSize: 10),
          )
        ),
        DataCell(Text(
          '$location',
          style: TextStyle(fontSize: 10),
          
        )),
        DataCell(Text(
          '$date',
          style: TextStyle(fontSize: 10),
        )),
        DataCell(
          
          GestureDetector(
            onTap: (){
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowTriage
                    (ans1: ans1,
                      ans2: ans2,
                      ans3: ans3,
                      ans4: ans4,
                      ans5: ans5,
                      ans6: ans6,
                      ans6Place: ans6Place,
                      ans7: ans7,
                      ans8: ans8,
                      ans9: ans9,
                      ans10: ans10,
                      ans11: ans11,
                      ans12: ans12,
                      ans13: ans13,
                      ans14: ans14,
                      ans15: ans15,
                      ans16: ans16,
                      ans17: ans17,
                      ans18: ans18,
                      ans19: ans19,
                      ans20: ans20,
                      ans21: ans21,
                      ans22: ans22,
                      ans23: ans23,
                      ans24: ans24,
                      ans25: ans25,
                      ans26: ans26,
                      first: name,
                      last: lastName,
                      employeeNum: employeeNum,
                      municipality: municipality,
                      barangay: barangay,
                      department: department,
                      plant: plant,
                      manager: manager,
                    )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('View',style: TextStyle(fontSize: 10,decoration: TextDecoration.underline,),),
                Icon(Icons.keyboard_arrow_right)
                ],
            ),
          )
        ),
      ],
    );
  }
  
  void getCard() async {
    List<String> _listOfPlaces = [
      'Shuttle',
      'Lobby'
    ];
    try {
      for (var v = 0; v <= _listOfPlaces.length-1; v++) {
        await Firestore.instance
            .collection(_listOfPlaces[v])
            .getDocuments()
            .then((datas) {
          for (var i = 0; i < datas.documents.length; i++) {
            setState(() {
              var comDay1;
              var comDay2;
              var comDay3;
              var day3 = datas.documents[i]['date'];
        
              comDay1 =  new DateFormat.yMd().parse(bday);
              comDay2 =  new DateFormat.yMd().parse(bday1);
              comDay3 =  new DateFormat.yMd().parse(day3);
              
              if (employeeNum == '') {
                if (datas.documents[i]['triageState'] == 'yes' && ((comDay3.isAfter(comDay1) || comDay3.isAtSameMomentAs(comDay1)) && ( comDay3.isBefore(comDay2) || comDay3.isAtSameMomentAs(comDay2)))) {
                  
                  cardList.add(dataContainer(
                      datas.documents[i]['firstName'],
                      datas.documents[i]['lastName'],
                      datas.documents[i]['employeeNumber'],
                      _listOfPlaces[v],
                      datas.documents[i]['date'],
                      datas.documents[i]['exposureAndTravelHistory']['question1'],
                      datas.documents[i]['exposureAndTravelHistory']['question2'],
                      datas.documents[i]['exposureAndTravelHistory']['question3'],
                      datas.documents[i]['exposureAndTravelHistory']['question4'],
                      datas.documents[i]['exposureAndTravelHistory']['question5'],
                      datas.documents[i]['exposureAndTravelHistory']['question6'],
                      datas.documents[i]['exposureAndTravelHistory']['travelledPlace'],
                      datas.documents[i]['exposureAndTravelHistory']['question7'],
                      datas.documents[i]['exposureAndTravelHistory']['question8'],
                      datas.documents[i]['signsAndSymptoms']['bodyAches'],
                      datas.documents[i]['signsAndSymptoms']['chills'],
                      datas.documents[i]['signsAndSymptoms']['cough'],
                      datas.documents[i]['signsAndSymptoms']['diarrhea'],
                      datas.documents[i]['signsAndSymptoms']['fatigue'],
                      datas.documents[i]['signsAndSymptoms']['fever'],
                      datas.documents[i]['signsAndSymptoms']['headAches'],
                      datas.documents[i]['signsAndSymptoms']['nasalCongestion'],
                      datas.documents[i]['signsAndSymptoms']['shortnessOfBreath'],
                      datas.documents[i]['signsAndSymptoms']['soreThroat'],
                      datas.documents[i]['signsAndSymptoms']['vommiting'],
                      datas.documents[i]['signsAndSymptoms']['others'],
                      datas.documents[i]['healthStatus']['allergy'],
                      datas.documents[i]['healthStatus']['asthma'],
                      datas.documents[i]['healthStatus']['diabetes'],
                      datas.documents[i]['healthStatus']['hypertension'],
                      datas.documents[i]['healthStatus']['pregnant'],
                      datas.documents[i]['healthStatus']['specificAllergy'],
                      datas.documents[i]['municipality'],
                      datas.documents[i]['barangay'],
                      datas.documents[i]['department'],
                      datas.documents[i]['plant'],
                      datas.documents[i]['manager']
                      ));
                  csvData.add(<String>[
                  '${datas.documents[i]['firstName']} ${datas.documents[i]['lastName']}', 
                      datas.documents[i]['employeeNumber'],
                      datas.documents[i]['municipality'],
                      datas.documents[i]['barangay'],
                      datas.documents[i]['department'],
                      datas.documents[i]['plant'],
                      datas.documents[i]['manager'],
                      datas.documents[i]['exposureAndTravelHistory']['question1'],
                      datas.documents[i]['exposureAndTravelHistory']['question2'],
                      datas.documents[i]['exposureAndTravelHistory']['question3'],
                      datas.documents[i]['exposureAndTravelHistory']['question4'],
                      datas.documents[i]['exposureAndTravelHistory']['question5'],
                      datas.documents[i]['exposureAndTravelHistory']['question6'],
                      datas.documents[i]['exposureAndTravelHistory']['travelledPlace'],
                      datas.documents[i]['exposureAndTravelHistory']['question7'],
                      datas.documents[i]['exposureAndTravelHistory']['question8'],
                      datas.documents[i]['signsAndSymptoms']['bodyAches']== true ? 'Body Aches: Yes' : 'Body Aches: No',
                      datas.documents[i]['signsAndSymptoms']['chills']== true ? 'Chills: Yes' : 'Chills: No',
                      datas.documents[i]['signsAndSymptoms']['cough']== true ? 'Cough: Yes' : 'Cough: No',
                      datas.documents[i]['signsAndSymptoms']['diarrhea']== true ? 'Diarrhea: Yes' : 'Diarrhea: No',
                      datas.documents[i]['signsAndSymptoms']['fatigue'] == true ? 'Fatigue: Yes' : 'Fatigue: No',
                      datas.documents[i]['signsAndSymptoms']['fever']== true ? 'Fever: Yes' : 'Fever: No',
                      datas.documents[i]['signsAndSymptoms']['headAches']== true ? 'Headaches: Yes' : 'Headaches: No',
                      datas.documents[i]['signsAndSymptoms']['nasalCongestion']== true ? 'Nasal Congestion: Yes' : 'Nasal Congestion: No',
                      datas.documents[i]['signsAndSymptoms']['shortnessOfBreath'] == true ? 'Shortness of Breath: Yes' : 'Shortness of Breath: No',
                      datas.documents[i]['signsAndSymptoms']['soreThroat']== true ? 'Sore throat: Yes' : 'Sore Throat: No',
                      datas.documents[i]['signsAndSymptoms']['vommiting']== true ? 'Vommiting: Yes' : 'Vommiting: No',
                      datas.documents[i]['signsAndSymptoms']['others'],
                      datas.documents[i]['healthStatus']['allergy']== true ? 'Allergy: Yes' : 'Allergy: No',
                      datas.documents[i]['healthStatus']['specificAllergy'],
                      datas.documents[i]['healthStatus']['asthma']== true ? 'Asthma: Yes' : 'Asthma: No',
                      datas.documents[i]['healthStatus']['diabetes']== true ? 'Diabetes: Yes' : 'Diabetes: No',
                      datas.documents[i]['healthStatus']['hypertension']== true ? 'Hypertension: Yes' : 'Hypertension: No',
                      datas.documents[i]['healthStatus']['pregnant'] == true ? 'Pregnant: Yes' : 'Pregnant: No',
                      datas.documents[i]['date']
                    ]);
                } else {
                  print('no');
                }
              }
              else{
                if (datas.documents[i]['triageState'] == 'yes' && ((comDay3.isAfter(comDay1) || comDay3.isAtSameMomentAs(comDay1)) && ( comDay3.isBefore(comDay2) || comDay3.isAtSameMomentAs(comDay2))) && employeeNum == datas.documents[i]['employeeNumber']) {
                  cardList.add(dataContainer(
                      datas.documents[i]['firstName'],
                      datas.documents[i]['lastName'],
                      datas.documents[i]['employeeNumber'],
                      _listOfPlaces[v],
                      datas.documents[i]['date'],
                      datas.documents[i]['exposureAndTravelHistory']['question1'],
                      datas.documents[i]['exposureAndTravelHistory']['question2'],
                      datas.documents[i]['exposureAndTravelHistory']['question3'],
                      datas.documents[i]['exposureAndTravelHistory']['question4'],
                      datas.documents[i]['exposureAndTravelHistory']['question5'],
                      datas.documents[i]['exposureAndTravelHistory']['question6'],
                      datas.documents[i]['exposureAndTravelHistory']['travelledPlace'],
                      datas.documents[i]['exposureAndTravelHistory']['question7'],
                      datas.documents[i]['exposureAndTravelHistory']['question8'],
                      datas.documents[i]['signsAndSymptoms']['bodyAches'],
                      datas.documents[i]['signsAndSymptoms']['chills'],
                      datas.documents[i]['signsAndSymptoms']['cough'],
                      datas.documents[i]['signsAndSymptoms']['diarrhea'],
                      datas.documents[i]['signsAndSymptoms']['fatigue'],
                      datas.documents[i]['signsAndSymptoms']['fever'],
                      datas.documents[i]['signsAndSymptoms']['headAches'],
                      datas.documents[i]['signsAndSymptoms']['nasalCongestion'],
                      datas.documents[i]['signsAndSymptoms']['shortnessOfBreath'],
                      datas.documents[i]['signsAndSymptoms']['soreThroat'],
                      datas.documents[i]['signsAndSymptoms']['vommiting'],
                      datas.documents[i]['signsAndSymptoms']['others'],
                      datas.documents[i]['healthStatus']['allergy'],
                      datas.documents[i]['healthStatus']['asthma'],
                      datas.documents[i]['healthStatus']['diabetes'],
                      datas.documents[i]['healthStatus']['hypertension'],
                      datas.documents[i]['healthStatus']['pregnant'],
                      datas.documents[i]['healthStatus']['specificAllergy'],
                      datas.documents[i]['municipality'],
                      datas.documents[i]['barangay'],
                      datas.documents[i]['department'],
                      datas.documents[i]['plant'],
                      datas.documents[i]['manager']));
                  csvData.add(<String>[
                  '${datas.documents[i]['firstName']} ${datas.documents[i]['lastName']}', 
                      datas.documents[i]['employeeNumber'],
                      datas.documents[i]['municipality'],
                      datas.documents[i]['barangay'],
                      datas.documents[i]['department'],
                      datas.documents[i]['plant'],
                      datas.documents[i]['manager'],
                      datas.documents[i]['exposureAndTravelHistory']['question1'],
                      datas.documents[i]['exposureAndTravelHistory']['question2'],
                      datas.documents[i]['exposureAndTravelHistory']['question3'],
                      datas.documents[i]['exposureAndTravelHistory']['question4'],
                      datas.documents[i]['exposureAndTravelHistory']['question5'],
                      datas.documents[i]['exposureAndTravelHistory']['question6'],
                      datas.documents[i]['exposureAndTravelHistory']['travelledPlace'],
                      datas.documents[i]['exposureAndTravelHistory']['question7'],
                      datas.documents[i]['exposureAndTravelHistory']['question8'],
                      datas.documents[i]['signsAndSymptoms']['bodyAches']== true ? 'Body Aches: Yes' : 'Body Aches: No',
                      datas.documents[i]['signsAndSymptoms']['chills']== true ? 'Chills: Yes' : 'Chills: No',
                      datas.documents[i]['signsAndSymptoms']['cough']== true ? 'Cough: Yes' : 'Cough: No',
                      datas.documents[i]['signsAndSymptoms']['diarrhea']== true ? 'Diarrhea: Yes' : 'Diarrhea: No',
                      datas.documents[i]['signsAndSymptoms']['fatigue'] == true ? 'Fatigue: Yes' : 'Fatigue: No',
                      datas.documents[i]['signsAndSymptoms']['fever']== true ? 'Fever: Yes' : 'Fever: No',
                      datas.documents[i]['signsAndSymptoms']['headAches']== true ? 'Headaches: Yes' : 'Headaches: No',
                      datas.documents[i]['signsAndSymptoms']['nasalCongestion']== true ? 'Nasal Congestion: Yes' : 'Nasal Congestion: No',
                      datas.documents[i]['signsAndSymptoms']['shortnessOfBreath'] == true ? 'Shortness of Breath: Yes' : 'Shortness of Breath: No',
                      datas.documents[i]['signsAndSymptoms']['soreThroat']== true ? 'Sore throat: Yes' : 'Sore Throat: No',
                      datas.documents[i]['signsAndSymptoms']['vommiting']== true ? 'Vommiting: Yes' : 'Vommiting: No',
                      datas.documents[i]['signsAndSymptoms']['others'],
                      datas.documents[i]['healthStatus']['allergy']== true ? 'Allergy: Yes' : 'Allergy: No',
                      datas.documents[i]['healthStatus']['specificAllergy'],
                      datas.documents[i]['healthStatus']['asthma']== true ? 'Asthma: Yes' : 'Asthma: No',
                      datas.documents[i]['healthStatus']['diabetes']== true ? 'Diabetes: Yes' : 'Diabetes: No',
                      datas.documents[i]['healthStatus']['hypertension']== true ? 'Hypertension: Yes' : 'Hypertension: No',
                      datas.documents[i]['healthStatus']['pregnant'] == true ? 'Pregnant: Yes' : 'Pregnant: No',
                      datas.documents[i]['date']
                    ]);
                } else {
                  print('no');
                }
              }
            });
          }
        });
      }
      
      if(cardList.length == 0){
        Toast.show('No data found', context, duration: 5, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show('Something went wrong', context,
          duration: 5, gravity: Toast.BOTTOM);
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    onChanged: (val) {
                      employeeNum = val;
                    },
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
                    child: GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1, 1, 1991),
                            maxTime: DateTime.now(), onChanged: (date) {
                          print('change $bday');
                        }, onConfirm: (date) {
                          setState(() {
                            _dateTime = date;
                            //bday = _dateTime.toIso8601String().substring(0, 10);
                            bday =
                                '${_dateTime.toIso8601String()[5] != '0' ? _dateTime.toIso8601String().substring(5, 7) : _dateTime.toIso8601String().substring(6, 7)}/${_dateTime.toIso8601String()[8] != '0' ? _dateTime.toIso8601String().substring(8, 10) : _dateTime.toIso8601String().substring(9, 10)}/${_dateTime.toIso8601String().substring(0, 4)}';
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 8),
                            child: Text(
                              _dateTime == null ? 'Date' : 'From: $bday',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ),
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
                    child: GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1, 1, 1991),
                            maxTime: DateTime.now(), onChanged: (date) {
                          print('change $bday');
                        }, onConfirm: (date) {
                          setState(() {
                            _dateTime1 = date;
                            //bday = _dateTime.toIso8601String().substring(0, 10);
                            bday1 =
                                '${_dateTime1.toIso8601String()[5] != '0' ? _dateTime1.toIso8601String().substring(5, 7) : _dateTime1.toIso8601String().substring(6, 7)}/${_dateTime1.toIso8601String()[8] != '0' ? _dateTime1.toIso8601String().substring(8, 10) : _dateTime1.toIso8601String().substring(9, 10)}/${_dateTime1.toIso8601String().substring(0, 4)}';
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 8),
                            child: Text(
                              _dateTime1 == null ? 'Date' : 'To: $bday1',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
                  ),
                  ],
                )
                ,Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: FlatButton(
                    color: Colors.blue[200],
                    onPressed: () {
                      if (bday == '' ||
                          bday1 == '' ) {
                        Toast.show("Fill up the fields above", context,
                            duration: 5, gravity: Toast.BOTTOM);
                      } else {
                        cardList.clear();
                        csvData.clear();
                          csvData.add(<String>['Name', 'Employee#','Municipality','Barangay','Department','Plant','Manager','Question1','Question2','Question3','Question4','Question5','Question6','Travelled to','Question7','Question8','Body Aches','Chills','Cough','Diarrhea','Fatigue','Fever','Headaches','Nasal Congestion','Shortness of Breath','Sore throat','Vommiting','Others','Allergy','Allergy is','Asthma','Diabetes','Hypertension','Pregnant', 'Date'],);
                        getCard();
                      }
                    },
                    child: Container(child: Center(child: Text('Search', style: TextStyle(color: Colors.white)))),
                  ),
                )
                ,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: FlatButton(
                    color: Colors.blue[200],
                    onPressed: () async {
                     try{
                        
                        if(csvData.length != 1){
                          String csv = const ListToCsvConverter().convert(csvData);
                          final String dir = (await getExternalStorageDirectory()).path;
                            final String path = '$dir/triageSearchRecord.csv';
                          
                          print(path);

                          final File file = File(path);
                          
                          await file.writeAsString(csv);
                          Toast.show('Done exporting you can find the file in $path', context,duration: 8,gravity: Toast.BOTTOM);
                        }
                        else{
                          Toast.show('No search Records', context,duration: 5,gravity: Toast.BOTTOM);
                        }
                     }
                     catch (e){
                       Toast.show(e.message, context,duration: 5,gravity: Toast.BOTTOM);
                     }
                    },
                    child: Container(child: Center(child: Text('Export', style: TextStyle(color: Colors.white)))),
                  ),
                )
              ],
            )
          ),
          Expanded(
          flex:3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 500,
                child: ListView(
                  children: <Widget>[
                    DataTable(
                        columnSpacing: 10,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Employee#',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Location',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'View Triage',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                        ],
                        rows: cardList),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}