import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:toast/toast.dart';
String tableNum = '';
String temptime1 = '';
String time1 = '';
String temptime2 = '';
String time2 = '';
String employeeNum = '';
String dineMode = 'Dine Mode';
DateTime _dateTime;
DateTime _dateTime1;
String bday = '';
String bday1 = '';
bool search = false;
class SearchCanteenData extends StatefulWidget {
  @override
  _SearchCanteenDataState createState() => _SearchCanteenDataState();
}

class _SearchCanteenDataState extends State<SearchCanteenData> {
  final _formKey = GlobalKey<FormState>();
  List<DataRow> cardList = [];
  List<List<String>> csvData = [
    <String>['Name', 'Employee#', 'Dine Mode','Seat Number', 'Table Number','Date', 'Time In', 'Time Out'],
  ];
    DataRow dataContainer(
      String name,
      String lastName,
      String employeeNum,
      String dineMode,
      String tableNum,
      String seatNum,
      String date,
      String timeIn,
      String timeOut) {
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
          '$dineMode',
          style: TextStyle(fontSize: 10),
        )),
        DataCell(Text(
          dineMode == 'dine in' ? '$seatNum' : 'Dine Out',
          style: TextStyle(fontSize: 10),
        )),
        DataCell(Text(
          dineMode == 'dine in' ? '$tableNum' : 'Dine Out',
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
        DataCell(Text(
          '$timeOut',
          style: TextStyle(fontSize: 10),
        )),
      ],
    );
  }
  void getCardDineIn() async {
    try {
      await Firestore.instance
          .collection('Canteen')
          .getDocuments()
          .then((datas) {
        for (var i = 0; i < datas.documents.length; i++) {
          setState(() {
            var comTime1;
            var comTime2;
            var comTime3;
            var comDay1;
            var comDay2;
            var comDay3;
            var time3 = datas.documents[i]['timeIn'];
            var day3 = datas.documents[i]['date'];

            comTime1 = new DateFormat.Hm().parse(time1);
            comTime2 = new DateFormat.Hm().parse(time2);
            comTime3 = new DateFormat.Hm().parse(time3);
            comDay1 =  new DateFormat.yMd().parse(bday);
            comDay2 =  new DateFormat.yMd().parse(bday1);
            comDay3 =  new DateFormat.yMd().parse(day3);
            print((comTime3.isAfter(comTime1) && comTime3.isBefore(comTime2)));
            if (employeeNum == '') {
              if (datas.documents[i]['tableNumber'] == tableNum&&  datas.documents[i]['dineMode'] == 'dine in' &&((comDay3.isAfter(comDay1) || comDay3.isAtSameMomentAs(comDay1)) && ( comDay3.isBefore(comDay2) || comDay3.isAtSameMomentAs(comDay2))) && ((comTime3.isAfter(comTime1) || comTime3.isAtSameMomentAs(comTime1)) && ( comTime3.isBefore(comTime2) || comTime3.isAtSameMomentAs(comTime2)))) {
                cardList.add(dataContainer(
                    datas.documents[i]['firstName'],
                    datas.documents[i]['lastName'],
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['dineMode'],
                    datas.documents[i]['tableNumber'],
                    datas.documents[i]['seatNumber'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn'],
                    datas.documents[i]['timeOut']));
                csvData.add(<String>[
                  '${datas.documents[i]['firstName']} ${datas.documents[i]['lastName']}', 
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['dineMode'],
                    datas.documents[i]['tableNumber'],
                    datas.documents[i]['seatNumber'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn'],
                    datas.documents[i]['timeOut']
                    ]);
              } else {
                print('no');
              }
            }
            else{
              if ( datas.documents[i]['dineMode'] == 'dine in' &&((comDay3.isAfter(comDay1) || comDay3.isAtSameMomentAs(comDay1)) && ( comDay3.isBefore(comDay2) || comDay3.isAtSameMomentAs(comDay2))) && ((comTime3.isAfter(comTime1) || comTime3.isAtSameMomentAs(comTime1)) && ( comTime3.isBefore(comTime2) || comTime3.isAtSameMomentAs(comTime2))) && employeeNum == datas.documents[i]['employeeNumber']) {
                cardList.add(dataContainer(
                    datas.documents[i]['firstName'],
                    datas.documents[i]['lastName'],
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['dineMode'],
                    datas.documents[i]['tableNumber'],
                    datas.documents[i]['seatNumber'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn'],
                    datas.documents[i]['timeOut']));
                csvData.add(<String>[
                  '${datas.documents[i]['firstName']} ${datas.documents[i]['lastName']}', 
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['dineMode'],
                    datas.documents[i]['tableNumber'],
                    datas.documents[i]['seatNumber'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn'],
                    datas.documents[i]['timeOut']
                    ]);
              } else {
                print('no');
              }
            }
          });
        }
      });
      search = true;
      if(cardList.length == 0){
        Toast.show('No data found', context, duration: 5, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show('Something went wrong', context,
          duration: 5, gravity: Toast.BOTTOM);
      print(e.message);
    }
  }
    void getCardDineOut() async {
    try {
      await Firestore.instance
          .collection('Canteen')
          .getDocuments()
          .then((datas) {
        for (var i = 0; i < datas.documents.length; i++) {
          setState(() {
            var comTime1;
            var comTime2;
            var comTime3;
            var comDay1;
            var comDay2;
            var comDay3;
            var time3 = datas.documents[i]['timeIn'];
            var day3 = datas.documents[i]['date'];

            comTime1 = new DateFormat.Hm().parse(time1);
            comTime2 = new DateFormat.Hm().parse(time2);
            comTime3 = new DateFormat.Hm().parse(time3);
            comDay1 =  new DateFormat.yMd().parse(bday);
            comDay2 =  new DateFormat.yMd().parse(bday1);
            comDay3 =  new DateFormat.yMd().parse(day3);
            print((comTime3.isAfter(comTime1) && comTime3.isBefore(comTime2)));
            if (employeeNum == '') {
              if (datas.documents[i]['dineMode'] == 'dine out' && ((comDay3.isAfter(comDay1) || comDay3.isAtSameMomentAs(comDay1)) && ( comDay3.isBefore(comDay2) || comDay3.isAtSameMomentAs(comDay2))) && ((comTime3.isAfter(comTime1) || comTime3.isAtSameMomentAs(comTime1)) && ( comTime3.isBefore(comTime2) || comTime3.isAtSameMomentAs(comTime2)))) {
                cardList.add(dataContainer(
                    datas.documents[i]['firstName'],
                    datas.documents[i]['lastName'],
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['dineMode'],
                    datas.documents[i]['tableNumber'],
                    datas.documents[i]['seatNumber'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn'],
                    datas.documents[i]['timeOut']));
                csvData.add(<String>[
                  '${datas.documents[i]['firstName']} ${datas.documents[i]['lastName']}', 
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['dineMode'],
                    datas.documents[i]['tableNumber'],
                    datas.documents[i]['seatNumber'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn'],
                    datas.documents[i]['timeOut']
                    ]);
              } else {
                print('no');
              }
            }
            else{
              if (datas.documents[i]['dineMode'] == 'dine out' && ((comDay3.isAfter(comDay1) || comDay3.isAtSameMomentAs(comDay1)) && ( comDay3.isBefore(comDay2) || comDay3.isAtSameMomentAs(comDay2))) && ((comTime3.isAfter(comTime1) || comTime3.isAtSameMomentAs(comTime1)) && ( comTime3.isBefore(comTime2) || comTime3.isAtSameMomentAs(comTime2))) && employeeNum == datas.documents[i]['employeeNumber']) {
                cardList.add(dataContainer(
                    datas.documents[i]['firstName'],
                    datas.documents[i]['lastName'],
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['dineMode'],
                    datas.documents[i]['tableNumber'],
                    datas.documents[i]['seatNumber'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn'],
                    datas.documents[i]['timeOut']));
                csvData.add(<String>[
                  '${datas.documents[i]['firstName']} ${datas.documents[i]['lastName']}', 
                    datas.documents[i]['employeeNumber'],
                    datas.documents[i]['dineMode'],
                    datas.documents[i]['tableNumber'],
                    datas.documents[i]['seatNumber'],
                    datas.documents[i]['date'],
                    datas.documents[i]['timeIn'],
                    datas.documents[i]['timeOut']
                    ]);
              } else {
                print('no');
              }
            }
          });
        }
      });
      search = true;
      Toast.show('Done Searching', context, duration: 5, gravity: Toast.BOTTOM);
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
            flex: 5,
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
                        value: dineMode,
                        elevation: 3,
                        underline: Container(
                          height: 0,
                        ),
                        style: TextStyle(color: Colors.grey[600]),
                        onChanged: (String newValue) {
                          setState(() {
                            dineMode = newValue;
                          });
                        },
                        items: <String>[
                          'Dine Mode',
                          'Dine In',
                          'Dine Out',
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
                dineMode == 'Dine In' ?Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      validator: (val) => val.isEmpty ?  'Required Field' : !isNumeric(val) ? 'Number only' : null,
                      onChanged: (val) {
                        tableNum = val;
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
                          hintText: 'Table Number'),
                    ),
                  ),
                ) : SizedBox(height: 0,),
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
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            DatePicker.showTimePicker(context,
                                showTitleActions: true, onConfirm: (date) {
                              temptime1 = '';
                              String tempText =
                                  '${date.toString().substring(11, date.toString().length)}';
                              int tempNum = 1;
                              for (int i = 0; i <= tempText.length - 1; i++) {
                                if (tempText[i] == ':' && tempNum == 2) {
                                  setState(() {
                                    time1 = temptime1;
                                  });
                                  break;
                                } else {
                                  temptime1 = '$temptime1${tempText[i]}';
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 8),
                                child: Text(
                                  time1 == '' ? 'From' : 'From: $time1',
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
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            DatePicker.showTimePicker(context,
                                showTitleActions: true, onConfirm: (date) {
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 8),
                                child: Text(
                                  time2 == '' ? 'To' : 'To: $time2',
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
                    maxLength: 6,
                    keyboardType: TextInputType.number,
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
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: FlatButton(
                    color: Colors.blue[200],
                    onPressed: () {
                      if (dineMode == 'Dine Mode' ||
                          bday == '' ||
                          bday1 == '' ||
                          time1 == '' ||
                          time2 == '') {
                        Toast.show("Fill up the fields above", context,
                            duration: 5, gravity: Toast.BOTTOM);
                      } else {
                        if(dineMode == 'Dine In'){
                          if (employeeNum == '') {
                            if (_formKey.currentState.validate()) {
                              cardList.clear();
                              csvData.clear();
                              csvData.add(<String>['Name', 'Employee#', 'Dine Mode','Seat Number', 'Table Number','Date', 'Time In', 'Time Out'],);
                              getCardDineIn();
                            }
                          }
                          else if(employeeNum != ''){
                            cardList.clear();
                            csvData.clear();
                            csvData.add(<String>['Name', 'Employee#', 'Dine Mode','Seat Number', 'Table Number','Date', 'Time In', 'Time Out'],);
                            getCardDineIn();
                          }
                        }
                        else if(dineMode == 'Dine Out'){
                          cardList.clear();
                          csvData.clear();
                          csvData.add(<String>['Name', 'Employee#', 'Dine Mode','Seat Number', 'Table Number','Date', 'Time In', 'Time Out'],);
                          getCardDineOut();
                        }
                      }
                    },
                    child: Container(child: Center(child: Text('Search', style: TextStyle(color: Colors.white)))),
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
                            final String path = '$dir/canteenSearchRecord.csv';
                          
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
                width: 700,
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
                              'Dine Mode',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Seat Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Table Number',
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
                          DataColumn(
                            label: Text(
                              'Time out',
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