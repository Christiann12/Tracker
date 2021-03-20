import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:contacttracer/process/databaseProcess.dart';
import 'package:contacttracer/screens/ScanScreen/canteenScan.dart';
import 'package:contacttracer/screens/ScanScreen/shuttleScan.dart';
import 'package:contacttracer/screens/homescreens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

bool loading = false;
Homescreen homescreen = Homescreen();
class ManualInput extends StatefulWidget {

  @override
  _ManualInputState createState() => _ManualInputState();
}

class _ManualInputState extends State<ManualInput> {
  
  @override
  Widget build(BuildContext context) {
    
    return loading == true
        ? Loading()
        : Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[200],
            title: Text('Manual Input'),
          ),
          body: Container(
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: FlatButton(
                      color: Colors.blue[200],
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        String result = await DatabaseProcess(
                                uid:
                                    '${Provider.of<UserModel>(context).uid.toString()}')
                            .searchRecords('Shuttle');
                        String tempText = '';
                        String scanNum = '';
                        for (int i = 0; i <= result.length - 1; i++) {
                          if (isAlpha(result[i])) {
                            tempText = '$tempText${result[i]}';
                          } else {
                            scanNum = '$scanNum${result[i]}';
                          }
                        }

                        if (scanNum == '1') {
                          scanNum = await DatabaseProcess(
                                  uid:
                                      '${Provider.of<UserModel>(context).uid.toString()}')
                              .searchRecordsLobbyUsedInShuttle();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ShuttleScan(
                                        mode: tempText == 'success'
                                            ? 'in'
                                            : tempText,
                                        route: route,
                                        place: 'Shuttle',
                                        scanNum: scanNum,
                                        manual: 'yes',
                                      )));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ShuttleScan(
                                        mode: tempText == 'success'
                                            ? 'in'
                                            : tempText,
                                        route: route,
                                        place: 'Shuttle',
                                        scanNum: scanNum,
                                        manual: 'yes',
                                      )));
                        }

                        loading = false;
                      },
                      child: Container(
                          child: Center(
                              child: Text('Shuttle',
                                  style: TextStyle(color: Colors.white)))),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: FlatButton(
                      disabledColor: Colors.grey[300],
                      color: Colors.blue[200],
                      onPressed: null,
                      // onPressed: () async {
                       
                      //   setState(() {
                      //     loading = true;
                      //   });
                      //   String result = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').searchForShuttleInRecord();
                      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LobbyScan(place: 'Lobby', lobbyNum: 'Yes',state: result,)));
                      //   loading = false;
                      // },
                      child: Container(
                          child: Center(
                              child: Text('Lobby',
                                  style: TextStyle(color: Colors.white)))),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: FlatButton(
                      disabledColor: Colors.grey[300],
                      color: Colors.blue[200],
                      onPressed: null,
                      // onPressed: () async {
                       
                      //   setState(() {
                      //     loading = true;
                      //   });
                      //   String mode = '';
                      //   String timeIn = '';
                      //   String date = '';
                      //   String roomNameData = '';
                      //   int count = 0;
                      //   String result = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').searchRecordsRoom('ConferenceRoom');
                      //   for(int i = 0; i <= result.length-1;i++){
                      //     if(result[i] == '-'){
                      //       count++;
                      //       continue;
                      //     }
                      //     if(count == 1){
                      //       timeIn = '$timeIn${result[i]}';
                      //     }
                      //     else if(count == 2){
                      //       date = '$date${result[i]}';
                      //     }
                      //     else if(count == 3){
                      //       roomNameData = '$roomNameData${result[i]}';
                      //     }
                      //     else{
                      //       mode = '$mode${result[i]}';
                      //     }
                      //   }
                      //   print(result);
                      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ConferenceRoomScan(roomName: 'Yes',place: 'ConferenceRoom',date: date,mode: mode,timeIn: timeIn,roomNameData: roomNameData,)));
                      //   loading = false;
                      // },
                      child: Container(
                          child: Center(
                              child: Text('Conference Room',
                                  style: TextStyle(color: Colors.white)))),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: FlatButton(
                      disabledColor: Colors.grey[300],
                      color: Colors.blue[200],
                      //onPressed: null,
                      onPressed: () async {
                       String mode = '';
                      String timeIn = '';
                      String dineMode = '';
                      String date = '';
                      int count =  0;
                      setState(() {
                        loading = true;
                      });
                      String result = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').searchRecordsCanteen('Canteen');
                      for(int i = 0; i <= result.length-1;i++){
                        if(result[i] == '-'){
                          count++;
                          continue;
                        }
                        if(count == 1){
                          timeIn = '$timeIn${result[i]}';
                        }
                        else if(count == 2){
                          dineMode = '$dineMode${result[i]}';
                        }
                        else if(count == 3){
                          date = '$date${result[i]}';
                        }
                        else{
                          mode = '$mode${result[i]}';
                        }
                      }
                      
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CanteenScan(place: 'Canteen',mode: mode,timeIn: timeIn,dineMode: dineMode,date: date,)));
                      setState(() {
                        loading = false;
                        homescreen.reset();
                      });
                      },
                      child: Container(
                          child: Center(
                              child: Text('Canteen',
                                  style: TextStyle(color: Colors.white)))),
                    ),
                  )
                ],
              ),
            ),
        );
  }
}
