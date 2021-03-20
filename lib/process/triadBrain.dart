import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacttracer/models/part2Model.dart';
import 'package:contacttracer/models/part3Model.dart';
import 'package:contacttracer/models/triadModel.dart';
import 'package:contacttracer/screens/homescreens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Homescreen homescreen = Homescreen();

class TriadBrain{


  String _place = '';
  String _mode = '';

  String _travelMode = '';
  String _shutteNumber = '';
  String _seatNumber = '';
  String _temperature = '';
  String _route = '';
  int _questionNumber = 0;
  String lobbyNum = '';
  String transpo = '';

  String _answer1 = '';
  String _answer2 = '';
  String _answer3= '';
  String _answer4= '';
  String _answer5= '';
  String _answer6= '';
  String _ans6Place = '';
  String _answer7= '';
  String _answer8= '';

   Color button1 = Colors.grey[300];
   Color button2 = Colors.grey[300];
   Color button3 = Colors.grey[300];
   Color button4 = Colors.grey[300];
   Color button5 = Colors.grey[300];
   Color button6 = Colors.grey[300];
   Color button7 = Colors.grey[300];
   Color button8 = Colors.grey[300];
   Color button9 = Colors.grey[300];
   Color button10 = Colors.grey[300];
   Color button11 = Colors.grey[300];
   Color button12 = Colors.grey[300];
   Color button13 = Colors.grey[300];
   Color button14 = Colors.grey[300];
   Color button15 = Colors.grey[300];
   Color button16 = Colors.grey[300];

  bool _check1 = false;
  bool _check2 = false;
  bool _check3 = false;
  bool _check4 = false;
  bool _check5 = false;
  bool _check6 = false;
  bool _check7 = false;
  bool _check8 = false;
  bool _check9 = false;
  bool _check10 = false;
  bool _check11 = false;
  // ignore: unused_field
  String _otherSymptom = '';

  bool _part2Check1 = false;
  bool _part2Check2 = false;
  bool _part2Check3 = false;
  bool _part2Check4 = false;
  bool _part2Check5 = false;

  String _specificAllergy = '';

  List<TriadModel> _triadQuestions = [
    TriadModel('1. Do you have any close contact with a person who is confirmed case of COVID-19 in the last 1-14 days?'),
    TriadModel('2. Do you reside in a community/barangay/village where there is one or more positive case of COVID-19?'),
    TriadModel('3. Do you have any family,relative,friend who is Confirmed, Suspect or Probable case?'),
    TriadModel('4. Is this family, relative, or friend living with you?'),
    TriadModel('5. Are you living with a family member who is a Front Liner? (Example: doctor, nurse, medical personel, etc.)'),
    TriadModel('6. Do you have local or abroad travel history in the last 1 - 14 days? If yes, where?'),
    TriadModel('7. Have you quarantine yourself for 14 days upon arrival?'),
    TriadModel('8. Have you secured any clearance that you are physically fit after the 14 day quarantine?')
  ];

  List<Part2Model> _part2Questions = [
    Part2Model('1. Rhinorrhea or nasal congestion'),
    Part2Model('2. Sore Throat'),
    Part2Model('3. Shortness of breath'),
    Part2Model('4. Headaches'),
    Part2Model('5. Body Aches'),
    Part2Model('6. Vomiting'),
    Part2Model('7. Fever (Temp > 37.8)'),
    Part2Model('8. Cough'),
    Part2Model('9. Fatigue'),
    Part2Model('10. Diarrhea'),
    Part2Model('11. Chills')
  ];

  List<Part3Model> _part3Questions = [
    Part3Model('Hypertension'),
    Part3Model('Diabetes'),
    Part3Model('Asthma'),
    Part3Model('Pregnant'),
    Part3Model('Allergy'),
  ];

  int maxCount = 6;

  // ignore: missing_return
  bool getPart2Bool(int index){
    if(index == 0){
      return _part2Check1;
    }
    else if(index == 1){
      return _part2Check2;
    }
    else if(index == 2){
      return _part2Check3;
    }
    else if(index == 3){
      return _part2Check4;
    }
    else if(index == 4){
      return _part2Check5;
    }
  }

  void setPart2Bool(int index, bool newAns){
   
    switch(index){
      case 0:
          _part2Check1 = newAns;
          // print(_part2Check1);
        break;
      case 1:
        //prints();
        _part2Check2 = newAns;
        break;
      case 2:
        _part2Check3 = newAns;
        break;
      case 3:
        _part2Check4 = newAns;
        break;
      case 4:
        _part2Check5 = newAns;
        break;
    }
  }

  String getPart3Questions(int questionNumber){
    return _part3Questions[questionNumber].questions;
  }

  int getPart3Length(){
    return _part3Questions.length;
  }

  String getPart2Questions(int questioNumber){
    return _part2Questions[questioNumber].questions;
  }

  int getPart2Length(){
    return _part2Questions.length;
  }

  void setBool(int index, bool newAns){
    if(index == 0){
      _check1 = newAns;
    }
    else if(index == 1){
       _check2= newAns;
    }
    else if(index == 2){
       _check3= newAns;
    }
    else if(index == 3){
       _check4= newAns;
    }
    else if(index == 4){
       _check5= newAns;
    }
    else if(index == 5){
       _check6= newAns;
    }
    else if(index == 6){
       _check7= newAns;
    }
    else if(index == 7){
       _check8= newAns;
    }
    else if(index == 8){
       _check9= newAns;
    }
    else if(index == 9){
       _check10= newAns;
    }
    else if(index == 10){
       _check11= newAns;
    }
  }

  // ignore: missing_return
  bool getBool(int index){
    if(index == 0){
      return _check1;
    }
    else if(index == 1){
      return _check2;
    }
    else if(index == 2){
      return _check3;
    }
    else if(index == 3){
      return _check4;
    }
    else if(index == 4){
      return _check5;
    }
    else if(index == 5){
      return _check6;
    }
    else if(index == 6){
      return _check7;
    }
    else if(index == 7){
      return _check8;
    }
    else if(index == 8){
      return _check9;
    }
    else if(index == 9){
      return _check10;
    }
    else if(index == 10){
      return _check11;
    }
  }

  void setAnswer(int ansNum, String ans){
    switch(ansNum){
      case 1:
        //prints();
        _answer1 = ans;
        break;
      case 2:
        _answer2 = ans;
        break;
      case 3:
        _answer3 = ans;
        break;
      case 4:
        _answer4 = ans;
        break;
      case 5:
        _answer5 = ans;
        break;
      case 6:
        _answer6 = ans;
        if(ans == 'No'){
          _answer7 = '';
          _answer8 = '';
          button13 = Colors.grey[300];
          button14 = Colors.grey[300];
          button15 = Colors.grey[300];
          button16 = Colors.grey[300];
        }
        break;
      case 7:
        _answer7 = ans;
        break;
      case 8:
        _answer8 = ans;
        break;
    }
  }

  String getTriadQuestion(int questionNumber){
    return _triadQuestions[questionNumber].questions;
  }

  int getQuestionNumber(){
    return _questionNumber;
  }

  int getListLength(){
    return maxCount;
  }

  void prints(){
    // print('1.$_answer1');
    // print('2.$_answer2');
    // print('3.$_answer3');
    // print('4.$_answer4');
    // print('5.$_answer5');
    // print('6.$_answer6');
    // print('7.$_answer7');
    // print('8.$_answer8');
    print('1.$_ans6Place');
    // print('2.$_part2Check2');
    // print('3.$_part2Check3');
    // print('4.$_part2Check4');
    // print('5.$_part2Check5');
  }

  // ignore: missing_return
  Color getColor1(int index){
    if(index == 1){
      return button1;
    }
    else if(index == 2){
      return button3;
    }
    else if(index == 3){
      return button5;
    }
    else if(index == 4){
      return button7;
    }
    else if(index == 5){
      return button9;
    }
    else if(index == 6){
      return button11;
    }
    else if(index == 7){
      return button13;
    }
    else if(index == 8){
      return button15;
    }
  }

  // ignore: missing_return
  Color getColor2(int index){
    if(index == 1){
      return button2;
    }
    else if(index == 2){
      return button4;
    }
    else if(index == 3){
      return button6;
    }
    else if(index == 4){
      return button8;
    }
    else if(index == 5){
      return button10;
    }
    else if(index == 6){
      return button12;
    }
    else if(index == 7){
      return button14;
    }
    else if(index == 8){
      return button16;
    }
  }

  void setColor(int index, String ans){
    if(index == 1 && ans == 'Yes'){
      button1 = Colors.blue[200];
      button2 = Colors.grey[300];
    }
    else if(index == 1 && ans == 'No'){
      button1 = Colors.grey[300];
      button2 = Colors.blue[200];
    }
    else if(index == 2 && ans == 'Yes'){
      button3 = Colors.blue[200];
      button4 = Colors.grey[300];
    }
    else if(index == 2 && ans == 'No'){
      button3 = Colors.grey[300];
      button4 = Colors.blue[200];
    }
    else if(index == 3 && ans == 'Yes'){
      button5 = Colors.blue[200];
      button6 = Colors.grey[300];
    }
    else if(index == 3 && ans == 'No'){
      button5 = Colors.grey[300];
      button6 = Colors.blue[200];
    }
    else if(index == 4 && ans == 'Yes'){
      button7 = Colors.blue[200];
      button8 = Colors.grey[300];
    }
    else if(index == 4 && ans == 'No'){
      button7 = Colors.grey[300];
      button8 = Colors.blue[200];
    }
    else if(index == 5 && ans == 'Yes'){
      button9 = Colors.blue[200];
      button10 = Colors.grey[300];
    }
    else if(index == 5 && ans == 'No'){
      button9 = Colors.grey[300];
      button10 = Colors.blue[200];
    }
    else if(index == 6 && ans == 'Yes'){
      button11 = Colors.blue[200];
      button12 = Colors.grey[300];
      maxCount = 8;
    }
    else if(index == 6 && ans == 'No'){
      button11 = Colors.grey[300];
      button12 = Colors.blue[200];
      maxCount = 6;
    }
    else if(index == 7 && ans == 'Yes'){
      button13 = Colors.blue[200];
      button14 = Colors.grey[300];
    }
    else if(index == 7 && ans == 'No'){
      button13 = Colors.grey[300];
      button14 = Colors.blue[200];
    }
    else if(index == 8 && ans == 'Yes'){
      button15 = Colors.blue[200];
      button16 = Colors.grey[300];
    }
    else if(index == 8 && ans == 'No'){
      button15 = Colors.grey[300];
      button16 = Colors.blue[200];
    }
  }

  String getAns6(){
    return _answer6;
  }

  void setAns6PlaceString(String newPlace){
    _ans6Place = newPlace;
  }

  void setOtherSymptoms(String newSymptoms){
    _otherSymptom = newSymptoms;
  }

  bool getPart2Check5(){
    //print(_part2Check5String);
    return _part2Check5;
  }

  String getSpecificAllergyString(){
    return _specificAllergy;
  }
  
  void setSpecificAllergyString(String val){
    _specificAllergy = val;
  }

  void setStringPlace(String newPlace, String newMode){
    _place = newPlace;
    _mode = newMode;
  }

  void setDetails(String _shutteNumber,String _seatNumber,String _temperature,String _route,String _travelMode,String _place){
     this._shutteNumber = _shutteNumber;
     this._seatNumber = _seatNumber;
     this._temperature = _temperature;
     this._route = _route;
     this._travelMode = _travelMode;
     this._place = _place;
  }

  void setDetailsforLobby(String place, String temperature, String lobbyNum, String transpo){
    this._place = place;
    this._temperature = temperature;
    this.lobbyNum = lobbyNum;
    this.transpo = transpo;
  }

  Future submit(String uid,String _answer1,String _answer2,String _answer3,String _answer4,String _answer5,String _answer6,String _answer7,String _answer8,String _ans6Place,
  String _mode,String _shutteNumber,String _seatNumber,String _temperature,
  bool _check1,bool _check2,bool _check3,bool _check4,bool _check5,bool _check6,bool _check7,bool _check8,bool _check9,bool _check10,bool _check11,String _otherSymptom,
  bool _part2Check1,bool _part2Check2,bool _part2Check3,bool _part2Check4,bool _part2Check5,String _specificAllergy, String _route, String place,String _travelMode) async{
    String result;
    
    try{
      for(int i = 1; ;i++){
         DocumentSnapshot documentSnapshot = await Firestore.instance.collection('userData').document(uid).get();
           var now = new DateTime.now();
          DocumentSnapshot docuSnap = await Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}scan$i').get();
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
            print('works2123123');
            DocumentSnapshot documentSnapshot = await Firestore.instance.collection('userData').document(uid).get();
            var now = new DateTime.now();
            DocumentReference records = Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}scan$i');
            String date = DateFormat.yMd().format(now);
            String time = DateFormat.Hm().format(now);

            await records.setData({
              'documentId' : '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}',
              'triageState' : 'yes',
              'travelMode' : _travelMode, 
              'date' : date,
              'timeIn' : time,
              'timeOut' : 'timeout',
              'uid' : uid,
              'firstName' : documentSnapshot.data['firstName'],
              'lastName' : documentSnapshot.data['lastName'],
              'employeeNumber' : documentSnapshot.data['employeeNumber'],
              'temperature' : '$_temperature ˚C',
              'municipality' : documentSnapshot.data['municipality'],
              'barangay' : documentSnapshot.data['barangay'],
              'department' : documentSnapshot.data['department'],
              'plant' : documentSnapshot.data['plant'],
              'manager' : documentSnapshot.data['manager'],
              'shuttleNumber' : _shutteNumber,
              'seatNumber' : _seatNumber,
              'route' : _route,
              'exposureAndTravelHistory': {
                'question1' : _answer1,
                'question2' : _answer2,
                'question3' : _answer3,
                'question4' : _answer4,
                'question5' : _answer5,
                'question6' : _answer6,
                'travelledPlace' : _ans6Place,
                'question7' : _answer7,
                'question8' : _answer8,
              },
              'signsAndSymptoms' : {
                'nasalCongestion' : _check1,
                'soreThroat' : _check2,
                'shortnessOfBreath' : _check3,
                'headAches' : _check4,
                'bodyAches' : _check5,
                'vommiting' : _check6,
                'fever' : _check7,
                'cough' : _check8,
                'fatigue' : _check9,
                'diarrhea' : _check10,
                'chills' : _check11,
                'others' : _otherSymptom
              },
              'healthStatus' : {
                'hypertension' : _part2Check1,
                'diabetes' : _part2Check2,
                'asthma' : _part2Check3,
                'pregnant' : _part2Check4,
                'allergy' : _part2Check5,
                'specificAllergy' : _specificAllergy
              }
            });
            result = 'success';
            break;
            }
          }
      }
      homescreen.reset();
      return result;
    }

    catch(e){
      result = 'error';
      print(e.message);
      homescreen.reset();
      return result;
    }
    
  }

  Future submitLobby(String uid,String _answer1,String _answer2,String _answer3,String _answer4,String _answer5,String _answer6,String _answer7,String _answer8,String _ans6Place,
  String temperature, String lobbyNum, String traspo,String place,
  bool _check1,bool _check2,bool _check3,bool _check4,bool _check5,bool _check6,bool _check7,bool _check8,bool _check9,bool _check10,bool _check11,String _otherSymptom,
  bool _part2Check1,bool _part2Check2,bool _part2Check3,bool _part2Check4,bool _part2Check5,String _specificAllergy) async {
    String result;
    try{
      DocumentSnapshot documentSnapshot = await Firestore.instance.collection('userData').document(uid).get();
            var now = new DateTime.now();
            DocumentReference records = Firestore.instance.collection(place).document('${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}');
            String date = DateFormat.yMd().format(now);
            String time = DateFormat.Hm().format(now);
            await records.setData({
              'documentId' : '${DateFormat.d().format(now)}-${DateFormat.M().format(now)}-${DateFormat.y().format(now)}-${documentSnapshot['employeeNumber']}',
              'transpoMode' : transpo,
              'triageState'  : 'yes',
              'date' : date,
              'timeIn' : time,
              'uid' : uid,
              'firstName' : documentSnapshot.data['firstName'],
              'lastName' : documentSnapshot.data['lastName'],
              'employeeNumber' : documentSnapshot.data['employeeNumber'],
              'temperature' : '$temperature ˚C' ,
              'municipality' : documentSnapshot.data['municipality'],
              'barangay' : documentSnapshot.data['barangay'],
              'department' : documentSnapshot.data['department'],
              'plant' : documentSnapshot.data['plant'],
              'manager' : documentSnapshot.data['manager'],
              'lobbyNum' : lobbyNum,
              'exposureAndTravelHistory': {
                'question1' : _answer1,
                'question2' : _answer2,
                'question3' : _answer3,
                'question4' : _answer4,
                'question5' : _answer5,
                'question6' : _answer6,
                'travelledPlace' : _ans6Place,
                'question7' : _answer7,
                'question8' : _answer8,
              },
              'signsAndSymptoms' : {
                'nasalCongestion' : _check1,
                'soreThroat' : _check2,
                'shortnessOfBreath' : _check3,
                'headAches' : _check4,
                'bodyAches' : _check5,
                'vommiting' : _check6,
                'fever' : _check7,
                'cough' : _check8,
                'fatigue' : _check9,
                'diarrhea' : _check10,
                'chills' : _check11,
                'others' : _otherSymptom
              },
              'healthStatus' : {
                'hypertension' : _part2Check1,
                'diabetes' : _part2Check2,
                'asthma' : _part2Check3,
                'pregnant' : _part2Check4,
                'allergy' : _part2Check5,
                'specificAllergy' : _specificAllergy
              }
            });
            result = 'success';
            
    }
    catch(e){
      result = 'error';
      print(e.message);
    }
    homescreen.reset();
    return result;
  }

  void reset(){
   maxCount = 6;
   _place = '';
   _mode = '';

   _shutteNumber = '';
   _seatNumber = '';
   _temperature = '';
   _route = '';

   _questionNumber = 0;

   _answer1 = '';
   _answer2 = '';
   _answer3= '';
   _answer4= '';
   _answer5= '';
   _answer6= '';
   _ans6Place = '';
   _answer7= '';
   _answer8= '';

   button1 = Colors.grey[300];
   button2 = Colors.grey[300];
   button3 = Colors.grey[300];
   button4 = Colors.grey[300];
   button5 = Colors.grey[300];
   button6 = Colors.grey[300];
   button7 = Colors.grey[300];
   button8 = Colors.grey[300];
   button9 = Colors.grey[300];
   button10 = Colors.grey[300];
   button11 = Colors.grey[300];
   button12 = Colors.grey[300];
   button13 = Colors.grey[300];
   button14 = Colors.grey[300];
   button15 = Colors.grey[300];
   button16 = Colors.grey[300];

   _check1 = false;
   _check2 = false;
   _check3 = false;
   _check4 = false;
   _check5 = false;
   _check6 = false;
   _check7 = false;
   _check8 = false;
   _check9 = false;
   _check10 = false;
   _check11 = false;
  // ignore: unused_field
   _otherSymptom = '';

   _part2Check1 = false;
   _part2Check2 = false;
   _part2Check3 = false;
   _part2Check4 = false;
   _part2Check5 = false;

   _specificAllergy = '';
  }

  String getAns1(){
    return _answer1;
  }
  String getAns2(){
    return _answer2;
  }
  String getAns3(){
    return _answer3;
  }
  String getAns4(){
    return _answer4;
  }
  String getAns5(){
    return _answer5;
  }
  String getAns6Place(){
    return _ans6Place;
  }
  String getAns7(){
    return _answer7;
  }
  String getAns8(){
    return _answer8;
  }

  bool getCheck1(){
    return _check1;
  }
  bool getCheck2(){
    return _check2;
  }
  bool getCheck3(){
    return _check3;
  }
  bool getCheck4(){
    return _check4;
  }
  bool getCheck5(){
    return _check5;
  }
  bool getCheck6(){
    return _check6;
  }
  bool getCheck7(){
    return _check7;
  }
  bool getCheck8(){
    return _check8;
  }
  bool getCheck9(){
    return _check9;
  }
  bool getCheck10(){
    return _check10;
  }
  bool getCheck11(){
    return _check11;
  }
  String getOtherSymp(){
    return _otherSymptom;
  }

  bool getCheck1Part2(){
    return _part2Check1;
  }
  bool getCheck2Part2(){
    return _part2Check2;
  }
  bool getCheck3Part2(){
    return _part2Check3;
  }
  bool getCheck4Part2(){
    return _part2Check4;
  }
  bool getCheck5Part2(){
    return _part2Check5;
  }
  String getAllergy(){
    return _specificAllergy;
  }

  String getMode(){
    return _mode;
  }
  String getShuttleNumber(){
    return _shutteNumber;
  }
  String getSeatNumber(){
    return _seatNumber;
  }
  String getTemperature(){
    return _temperature;
  }
  String getRoute(){
    return _route;
  }
  String getPlace(){
    return _place;
  }
  String getTravelMode(){
    return _travelMode;
  }
  String getTranspo(){
    return transpo;
  }
  String getLobbyNum(){
    return lobbyNum;
  }
  void resetTranspo(){
    transpo = '';
  }
}