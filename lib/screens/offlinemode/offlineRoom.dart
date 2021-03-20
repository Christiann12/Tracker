import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
String employeeNum = '';
String firstName = '';
String lastName = '';
String roomName = 'Room Name';
String temptime1 = '';
String time1 = '';
String temptime2 = '';
String time2 = '';
TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
TextEditingController controller3 = TextEditingController();

class OfflineRoom extends StatefulWidget {
  void doSomeUpdate() async {
    try{
      DocumentReference records = Firestore.instance.collection('ConferenceRoom').document('dummy');
                            
      records.setData({ 
        'dummy'  : 'Dummy'
      });
      
    }
    catch (e){
      print(e.message);
    }
  }
  @override
  _OfflineRoomState createState() => _OfflineRoomState();
}

class _OfflineRoomState extends State<OfflineRoom> {
  @override
  void dispose() {
     employeeNum = '';
     firstName = '';
     lastName = '';
     roomName = 'Room Name';
     temptime1 = '';
     time1 = '';
     temptime2 = '';
     time2 = '';
     controller1.clear();
     controller2.clear();
     controller3.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Conference room input'),
        backgroundColor: Colors.blue[200],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TextFormField(
            controller: controller1,
            validator: (val) => val.isEmpty ? 'Required Field' : null,
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
          Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Required Field' : null,
                          onChanged: (val) {
                            firstName = val;
                          },
                          controller: controller2,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue[200]),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue[200]),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue[200])),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Required Field' : null,
                          onChanged: (val) {
                            lastName = val;
                          },
                          controller: controller3,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue[200]),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue[200]),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue[200])),
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
                        value: roomName,
                        elevation: 3,
                        underline: Container(
                          height: 0,
                        ),
                        style: TextStyle(color: Colors.grey[600]),
                        onChanged: (String newValue) {
                          setState(() {
                            roomName = newValue;
                          });
                        },
                        items: <String>['Room Name', 'Mabini', 'Luna']
                            .map<DropdownMenuItem<String>>((String value) {
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
                  child: FlatButton(
                    color: Colors.blue[200],
                    onPressed: (){
                      if( employeeNum == '' ||
                          firstName == '' ||
                          lastName == '' ||
                          roomName == 'Room Name' ||
                          time1 == '' ||
                          time2 == '' ){
                        Toast.show('Please fill up required field' , context, duration: 5, gravity: Toast.BOTTOM);    
                      }
                      else{

                          try{
                            var now = new DateTime.now();
                            DocumentReference records = Firestore.instance.collection('ConferenceRoom').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-$time1-$employeeNum-offline');
                            Firestore.instance.settings(persistenceEnabled: true);
                            records.setData({
                              'documentId' : '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-$employeeNum',
                              'date' : DateFormat.yMd().format(now),
                              'timeOut' : time2,
                              'roomName' : roomName,
                              'firstName' : firstName,
                              'lastName' : lastName,
                              'employeeNumber' : employeeNum,
                              'timeIn' : time1,
                            });
                            Navigator.pop(context);
                            Toast.show('Success your record will be recorded', context, duration: 5, gravity: Toast.BOTTOM);
                          }
                          catch (e){
                            Toast.show(e.message, context, duration: 5, gravity: Toast.BOTTOM);
                          }
                      }
                    },
                    child: Center(child: Text('Submit', style: TextStyle(color: Colors.white))),
                  ),
                )
        ],
      ),
    );
  }
}