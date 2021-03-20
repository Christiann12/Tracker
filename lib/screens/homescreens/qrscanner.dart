import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:contacttracer/process/databaseProcess.dart';
import 'package:contacttracer/screens/ScanScreen/canteenScan.dart';
import 'package:contacttracer/screens/ScanScreen/conferenceroomscan.dart';
import 'package:contacttracer/screens/ScanScreen/lobbyscan.dart';
import 'package:contacttracer/screens/ScanScreen/shuttleScan.dart';
import 'package:contacttracer/screens/homescreens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:string_validator/string_validator.dart';
import 'package:toast/toast.dart';



Homescreen homescreen = Homescreen();

class QrScanner extends StatefulWidget {
  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool loading = false;
  
  @override
  Widget build(BuildContext context) {
    return loading == true ? Loading() : Container(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue[200],
            title: Text('QR scanner'),
          ),
        body: Container(
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
        ),
      ),
    );
  }
  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      String place = '';
      for(int i = 0 ; i <= scanData.length ;i++){
        if(i == scanData.length || scanData[i] == '-'){
          print(place);
          break;
        }
        else{
          place = '$place${scanData[i]}';
        }      
      }
      if(place == 'Shuttle'){
        String route = '';
        for(int i = 0; i <= scanData.length-1 ; i++){
          if(scanData[i] == '-'){
            route = '${scanData.substring(i+1,scanData.length)}';
            break;
          }
        }
        setState(() {
          loading = true;
        });
        String result = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').searchRecords(place);
        String tempText = '';
        String scanNum = '';
        for(int i = 0; i <= result.length-1;i++){
          if(isAlpha(result[i])){
            tempText = '$tempText${result[i]}';
          }
          else{ 
            scanNum = '$scanNum${result[i]}';
          }
        }
        
        if(scanNum == '1'){
          scanNum = await DatabaseProcess(uid : '${Provider.of<UserModel>(context).uid.toString()}').searchRecordsLobbyUsedInShuttle();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ShuttleScan(mode: tempText == 'success' ? 'in' : tempText , route: route ,place: place,scanNum: scanNum,manual: 'no',)));
          setState(() {
          loading = false;
        });
        }
        else{
          
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ShuttleScan(mode: tempText == 'success' ? 'in' : tempText , route: route ,place: place,scanNum: scanNum,manual: 'no',)));
          setState(() {
          loading = false;
        });
        }
        
          
        
      }
      else if(place == 'Lobby'){
        String lobbyNum = '';
        for(int i = 0; i <= scanData.length-1 ; i++){
          if(scanData[i] == '-'){
            lobbyNum = '${scanData.substring(i+1,scanData.length)}';
            break;
          }
        }
        setState(() {
          loading = true;
        });
        String result = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').searchForShuttleInRecord();
        loading = false;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LobbyScan(place: place, lobbyNum: lobbyNum,state: result,)));
        
      }
      else if(place == 'Canteen'){
        String mode = '';
        String timeIn = '';
        String dineMode = '';
        String date = '';
        int count =  0;
        setState(() {
          loading = true;
        });
        String result = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').searchRecordsCanteen(place);
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
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CanteenScan(place: place,mode: mode,timeIn: timeIn,dineMode: dineMode,date: date,)));
        setState(() {
          loading = false;
        });
      }
      else if(place == 'ConferenceRoom'){
        String roomName = '';
        for(int i = 0; i <= scanData.length-1;i++){
          if(scanData[i] == '-'){
            roomName = '$roomName${scanData.substring(i+1,scanData.length)}';
            break;
          }
        }
        setState(() {
          loading = true;
        });
        String mode = '';
        String timeIn = '';
        String date = '';
        String roomNameData = '';
        int count = 0;
        String result = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').searchRecordsRoom(place);
        for(int i = 0; i <= result.length-1;i++){
          if(result[i] == '-'){
            count++;
            continue;
          }
          if(count == 1){
            timeIn = '$timeIn${result[i]}';
          }
          else if(count == 2){
            date = '$date${result[i]}';
          }
          else if(count == 3){
            roomNameData = '$roomNameData${result[i]}';
          }
          else{
            mode = '$mode${result[i]}';
          }
        }
        print(result);
        
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ConferenceRoomScan(roomName: roomName,place: place,date: date,mode: mode,timeIn: timeIn,roomNameData: roomNameData,)));
        setState(() {
          loading = false;
        });
      }
      else{
        Toast.show("Can't recognize QRcode", context,
                                duration: 3, gravity: Toast.BOTTOM);
        Navigator.pop(context);
      }
    });
  }
}