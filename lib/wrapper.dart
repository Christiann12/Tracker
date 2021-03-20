import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacttracer/models/netConnectionModel.dart';
import 'package:contacttracer/process/authProcess.dart';
import 'package:contacttracer/screens/homescreens/homescreen.dart';
import 'package:contacttracer/screens/offlinemode/offlineCanteen.dart';
import 'package:contacttracer/screens/offlinemode/offlinemodescreen.dart';
import 'package:flutter/material.dart';
import 'package:contacttracer/screens/loginScreen/loginUI.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:toast/toast.dart';

var connectivityResult;
var connectivityResult1;
var user;
AuthProcess authProcess = AuthProcess();

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  void initState() {
    getConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      OfflineCanteenInput offlineCanteenInput = OfflineCanteenInput();
      offlineCanteenInput.doSomeUpdate();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context);
    final connection = Provider.of<NetConnectionModel>(context);
    getConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      sendEmail();
    }
    return user != null
        ? connection == null ? OfflineModeScreen() : Homescreen()
        : Provider.of<NetConnectionModel>(context) == null
            ? OfflineModeScreen()
            : LoginUi();
  }

  Future getConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  void sendEmail() async {
    DocumentSnapshot documentSnapshot = await Firestore.instance
        .collection('userData')
        .document(user.uid)
        .get();
    List<String> _listOfPlaces = [
      'Shuttle',
      'Lobby'
    ];
    try {
      for (var v = 0; v <= _listOfPlaces.length - 1; v++) {
        await Firestore.instance
            .collection(_listOfPlaces[v])
            .where('employeeNumber',
                isEqualTo: documentSnapshot['employeeNumber'])
            .where('emailSend', isEqualTo: 'no')
            .getDocuments()
            .then((datas) async {
          for (var i = 0; i < datas.documents.length; i++) {
            String _username = ' testsendercontacttracer@gmail.com';
            String _password = 'zeuzatxzlwlnafxa';

            final smtpServer = gmail(_username, _password);
            final message = Message()
              ..from = Address(_username)
              ..recipients.add('noelpili@yahoo.com')
              //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
              //..bccRecipients.add(Address('bccAddress@example.com'))
              ..subject = '${documentSnapshot['firstName']} ${documentSnapshot['lastName']} ${documentSnapshot['employeeNumber']} answered yes in triage'
              ..text = 'Triage answers are.'
                  'Exposure and Travel History'
                  '\n Question 1 : ${datas.documents[i]['exposureAndTravelHistory']['question1']}'
                  '\n Question 2 : ${datas.documents[i]['exposureAndTravelHistory']['question2']}'
                  '\n Question 3 : ${datas.documents[i]['exposureAndTravelHistory']['question3']}'
                  '\n Question 4 : ${datas.documents[i]['exposureAndTravelHistory']['question4']}'
                  '\n Question 5 : ${datas.documents[i]['exposureAndTravelHistory']['question5']}'
                  '\n Question 6 : ${datas.documents[i]['exposureAndTravelHistory']['question6']} ${datas.documents[i]['exposureAndTravelHistory']['question6'] == 'Yes' ? datas.documents[i]['exposureAndTravelHistory']['travelledPlace'] : ''}'
                  '\n Question 7 : ${datas.documents[i]['exposureAndTravelHistory']['question7']}'
                  '\n Question 8 : ${datas.documents[i]['exposureAndTravelHistory']['question8']}'
                  '\n Signs and Symptoms'
                  '\n Nasal Congestion : ${datas.documents[i]['signsAndSymptoms']['nasalCongestion'] == true ? 'Yes' : 'No'}'
                  '\n Sore Throat : ${datas.documents[i]['signsAndSymptoms']['soreThroat'] == true ? 'Yes' : 'No'}'
                  '\n Shortness of breath : ${datas.documents[i]['signsAndSymptoms']['shortnessOfBreath'] == true ? 'Yes' : 'No'}'
                  '\n Headache : ${datas.documents[i]['signsAndSymptoms']['headAches'] == true ? 'Yes' : 'No'}'
                  '\n Body ache : ${datas.documents[i]['signsAndSymptoms']['bodyAches'] == true ? 'Yes' : 'No'}'
                  '\n Vommiting : ${datas.documents[i]['signsAndSymptoms']['vommiting'] == true ? 'Yes' : 'No'}'
                  '\n Fever : ${datas.documents[i]['signsAndSymptoms']['fever'] == true ? 'Yes' : 'No'}'
                  '\n Cough : ${datas.documents[i]['signsAndSymptoms']['cough'] == true ? 'Yes' : 'No'}'
                  '\n Fatigue : ${datas.documents[i]['signsAndSymptoms']['fatigue'] == true ? 'Yes' : 'No'}'
                  '\n Diarrhea : ${datas.documents[i]['signsAndSymptoms']['diarrhea'] == true ? 'Yes' : 'No'}'
                  '\n Chills : ${datas.documents[i]['signsAndSymptoms']['chills'] == true ? 'Yes' : 'No'}'
                  '\n Others : ${datas.documents[i]['signsAndSymptoms']['others']}'
                  '\n Health Status'
                  '\n Hypertensiion : ${datas.documents[i]['healthStatus']['hypertension'] == true ? 'Yes' : 'No'}'
                  '\n Diabetes : ${datas.documents[i]['healthStatus']['diabetes'] == true ? 'Yes' : 'No'}'
                  '\n Asthma : ${datas.documents[i]['healthStatus']['asthma'] == true ? 'Yes' : 'No'}'
                  '\n Pregnant : ${datas.documents[i]['healthStatus']['pregnant'] == true ? 'Yes' : 'No'}'
                  '\n Allergy : ${datas.documents[i]['healthStatus']['allergy'] == true ? 'Yes' : 'No'} ${datas.documents[i]['healthStatus']['specificAllergy']}';
            //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

            try {
              final sendReport = await send(message, smtpServer);
              print('Message sent: ' + sendReport.toString());
            } on MailerException catch (e) {
              print('Message not sent. \n' + e.toString());
            }
            String date = datas.documents[i]['date'];
            String day ='';
            String month='';
            String year='';
            int count =0;
            for(int i = 0; i <= date.length-1; i++){
              if(date[i] == '/'){
                count++;
                continue;
              }
              if(count == 0){
                month = '$month${date[i]}';
              }
              else if(count == 1){
                day = '$day${date[i]}';
              }
              else if(count == 2){
                year = '$year${date[i]}';
              }
            }
            //print('$day-$month-$year');
            DocumentReference records = await Firestore.instance.collection(_listOfPlaces[v]).document('$day-$month-$year-${datas.documents[i]['timeIn']}-${documentSnapshot['employeeNumber']}-offline');
            records.updateData({
              'emailSend' : 'yes'
            });
          }
        });
      }
    } catch (e) {
      
      print(e.message);
    }
  }
}
