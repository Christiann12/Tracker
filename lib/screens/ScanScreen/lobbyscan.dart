import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/Widgets/triageCard.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:contacttracer/process/databaseProcess.dart';
import 'package:contacttracer/screens/ScanScreen/shuttleScan.dart';
import 'package:contacttracer/screens/homescreens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:toast/toast.dart';

Homescreen homescreen = Homescreen();

List<dynamic> _pages;
int _page = 0;
String lobbyNum = 'Lobby Number';
String _temperature ;
bool loading = false;

class LobbyScan extends StatefulWidget {
  void reset(){
    _page = 0;
    loading = false;
  }
  final String place;
  final String lobbyNum;
  final String state;
  LobbyScan(
      {Key key,
      @required this.place,
      @required this.lobbyNum,
      @required this.state})
      : super(key: key);
  @override
  _LobbyScanState createState() => _LobbyScanState();
}

class _LobbyScanState extends State<LobbyScan> {
  @override
  Widget build(BuildContext context) {
    _pages = [body1(),body2()];
    return loading == true
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[200],
              title: Text('Lobby'),
            ),
            body: _pages[_page],
          );
  }

  Container body1() {
    final _formKey = GlobalKey<FormState>();
    return Container(
        child: Column(
      children: <Widget>[
        widget.lobbyNum == 'Yes'? SizedBox() :Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            '${widget.place} ${widget.lobbyNum}',
            style: TextStyle(fontSize: 20),
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(widget.state == 'exist'
                  ? 'Transportation mode: Shuttle'
                  : 'Transportation mode: Personal Car')),
        ),
        widget.lobbyNum == 'Yes' ? Container(
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
                        value: lobbyNum,
                        elevation: 3,
                        underline: Container(
                          height: 0,
                        ),
                        style: TextStyle(color: Colors.grey[600]),
                        onChanged: (String newValue) {
                          setState(() {
                            lobbyNum = newValue;
                            
                          });
                        },
                        items: <String>['Lobby Number', 'A4', 'A5']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ) : SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Form(
            key : _formKey,
            child: TextFormField(
              validator: (val) => val.isNotEmpty && (isFloat(val) || isNumeric(val)) ? null: 'number only',
              onChanged: (val) {
                _temperature = val;
              },
              keyboardType: TextInputType.number,
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
                hintText: "Temperature",
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: () async {
              if(widget.lobbyNum == 'Yes' && lobbyNum != 'Lobby Number'){
                if (widget.state == 'exist') {
              //print(widget.place);
              if(_formKey.currentState.validate()){
                setState(() {
                loading = true;
                });
                String result = await DatabaseProcess(
                       uid: '${Provider.of<UserModel>(context).uid.toString()}')
                    .updateLobbyData(
                        widget.place, 'Shuttle', _temperature, lobbyNum);
                if (result == 'error') {
                  Toast.show("Something went wrong", context,
                      duration: 5, gravity: Toast.BOTTOM);
                } else if (result == 'success') {
                  Toast.show("Data recorded", context,
                      duration: 5, gravity: Toast.BOTTOM);
                }
                
                Navigator.pop(context);
                setState(() {
                    homescreen.reset();
                  
                  loading = false;
                 
                  });
                }
              }
              else if(widget.state != 'exist'){
                if(_formKey.currentState.validate()){
                  setState(() {
                  _page = 1;
                  });
                  triageCard.setDetailsForLobby(widget.place, _temperature, lobbyNum, 'Private Car');
                }
              }
              }
              else if(widget.lobbyNum != 'Yes'){
                print('wors');
                if (widget.state == 'exist') {
              //print(widget.place);
              if(_formKey.currentState.validate()){
                setState(() {
                loading = true;
                });
                String result = await DatabaseProcess(
                       uid: '${Provider.of<UserModel>(context).uid.toString()}')
                    .updateLobbyData(
                        widget.place, 'Shuttle', _temperature, widget.lobbyNum);
                if (result == 'error') {
                  Toast.show("Something went wrong", context,
                      duration: 5, gravity: Toast.BOTTOM);
                } else if (result == 'success') {
                  Toast.show("Data recorded", context,
                      duration: 5, gravity: Toast.BOTTOM);
                }
               
                  Navigator.pop(context);
                  setState(() {
                    homescreen.reset();
                  
                  loading = false;
                 
                  });
                }
              }
              else if(widget.state != 'exist'){
                if(_formKey.currentState.validate()){
                  setState(() {
                  _page = 1;
                  });
                  triageCard.setDetailsForLobby(widget.place, _temperature, widget.lobbyNum, 'Private Car');
                }
              }
              }
              else{
                Toast.show("Enter Lobby Number", context,
                      duration: 5, gravity: Toast.BOTTOM);
              }
              
            },
          color: Colors.blue[200],
          child: Text(widget.state == 'exist' ? 'Submit' : 'Next Page'),
        )
      ],
    ));
  }

  Widget body2(){
    return TriageCard();
  }
}
