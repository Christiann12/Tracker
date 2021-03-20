import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:contacttracer/process/databaseProcess.dart';
import 'package:contacttracer/screens/homescreens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

Homescreen homescreen = Homescreen();

bool loading = false;
int _page = 0;
List<dynamic> _pages;
String roomName = 'Room Name';

class ConferenceRoomScan extends StatefulWidget {
  final String roomName;
  final String place;
  final String mode;
  final String timeIn;
  final String date;
  final String roomNameData;
  ConferenceRoomScan(
      {Key key,
      @required this.roomName,
      @required this.place,@required this.mode,@required this.timeIn,@required this.date,@required this.roomNameData,})
      : super(key: key);
  @override
  _ConferenceRoomScanState createState() => _ConferenceRoomScanState();
}

class _ConferenceRoomScanState extends State<ConferenceRoomScan> {
  @override
  Widget build(BuildContext context) {
    _pages = [widget.mode == 'In' ? body1() : body2()];
    return loading == true? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('Conference Room'),
      ),
      body: _pages[_page],
    );
  }
  Container body1(){
    var now = new DateTime.now();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Center(
              child: Text('Time in Data',style: TextStyle(fontSize: 35),),
            )
          ),
          widget.roomName == 'Yes' ? Padding(
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
                        items: <String>[
                          'Room Name',
                          'Mabini',
                          'Luna',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ) :Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Text('Conference Room Name: ${widget.roomName}',style: TextStyle(fontSize: 15),)
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Text('Date: ${DateFormat.yMd().format(now)}',style: TextStyle(fontSize: 15),)
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Text('Time: ${DateFormat.Hm().format(now)}',style: TextStyle(fontSize: 15),)
          ),
          Center(
            child: FlatButton(
              color: Colors.blue[200],
              onPressed: () async {
                if (widget.roomName == 'Yes' && roomName!= 'Room Name') {
                  setState(() {
                    loading = true;
                  });
                  String result =  await DatabaseProcess(
                          uid: '${Provider.of<UserModel>(context).uid.toString()}')
                      .updateConferenceRoomIn(widget.place,roomName);
                  if (result == 'error') {
                    Toast.show("Something went wrong", context,
                        duration: 5, gravity: Toast.BOTTOM);
                  } else if (result == 'success') {
                    Toast.show("Data recorded", context,
                        duration: 5, gravity: Toast.BOTTOM);
                  }
                  homescreen.reset();
                  Navigator.pop(context);
                  loading = false;
                  
                  _page = 0;
                }
                else if(widget.roomName != 'Yes'){
                  setState(() {
                    loading = true;
                  });
                  String result =  await DatabaseProcess(
                          uid: '${Provider.of<UserModel>(context).uid.toString()}')
                      .updateConferenceRoomIn(widget.place,widget.roomName);
                  if (result == 'error') {
                    Toast.show("Something went wrong", context,
                        duration: 5, gravity: Toast.BOTTOM);
                  } else if (result == 'success') {
                    Toast.show("Data recorded", context,
                        duration: 5, gravity: Toast.BOTTOM);
                  }
                  homescreen.reset();
                  Navigator.pop(context);
                  loading = false;
                  
                  _page = 0;
                }
                else{
                  Toast.show("Enter Room Name", context,
                        duration: 5, gravity: Toast.BOTTOM);
                }
              },
              child: Text('Submit'),
            ),
          )        
        ],
      ),
    );
  }
  Container body2(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Center(
              child: Text('Time Out Data',style: TextStyle(fontSize: 35),),
            )
          ),
          widget.roomName == 'Yes' ? Padding(
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
                        items: <String>[
                          'Room Name',
                          'Mabini',
                          'Luna',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ) :Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Text('Current Conference Room: ${widget.roomName}',style: TextStyle(fontSize: 15),)
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Text('For Conference Room: ${widget.roomNameData}',style: TextStyle(fontSize: 15),)
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Text('On Date: ${widget.date}',style: TextStyle(fontSize: 15),)
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Text('With a Time in of: ${widget.timeIn}',style: TextStyle(fontSize: 15),)
          ),
          Center(
            child: FlatButton(
              color: Colors.blue[200],
              onPressed: () async {
                if (widget.roomName == 'Yes' && roomName != 'Room Name') {
                  if (roomName == widget.roomNameData) {
                    setState(() {
                      loading = true;
                    });
                    String result =  await DatabaseProcess(
                            uid: '${Provider.of<UserModel>(context).uid.toString()}')
                        .updateConferenceRoomOut(widget.place);
                    if (result == 'error') {
                      Toast.show("Something went wrong", context,
                          duration: 5, gravity: Toast.BOTTOM);
                    } else if (result == 'success') {
                      Toast.show("Data recorded", context,
                          duration: 5, gravity: Toast.BOTTOM);
                    }
                    
                    Navigator.pop(context);
                    setState(() {
                      loading = false;
                    homescreen.reset();
                      _page = 0;
                    });
                  }
                  else{
                    Toast.show("Wrong Conference room", context,
                          duration: 5, gravity: Toast.BOTTOM);
                  }
                }
                else if(widget.roomName != 'Yes'){
                  if (widget.roomName == widget.roomNameData) {
                    setState(() {
                      loading = true;
                    });
                    String result =  await DatabaseProcess(
                            uid: '${Provider.of<UserModel>(context).uid.toString()}')
                        .updateConferenceRoomOut(widget.place);
                    if (result == 'error') {
                      Toast.show("Something went wrong", context,
                          duration: 5, gravity: Toast.BOTTOM);
                    } else if (result == 'success') {
                      Toast.show("Data recorded", context,
                          duration: 5, gravity: Toast.BOTTOM);
                    }
                    
                    
                    
                    Navigator.pop(context);
                    setState(() {
                      loading = false;
                    homescreen.reset();
                      _page = 0;
                    });
                  }
                  else{
                    Toast.show("Wrong Conference room", context,
                          duration: 5, gravity: Toast.BOTTOM);
                  }
                }
                else{
                    Toast.show("Enter Room Name", context,
                          duration: 5, gravity: Toast.BOTTOM);
                }
              },
              child: Text('Submit'),
            ),
          )        
        ],
      ),
    );
  }
}