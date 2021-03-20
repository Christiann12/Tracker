import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

String lobbyNumb = 'Lobby Number';
DateTime _dateTime;
DateTime _dateTime1;
String bday = '';
String bday1 = '';
String employeeNum = '';

class SearchLobbyData extends StatefulWidget {
  @override
  _SearchLobbyDataState createState() => _SearchLobbyDataState();
}

class _SearchLobbyDataState extends State<SearchLobbyData> {
  List<DataRow> cardList = [];
  List<List<String>> csvData = [
    <String>['Name', 'Employee#', 'Transportation Mode','Lobby Number' ,'Temperature','Date', 'Time In'],
  ];
  DataRow dataContainer(
      String name,
      String lastName,
      String employeeNum,
      String transpo,
      String lobbyNum,
      String temperature,
      String date,
      String timeIn,) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          '$name $lastName',
          style: TextStyle(fontSize: 10),
        )),
        DataCell(Text(
          '$employeeNum',
          style: TextStyle(fontSize: 10),
        )),
        DataCell(Text(
          '$transpo',
          style: TextStyle(fontSize: 10),
        )),
        DataCell(Text(
          '$lobbyNum',
          style: TextStyle(fontSize: 10),
        )),
        DataCell(Text(
          '$temperature',
          style: TextStyle(fontSize: 10),
        )),
        DataCell(Text(
          '$date',
          style: TextStyle(fontSize: 10),
        )),
        DataCell(Text(
          '$timeIn',
          style: TextStyle(fontSize: 10),
        )),
      ],
    );
  }
  void getCard() async {
    try {
      await Firestore.instance
          .collection('Lobby')
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
              if (datas.documents[i]['lobbyNum'] == lobbyNumb && ((comDay3.isAfter(comDay1) || comDay3.isAtSameMomentAs(comDay1)) && ( comDay3.isBefore(comDay2) || comDay3.isAtSameMomentAs(comDay2)))) {
                cardList.add(dataContainer(
                    datas.documents[i]['firstName'],
                    datas.documents[i]['lastName'],
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['transpoMode'],
                    datas.documents[i]['lobbyNum'], 
                    datas.documents[i]['temperature'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn'],));
                csvData.add(<String>[
                  '${datas.documents[i]['firstName']} ${datas.documents[i]['lastName']}', 
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['transpoMode'],
                    datas.documents[i]['lobbyNum'], 
                    datas.documents[i]['temperature'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn']
                    ]);
              } else {
                print('no');
              }
            }
            else{
              if (datas.documents[i]['lobbyNum'] == lobbyNumb && ((comDay3.isAfter(comDay1) || comDay3.isAtSameMomentAs(comDay1)) && ( comDay3.isBefore(comDay2) || comDay3.isAtSameMomentAs(comDay2))) && employeeNum == datas.documents[i]['employeeNumber']) {
                cardList.add(dataContainer(
                    datas.documents[i]['firstName'],
                    datas.documents[i]['lastName'],
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['transpoMode'],
                    datas.documents[i]['lobbyNum'],
                    datas.documents[i]['temperature'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn'],));
                csvData.add(<String>[
                  '${datas.documents[i]['firstName']} ${datas.documents[i]['lastName']}', 
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['transpoMode'],
                    datas.documents[i]['lobbyNum'], 
                    datas.documents[i]['temperature'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn']
                    ]);
              } else {
                print('no');
              }
            }
          });
        }
      });
      
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
                        value: lobbyNumb,
                        elevation: 3,
                        underline: Container(
                          height: 0,
                        ),
                        style: TextStyle(color: Colors.grey[600]),
                        onChanged: (String newValue) {
                          setState(() {
                            lobbyNumb = newValue;
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
                ),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: FlatButton(
                    color: Colors.blue[200],
                    onPressed: () {
                      if (lobbyNumb == 'Lobby Number' ||
                          bday == '' || bday1 == '') {
                        Toast.show("Fill up the fields above", context,
                            duration: 5, gravity: Toast.BOTTOM);
                      } else {
                        cardList.clear();
                        csvData.clear();
                        csvData.add(<String>['Name', 'Employee#', 'Transportation Mode','Lobby Number' ,'Temperature','Date', 'Time In'],);
                        getCard();
                      }
                    },
                    child: Center(child: Container(child: Text('Search', style: TextStyle(color: Colors.white)))),
                  ),
                ),
                Padding( 
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: FlatButton(
                    color: Colors.blue[200],
                    onPressed: () async {
                     try{
                        
                        if(csvData.length != 1){
                          String csv = const ListToCsvConverter().convert(csvData);
                          final String dir = (await getExternalStorageDirectory()).path;
                            final String path = '$dir/lobbySearchRecord.csv';
                          
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
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 650,
                child: ListView(
                  children: <Widget>[
                    DataTable(
                        columnSpacing: 5,
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
                              'Transportation Mode',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Lobby Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Temperature',
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
                              'Time in',
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
          ),
        ],
      ),
    );
  }
}