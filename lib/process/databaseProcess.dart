
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';


class DatabaseProcess{
  
  final String uid;

  DatabaseProcess({this.uid});

  final CollectionReference userDataCollection = Firestore.instance.collection('userData');
   

  Future getUserName() async {
    DocumentSnapshot employeeSnap = await Firestore.instance.collection('userData').document(uid).get();
      return '${employeeSnap.data['firstName'].toString()} ${employeeSnap.data['lastName'].toString()}';
    
  }
  
  Future getEmployeeNum() async {
    DocumentSnapshot employeeSnap = await Firestore.instance.collection('userData').document(uid).get();
      return '${employeeSnap.data['employeeNumber'].toString()}';
    
  }
  
  void updateUserData(String employeeNo, String firstName, String lastName, String email,String barangay,String municipality ,String department,String plant ,String manager ) async{

    try{
      
      await userDataCollection.document(uid).setData({
        'employeeNumber' : employeeNo,
        'firstName' : firstName,
        'lastName'  : lastName,
        'email' : email,
        'barangay' : barangay,
        'municipality' : municipality,
        'department' : department,
        'plant' : plant,
        'manager' : manager,
        'uid' : uid
      });

    }

    catch(e){
      print(e.message);
    }

  }

  Future updateCanteenDataIn(String place, String mode, String tableNumber, String seatNumber, BuildContext context, String dineMode) async{
    String result;
     try{
  
       for(int i = 1; ;i++){
         DocumentSnapshot documentSnapshot = await Firestore.instance.collection('userData').document(uid).get();
           var now = new DateTime.now();
          DocumentSnapshot docuSnap = await Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}scan$i').get();
          if( docuSnap.exists && docuSnap.data['timeOut'] == 'timeout'){
            //i++;
            print('no time out');
            result = 'error';
            break;
          }
         else{
            if(docuSnap.exists && docuSnap.data['timeOut'] != 'timeout'){
              continue;
            }
            else{
              //print('works2123123');
              
              DocumentSnapshot documentSnapshot = await Firestore.instance.collection('userData').document(uid).get();
            var now = new DateTime.now();
            DocumentReference records = Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}scan$i');
            String dateTime = DateFormat.yMd().format(now);
            String time = DateFormat.Hm().format(now);
            
            await records.setData({
              'documentId' : '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}',
              'date' : dateTime,
              'uid' : uid,
              'timeOut' : 'timeout',
              'dineMode' : dineMode,
              'firstName' : documentSnapshot.data['firstName'],
              'lastName' : documentSnapshot.data['lastName'],
              'employeeNumber' : documentSnapshot.data['employeeNumber'],
              'timeIn' : time,
              'tableNumber' : tableNumber,
              'seatNumber'  : seatNumber
            });
            result = 'success';
            break;
            }
          }
       }
       return result;
    }

    catch(e){
      print(e.message);
      result = 'error';
      return result;
    }
    
  }

  Future updateCanteenDataOut(String place) async{
    String result;
    try{
       
       int maxDocu = 0;
       
       await Firestore.instance.collection(place).getDocuments().then((datas) async{
         DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
          var now = new DateTime.now();
          for (var i = 0; i < datas.documents.length; i++) { 
           
             if(datas.documents[i]['documentId'] == '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}'){
               maxDocu++;
             }
            
          }
        });
     
    

      for(int i = 1; ; i++){
          DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
           var now = new DateTime.now();
          DocumentSnapshot docuSnap = await Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan$i').get();
          if( docuSnap.exists && docuSnap.data['timeOut'] == 'timeout'){
            print('wors');
            var now = new DateTime.now();
            DocumentReference records = Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan$i');
            String time = DateFormat.Hm().format(now);

            await records.updateData({

              'timeOut' : time,
              
            });
            result = 'success';
            break;
          }
         else{
          print('time out exist')  ;
          if( maxDocu == 0 ||i == maxDocu ){
            result = 'error';
            break;
          }
          continue;
          }
       }
      return result;
    }

    catch(e){
      print(e.message);
      result = 'error';
    }
    
  }

  Future updateShuttleDataOut(String place, String travelMode) async{
    String result;
   try{
       
       int maxDocu = 0;
       
       await Firestore.instance.collection('$place').getDocuments().then((datas) async{
         DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
          var now = new DateTime.now();
          for (var i = 0; i < datas.documents.length; i++) { 
           
             if(datas.documents[i]['documentId'] == '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}'){
               maxDocu++;
             }
            
          }
        });

      for(int i = 1; ; i++){
          DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
           var now = new DateTime.now();
          DocumentSnapshot docuSnap = await Firestore.instance.collection('$place').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan$i').get();
          if( docuSnap.exists && docuSnap.data['timeOut'] == 'timeout'){
            print('wors');
            var now = new DateTime.now();
            DocumentReference records = Firestore.instance.collection('$place').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan$i');
            String time = DateFormat.Hm().format(now);

            await records.updateData({

              'timeOut' : time,
              
            });
            result = 'success';
            break;
          }
         else{
          print('time out exist')  ;
          if(maxDocu == 0 || i == maxDocu){
            result = 'error';
            print('$place-$travelMode');
            break;
          }
          continue;
          }
       }
      return result;
    }

    catch(e){
      result = 'error';
      return result;
    }
  }

  Future updateShuttleDataOutGoingIn(String place, String travelMode, String busNumber, String seatNumber,String route) async {
    String result;

    try{
      for(int i = 1; ; i++){
        DocumentSnapshot documentSnapshot = await Firestore.instance.collection('userData').document(uid).get();
        var now = new DateTime.now();
        DocumentSnapshot docuSnap = await Firestore.instance.collection('$place').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}scan$i').get();
        if( docuSnap.exists && docuSnap.data['timeOut'] == 'timeout'){
            
          print('no time out');
          result = 'error';
          break;
        }
        else{
          if(docuSnap.exists && docuSnap.data['timeOut'] != 'timeout'){
            continue;
          }
          else{
            DocumentSnapshot documentSnapshot = await Firestore.instance.collection('userData').document(uid).get();
            var now = new DateTime.now();
            DocumentReference records = Firestore.instance.collection('$place').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}scan$i');
            String date = DateFormat.yMd().format(now);
            String time = DateFormat.Hm().format(now);
            await records.setData({
              'documentId' : '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}',
              'travelMode' : travelMode, 
              'date' : date,
              'timeIn' : time,
              'timeOut' : 'timeout',
              'uid' : uid,
              'firstName' : documentSnapshot.data['firstName'],
              'lastName' : documentSnapshot.data['lastName'],
              'employeeNumber' : documentSnapshot.data['employeeNumber'],
              'shuttleNumber' : busNumber,
              'seatNumber' : seatNumber,
              'route' : route,
            });
            result = 'success';
            break;
          }
        }
      }
      return result;
    }
    catch(e){
      print(e.message);
      result = 'error';
      return result;
    }
  }  

  Future updateConferenceRoomIn(String place, String roomName) async {
    String result = '';
    try{
      
       for(int i = 1; ;i++){
         DocumentSnapshot documentSnapshot = await Firestore.instance.collection('userData').document(uid).get();
           var now = new DateTime.now();
          DocumentSnapshot docuSnap = await Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}scan$i').get();
          if( docuSnap.exists && docuSnap.data['timeOut'] == 'timeout'){
            //i++;
            print('no time out');
            result = 'error';
            break;
          }
         else{
            if(docuSnap.exists && docuSnap.data['timeOut'] != 'timeout'){
              continue;
            }
            else{
              //print('works2123123');
              DocumentSnapshot documentSnapshot = await Firestore.instance.collection('userData').document(uid).get();
            var now = new DateTime.now();
            DocumentReference records = Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}scan$i');
            String date = DateFormat.yMd().format(now);
            String time = DateFormat.Hm().format(now);

            await records.setData({
              'documentId' : '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}',
              'date' : date,
              'timeIn' : time,
              'uid' : uid,
              'firstName' : documentSnapshot.data['firstName'],
              'lastName' : documentSnapshot.data['lastName'],
              'employeeNumber' : documentSnapshot.data['employeeNumber'],
              'timeOut' : 'timeout' ,
              'roomName' : roomName,
            });
            result = 'success';
            break;
            }
          }
       }
       return result;
    }
    catch(e){
      print(e.message);
      result = 'error';
      return result;
    }
  }

  Future updateConferenceRoomOut(String place) async {
    String result = '';
    try{
       int maxDocu = 0;
       
       await Firestore.instance.collection(place).getDocuments().then((datas) async{
         DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
          var now = new DateTime.now();
          for (var i = 0; i < datas.documents.length; i++) { 
           
             if(datas.documents[i]['documentId'] == '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}'){
               maxDocu++;
             }
            
          }
        });
      for(int i = 1; ; i++){
          DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
           var now = new DateTime.now();
          DocumentSnapshot docuSnap = await Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan$i').get();
          if( docuSnap.exists && docuSnap.data['timeOut'] == 'timeout'){
            print('wors');
            var now = new DateTime.now();
            DocumentReference records = Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan$i');
            String time = DateFormat.Hm().format(now);

            await records.updateData({

              'timeOut' : time,
              
            });
            result = 'success';
            break;
          }
         else{
          print('time out exist')  ;
          if( maxDocu == 0 ||i == maxDocu ){
            result = 'error';
            break;
          }
          continue;
          }
       }
      return result;
    }
    catch (e){
      result = 'error';
      return result;
    }
  }

  Future searchRecords(String place) async {
    String result = '';
    int maxDocu = 0;
    try {
      await Firestore.instance.collection('$place').getDocuments().then((datas) async{
        DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
        var now = new DateTime.now();
        for (var i = 0; i < datas.documents.length; i++) {    
          if(datas.documents[i]['documentId'] == '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}'){
            maxDocu++;
          }  
        }
      });
      for(int i = 1; ; i++){
        DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
        var now = new DateTime.now();
        DocumentSnapshot docuSnap = await Firestore.instance.collection('$place').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan$i').get();
        DocumentSnapshot docuSnap1 = await Firestore.instance.collection('$place').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan1').get();
        if(!docuSnap1.exists){
          result = '1';
        }
        if( docuSnap.exists && docuSnap.data['timeOut'] == 'timeout'){
          print('wors');
            result = '$result${docuSnap.data['travelMode']}';
            break;
         }
         else{
          print('time out exist')  ;
          if(maxDocu == 0 || i == maxDocu){
            result = '${result}success';
            break;
          }
          continue;
          }
       }
       return result;
    }catch (e) {
      result = 'error';
      return result;
    }
  }
  Future searchRecordsLobbyUsedInShuttle() async {
    String result = '';
    int maxDocu = 0;
    try {
      await Firestore.instance.collection('Lobby').getDocuments().then((datas) async{
        DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
        var now = new DateTime.now();
        for (var i = 0; i < datas.documents.length; i++) {    
          if(datas.documents[i]['documentId'] == '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}'){
            maxDocu++;
          }  
        }
      });
      for(int i = 1; ; i++){
        DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
        var now = new DateTime.now();
        DocumentSnapshot docuSnap = await Firestore.instance.collection('Lobby').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}').get();
        if( docuSnap.exists && docuSnap.data['triageState'] == 'yes'){
          print('wors');

            break;
         }
         else{
          print('time out exist')  ;
          if(maxDocu == 0 || i == maxDocu){
            result = '1';
            break;
          }
          continue;
          }
       }
       return result;
    }catch (e) {
      result = 'error';
      return result;
    }
  }
  Future searchRecordsCanteen(String place) async {
    String result = '';
    int maxDocu = 0;
    try {
      await Firestore.instance.collection('$place').getDocuments().then((datas) async{
        DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
        var now = new DateTime.now();
        for (var i = 0; i < datas.documents.length; i++) {    
          if(datas.documents[i]['documentId'] == '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}'){
            maxDocu++;
          }  
        }
      });
      for(int i = 1; ; i++){
        DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
        var now = new DateTime.now();
        DocumentSnapshot docuSnap = await Firestore.instance.collection('$place').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan$i').get();
        
        if( docuSnap.exists && docuSnap.data['timeOut'] == 'timeout'){
          print('wors');
            result = 'Out-${docuSnap.data['timeIn']}-${docuSnap.data['dineMode']}-${docuSnap.data['date']}';
            break;
         }
         else{
          print('time out exist')  ;
          if(maxDocu == 0 || i == maxDocu){
            result = 'In';
            break;
          }
          continue;
          }
       }
       return result;
    }catch (e) {
     result = 'error';
      return result;
    }
  }
  
  Future searchForShuttleInRecord() async {
    String result = '';
    try{
      DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
      var now = new DateTime.now();
      DocumentSnapshot docuSnap1 = await Firestore.instance.collection('Shuttle').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan1').get();
      if(docuSnap1.exists){
        result = 'exist';
      }
      else{
        result = 'noexist';
      }
    }
    catch(e){
      
    }
    return result;
  }
  
  Future updateLobbyData(String place,String transpo,String temperature,String lobbyNum) async {
    String result = '';
    try{
      DocumentSnapshot documentSnapshot = await Firestore.instance.collection('userData').document(uid).get();
            var now = new DateTime.now();
            DocumentReference records = Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}');
            String date = DateFormat.yMd().format(now);
            String time = DateFormat.Hm().format(now);
            await records.setData({
              'documentId' : '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}',
              'transpoMode' : transpo, 
              'date' : date,
              'timeIn' : time,
              'uid' : uid,
              'firstName' : documentSnapshot.data['firstName'],
              'lastName' : documentSnapshot.data['lastName'],
              'employeeNumber' : documentSnapshot.data['employeeNumber'],
              'temperature' : '$temperature ˚C' ,
              'lobbyNum' : lobbyNum,
            });
            result = 'success';
    }
    catch(e){
      print(e.message);
      result = 'error';
    }
    return result;
  }

  Future searchRecordsRoom(String place) async {
    String result = '';
    int maxDocu = 0;
    try {
      await Firestore.instance.collection('$place').getDocuments().then((datas) async{
        DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
        var now = new DateTime.now();
        for (var i = 0; i < datas.documents.length; i++) {    
          if(datas.documents[i]['documentId'] == '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}'){
            maxDocu++;
          }  
        }
      });
      for(int i = 1; ; i++){
        DocumentSnapshot employeNumber = await Firestore.instance.collection('userData').document(uid).get();
        var now = new DateTime.now();
        DocumentSnapshot docuSnap = await Firestore.instance.collection('$place').document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${employeNumber.data['employeeNumber']}scan$i').get();


        if( docuSnap.exists && docuSnap.data['timeOut'] == 'timeout'){
          print('wors');
            result = 'Out-${docuSnap.data['timeIn']}-${docuSnap.data['date']}-${docuSnap.data['roomName']}';
            break;
         }
         else{
          print('time out exist')  ;
          if(maxDocu == 0 || i == maxDocu){
            result = 'In';
            break;
          }
          continue;
          }
        
       }
       return result;
    }catch (e) {
     result = 'error';
     print(e.message);
      return result;
    }
  }

  
  

}
