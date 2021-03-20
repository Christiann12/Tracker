import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/Widgets/part2Questions.dart';
import 'package:contacttracer/Widgets/part3Questions.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:contacttracer/process/databaseProcess.dart';
import 'package:contacttracer/process/triadBrain.dart';
import 'package:contacttracer/screens/ScanScreen/lobbyscan.dart';
import 'package:contacttracer/screens/ScanScreen/shuttleScan.dart';
import 'package:flutter/material.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:mailer/mailer.dart';


final CollectionReference userDataCollection = Firestore.instance.collection('userData');


TriadBrain triadBrain = TriadBrain();
ShuttleScan shuttleScan = ShuttleScan(mode: null, route: null, place: null, scanNum: null,manual: null,);
Part2Questions part2questions = Part2Questions();
Part3Questions part3questions = Part3Questions();
LobbyScan lobbyScan = LobbyScan(state: null,lobbyNum: null, place: null,);

bool signature = false;
int _page = 1;
String number6Ans = '';
 String wholeName;
 String employeeNum;
 

class TriageCard extends StatefulWidget {

  void setBoolInBrainPart3(int index, bool newValue){
    triadBrain.setPart2Bool(index, newValue);
  }
  void setBoolInBrainPart2(int index, bool newValue){
    triadBrain.setBool(index, newValue);
  }
  void setAlleryString(String val){
    triadBrain.setSpecificAllergyString(val);
  }
  void setPlaceString(String newPlace, String mode){
    triadBrain.setStringPlace(newPlace,mode);
  }
  void setDetails(String _shutteNumber,String _seatNumber,String _temperature,String _route,String _travelMode,String place){
    triadBrain.setDetails(_shutteNumber, _seatNumber, _temperature, _route,_travelMode,place);
  }
  
  void setDetailsForLobby(String place, String temperature, String lobbyNum, String transpo){
    triadBrain.setDetailsforLobby(place, temperature, lobbyNum, transpo);
  }
  
  void resetTranspo(){
    triadBrain.resetTranspo();
  }
  
  @override
  _TriageCardState createState() => _TriageCardState();
}

class _TriageCardState extends State<TriageCard> {
  
  Color button1 = Colors.blue[200];
  Color button2 = Colors.grey[300];
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  
  @override
  void dispose() {
    signature = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return loading == true ? Loading() : Container(
      child: Column(
        children: <Widget>[
          _page == 1
              ? Expanded(
                  flex: 4,
                  child: ListView.builder(
                    itemCount: triadBrain.getListLength(),
                    itemBuilder: (context, index) {
                      return Card(
                          child: Column(
                        children: <Widget>[
                          Text(
                            triadBrain.getTriadQuestion(index),
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          index == 5 && triadBrain.getListLength() == 8
                              ? Form(
                                  key: _formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      onChanged: (val) {
                                        number6Ans = val;
                                      },
                                      validator: (val) =>
                                          val.isEmpty ? 'Required field' : null,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(fontSize: 15),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue[200]),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue[200]),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue[200])),
                                        hintText: "Place",
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              FlatButton(
                                color: triadBrain.getColor1(index + 1),
                                onPressed: () {
                                  setState(() {
                                    triadBrain.setColor(index + 1, 'Yes');
                                    triadBrain.setAnswer(index + 1, 'Yes');
                                  });
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              FlatButton(
                                color: triadBrain.getColor2(index + 1),
                                onPressed: () {
                                  setState(() {
                                    triadBrain.setColor(index + 1, 'No');
                                    triadBrain.setAnswer(index + 1, 'No');
                                    if(index == 5){
                                        number6Ans = '';
                                    }
                                    //_mode = 'out';
                                    //print(_mode);
                                  });
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          )
                        ],
                      ));
                    },
                  ))
              : Expanded(
                  flex: 4,
                  child: ListView(
                    children: <Widget>[
                      Text(
                        'Signs and Symptoms',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'Please check any applicable symptoms you experienced in the last 14 days.'),
                      Part2Questions(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (val) {
                            triadBrain.setOtherSymptoms(val);
                          },
                          validator: (val) =>
                              val.isEmpty ? 'Required field' : null,
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
                            hintText: "Others please specify",
                          ),
                        ),
                      ),
                      Text(
                        'Health Status',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('Do you have any of the following?'),
                      Part3Questions(),
                      Divider(
                        color: Colors.black,
                        thickness:1,
                      ),
                      CheckboxListTile(

                        value: signature,
                        title: RichText(
                          text: TextSpan(
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'I'),
                              TextSpan(text: ' $wholeName',style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: ' with employee number'),
                              TextSpan(text: ' $employeeNum',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                              TextSpan(text: ' declare that all answers I provide in this Triage Questionnaire are true and correct. I am also aware that I will be held responsible, liable, and might be severely punished if I came in with symptoms of COVID-19, identified as Confirmed, Suspect or Probable, part of the contact tracing in my community, or have contact or living with someone who is a COVID positive')
                            ]
                          ),

                        ),
                        
                        onChanged: (newValue) {
                          setState(() {
                            signature = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      )
                    ],
                  )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
              child: FlatButton(
                  color: Colors.blue[200],
                  onPressed: () async {
                      if (_page == 1) {
                        if (triadBrain.getAns1() != '' && triadBrain.getAns2() != '' && triadBrain.getAns3() != '' && triadBrain.getAns4() != '' && triadBrain.getAns5() != '' && triadBrain.getAns6() != '') {
                          if (triadBrain.getAns6() == 'No') {
                            triadBrain.setAnswer(7, 'No');
                            triadBrain.setAnswer(8, 'No');
                             setState(() {
                                  loading = true;
                                });
                              employeeNum = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').getEmployeeNum();
                              wholeName = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').getUserName();
                              setState(() {
                                  _page = 2;
                                });
                              loading = false;
                          }
                          else if(triadBrain.getAns6() == 'Yes' && (  triadBrain.getAns7() == '' || triadBrain.getAns8() == '')){
                            Toast.show("Form is not complete", context, duration: 5, gravity:  Toast.BOTTOM);
                          }
                          else{
                            if (triadBrain.getAns6() == 'Yes') {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                employeeNum = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').getEmployeeNum();
                                wholeName = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').getUserName();
                                triadBrain.setAns6PlaceString(number6Ans);
                                setState(() {
                                  _page = 2;
                                });
                                loading = false;
                              }
                              
                            } 
                          }
                        }
                        else{
                          Toast.show("Form is not complete", context, duration: 5, gravity:  Toast.BOTTOM);
                        }
                      } else if (_page == 2) {
                        if (signature == true) {
                          if (triadBrain.getTranspo() != 'Private Car') {
                            
                            if(triadBrain.getPart2Check5() == true && triadBrain.getSpecificAllergyString() == ''){
                              Toast.show("Input allergy", context, duration: 5, gravity:  Toast.BOTTOM);
                            }
                            else{
                              setState(() {
                                loading = true;
                              });
                              
                              if(triadBrain.getAns1() == 'Yes'|| triadBrain.getAns2() == 'Yes' || triadBrain.getAns3() == 'Yes' || triadBrain.getAns4() == 'Yes' || triadBrain.getAns5() == 'Yes' || triadBrain.getAns6() == 'Yes'|| triadBrain.getAns8() == 'Yes'|| triadBrain.getAns8() == 'Yes' ||
                              triadBrain.getCheck1() == true || triadBrain.getCheck2()== true || triadBrain.getCheck3()== true || triadBrain.getCheck4()== true || triadBrain.getCheck5()== true || triadBrain.getCheck6()== true || triadBrain.getCheck7()== true || triadBrain.getCheck8()== true || triadBrain.getCheck9() == true || triadBrain.getCheck10() == true || triadBrain.getCheck11()== true){
                              print('works');

                                String _username = ' testsendercontacttracer@gmail.com';
                                String _password = 'zeuzatxzlwlnafxa';

                                
   
                                final smtpServer = gmail(_username, _password);
                                final message = Message()
                                  ..from = Address(_username)
                                  ..recipients.add('noelpili@yahoo.com')
                                  //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
                                  //..bccRecipients.add(Address('bccAddress@example.com'))
                                  ..subject = '$wholeName $employeeNum answered yes in triage'
                                  ..text = 'Triage answers are.'
                                  'Exposure and Travel History'
                                  '\n Question 1 : ${triadBrain.getAns1()}'
                                  '\n Question 2 : ${triadBrain.getAns2()}'
                                  '\n Question 3 : ${triadBrain.getAns3()}'
                                  '\n Question 4 : ${triadBrain.getAns4()}'
                                  '\n Question 5 : ${triadBrain.getAns5()}'
                                  '\n Question 6 : ${triadBrain.getAns6()} ${triadBrain.getAns6() == 'Yes' ? triadBrain.getAns6Place : ''}'
                                  '\n Question 7 : ${triadBrain.getAns7()}'
                                  '\n Question 8 : ${triadBrain.getAns8()}'
                                  '\n Signs and Symptoms'
                                  '\n Nasal Congestion : ${triadBrain.getCheck1() == true ? 'Yes' : 'No'}'
                                  '\n Sore Throat : ${triadBrain.getCheck2() == true ? 'Yes' : 'No'}'
                                  '\n Shortness of breath : ${triadBrain.getCheck3() == true ? 'Yes' : 'No'}'
                                  '\n Headache : ${triadBrain.getCheck4() == true ? 'Yes' : 'No'}'
                                  '\n Body ache : ${triadBrain.getCheck5() == true ? 'Yes' : 'No'}'
                                  '\n Vommiting : ${triadBrain.getCheck6() == true ? 'Yes' : 'No'}'
                                  '\n Fever : ${triadBrain.getCheck7() == true ? 'Yes' : 'No'}'
                                  '\n Cough : ${triadBrain.getCheck8() == true ? 'Yes' : 'No'}'
                                  '\n Fatigue : ${triadBrain.getCheck9() == true ? 'Yes' : 'No'}'
                                  '\n Diarrhea : ${triadBrain.getCheck10() == true ? 'Yes' : 'No'}'
                                  '\n Chills : ${triadBrain.getCheck11() == true ? 'Yes' : 'No'}'
                                  '\n Others : ${triadBrain.getOtherSymp()}'
                                  '\n Health Status'
                                  '\n Hypertensiion : ${triadBrain.getCheck1Part2() == true ? 'Yes' : 'No'}'
                                  '\n Diabetes : ${triadBrain.getCheck2Part2() == true ? 'Yes' : 'No'}'
                                  '\n Asthma : ${triadBrain.getCheck3Part2() == true ? 'Yes' : 'No'}'
                                  '\n Pregnant : ${triadBrain.getCheck4Part2() == true ? 'Yes' : 'No'}'
                                  '\n Allergy : ${triadBrain.getCheck5Part2() == true ? 'Yes' : 'No'} ${triadBrain.getAllergy()}';
                                  //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

                                try {
                                    final sendReport = await send(message, smtpServer);
                                    print('Message sent: ' + sendReport.toString());
                                  } on MailerException catch (e) {
                                  print('Message not sent. \n'+ e.toString()); 
                                }
                              }

                              String result = await triadBrain.submit(Provider.of<UserModel>(context).uid.toString(),triadBrain.getAns1(),triadBrain.getAns2(),triadBrain.getAns3(),triadBrain.getAns4(),triadBrain.getAns5(),triadBrain.getAns6(),triadBrain.getAns7(),triadBrain.getAns8(),triadBrain.getAns6Place(),
                              triadBrain.getMode(),triadBrain.getShuttleNumber(),triadBrain.getSeatNumber(),triadBrain.getTemperature(),
                              triadBrain.getCheck1(),triadBrain.getCheck2(),triadBrain.getCheck3(),triadBrain.getCheck4(),triadBrain.getCheck5(),triadBrain.getCheck6(),triadBrain.getCheck7(),triadBrain.getCheck8(),triadBrain.getCheck9(),triadBrain.getCheck10(),triadBrain.getCheck11(),triadBrain.getOtherSymp(),
                              triadBrain.getCheck1Part2(),triadBrain.getCheck2Part2(),triadBrain.getCheck3Part2(),triadBrain.getCheck4Part2(),triadBrain.getCheck5Part2(),triadBrain.getAllergy(),triadBrain.getRoute(),triadBrain.getPlace(),triadBrain.getTravelMode());
                              triadBrain.reset();
                              shuttleScan.reset();
                              part2questions.reset();
                              part3questions.reset();
                              if (result == 'error') {
                                  Toast.show("Something went wrong", context,
                                      duration: 5, gravity: Toast.BOTTOM);
                                } else if (result == 'success') {
                                  Toast.show("Data recorded", context,
                                      duration: 5, gravity: Toast.BOTTOM);
                                }
                              Navigator.pop(context);
                              _page = 1;
                            }
                          }
                          else{
                            if(triadBrain.getPart2Check5() == true && triadBrain.getSpecificAllergyString() == ''){
                              Toast.show("Input allergy", context, duration: 5, gravity:  Toast.BOTTOM);
                              
                            }
                            else{
                              setState(() {
                                loading = true;
                              });
                              //
                              if(triadBrain.getAns1() == 'Yes'|| triadBrain.getAns2() == 'Yes' || triadBrain.getAns3() == 'Yes' || triadBrain.getAns4() == 'Yes' || triadBrain.getAns5() == 'Yes' || triadBrain.getAns6() == 'Yes'|| triadBrain.getAns8() == 'Yes'|| triadBrain.getAns8() == 'Yes' ||
                              triadBrain.getCheck1() == true || triadBrain.getCheck2()== true || triadBrain.getCheck3()== true || triadBrain.getCheck4()== true || triadBrain.getCheck5()== true || triadBrain.getCheck6()== true || triadBrain.getCheck7()== true || triadBrain.getCheck8()== true || triadBrain.getCheck9() == true || triadBrain.getCheck10() == true || triadBrain.getCheck11()== true){
                              print('works');

                                String _username = ' testsendercontacttracer@gmail.com';
                                String _password = 'zeuzatxzlwlnafxa';

                                
   
                                final smtpServer = gmail(_username, _password);
                                final message = Message()
                                  ..from = Address(_username)
                                  ..recipients.add('noelpili@yahoo.com')
                                  //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
                                  //..bccRecipients.add(Address('bccAddress@example.com'))
                                  ..subject = '$wholeName $employeeNum answered yes in triage'
                                  ..text = 'Triage answers are.'
                                  'Exposure and Travel History'
                                  '\n Question 1 : ${triadBrain.getAns1()}'
                                  '\n Question 2 : ${triadBrain.getAns2()}'
                                  '\n Question 3 : ${triadBrain.getAns3()}'
                                  '\n Question 4 : ${triadBrain.getAns4()}'
                                  '\n Question 5 : ${triadBrain.getAns5()}'
                                  '\n Question 6 : ${triadBrain.getAns6()} ${triadBrain.getAns6() == 'Yes' ? triadBrain.getAns6Place : ''}'
                                  '\n Question 7 : ${triadBrain.getAns7()}'
                                  '\n Question 8 : ${triadBrain.getAns8()}'
                                  '\n Signs and Symptoms'
                                  '\n Nasal Congestion : ${triadBrain.getCheck1() == true ? 'Yes' : 'No'}'
                                  '\n Sore Throat : ${triadBrain.getCheck2()== true ? 'Yes' : 'No'}'
                                  '\n Shortness of breath : ${triadBrain.getCheck3() == true ? 'Yes' : 'No'}'
                                  '\n Headache : ${triadBrain.getCheck4() == true ? 'Yes' : 'No'}'
                                  '\n Body ache : ${triadBrain.getCheck5() == true ? 'Yes' : 'No'}'
                                  '\n Vommiting : ${triadBrain.getCheck6() == true ? 'Yes' : 'No'}'
                                  '\n Fever : ${triadBrain.getCheck7() == true ? 'Yes' : 'No'}'
                                  '\n Cough : ${triadBrain.getCheck8() == true ? 'Yes' : 'No'}'
                                  '\n Fatigue : ${triadBrain.getCheck9() == true ? 'Yes' : 'No'}'
                                  '\n Diarrhea : ${triadBrain.getCheck10() == true ? 'Yes' : 'No'}'
                                  '\n Chills : ${triadBrain.getCheck11() == true ? 'Yes' : 'No'}'
                                  '\n Others : ${triadBrain.getOtherSymp()}'
                                  '\n Health Status'
                                  '\n Hypertensiion : ${triadBrain.getCheck1Part2() == true ? 'Yes' : 'No'}'
                                  '\n Diabetes : ${triadBrain.getCheck2Part2() == true ? 'Yes' : 'No'}'
                                  '\n Asthma : ${triadBrain.getCheck3Part2() == true ? 'Yes' : 'No'}'
                                  '\n Pregnant : ${triadBrain.getCheck4Part2() == true ? 'Yes' : 'No'}'
                                  '\n Allergy : ${triadBrain.getCheck5Part2() == true ? 'Yes' : 'No'} ${triadBrain.getAllergy()}';
                                  //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

                                try {
                                    final sendReport = await send(message, smtpServer);
                                    print('Message sent: ' + sendReport.toString());
                                  } on MailerException catch (e) {
                                  print('Message not sent. \n'+ e.toString()); 
                                }
                              }

                              String result = await triadBrain.submitLobby(Provider.of<UserModel>(context).uid.toString(),triadBrain.getAns1(),triadBrain.getAns2(),triadBrain.getAns3(),triadBrain.getAns4(),triadBrain.getAns5(),triadBrain.getAns6(),triadBrain.getAns7(),triadBrain.getAns8(),triadBrain.getAns6Place(),
                              triadBrain.getTemperature(), triadBrain.getLobbyNum(), triadBrain.getTranspo(), triadBrain.getPlace(),
                              triadBrain.getCheck1(),triadBrain.getCheck2(),triadBrain.getCheck3(),triadBrain.getCheck4(),triadBrain.getCheck5(),triadBrain.getCheck6(),triadBrain.getCheck7(),triadBrain.getCheck8(),triadBrain.getCheck9(),triadBrain.getCheck10(),triadBrain.getCheck11(),triadBrain.getOtherSymp(),
                              triadBrain.getCheck1Part2(),triadBrain.getCheck2Part2(),triadBrain.getCheck3Part2(),triadBrain.getCheck4Part2(),triadBrain.getCheck5Part2(),triadBrain.getAllergy());
                              triadBrain.reset();
                              lobbyScan.reset();
                              part2questions.reset();
                              part3questions.reset();
                              if (result == 'error') {
                                  Toast.show("Something went wrong", context,
                                      duration: 5, gravity: Toast.BOTTOM);
                                } else if (result == 'success') {
                                  Toast.show("Data recorded", context,
                                      duration: 5, gravity: Toast.BOTTOM);
                                }
                              Navigator.pop(context);
                              _page = 1;
                            }
                          }
                        }
                        else{
                           Toast.show("Triage Questionnaire is still not complete", context,
                                      duration: 5, gravity: Toast.BOTTOM);
                        }
                      }

                    loading = false;
                  },
                  child: Text(
                    _page == 1 ? 'Next Page' : 'Submit',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
