import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/Widgets/triageCard.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:contacttracer/process/databaseProcess.dart';
import 'package:contacttracer/screens/homescreens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:string_validator/string_validator.dart';
import 'package:toast/toast.dart';

TriageCard triageCard = TriageCard();
Homescreen homescreen = Homescreen();
List<dynamic> _pages;
int _page = 0;
String route = 'Route';
String _shutteNumber = '';
String _seatNumber = '';
String _temperature = '';


class ShuttleScan extends StatefulWidget {
  void reset() {
    _page = 0;
    _shutteNumber = '';
    _seatNumber = '';
    _temperature = '';
  }
    final String mode;
    final String route;
    final String place;
    final String scanNum;
    final String manual;
    
    ShuttleScan({Key key, @required this.mode,@required this.route,@required this.place,@required this.scanNum,@required this.manual}) : super(key: key);
  @override
  _ShuttleScanState createState() => _ShuttleScanState();
}

class _ShuttleScanState extends State<ShuttleScan> {

  Color button1 = Colors.blue[200];
  Color button2 = Colors.grey[300];
  QRViewController controller;
  bool loading = false;
  String travelMode = 'Travel Mode';

  @override
  Widget build(BuildContext context) {
    _pages = [ widget.mode == 'Incoming' || widget.mode == 'Outgoing' ?specialBody() : body1(), body2(),];
    
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[200], title: Text('Shuttle')),
      body: loading == true ? Loading() : _pages[_page],
    );
  }

  Container body1() {
    if(widget.scanNum == '1'){
      travelMode = 'Incoming';
    }
    final _formKey = GlobalKey<FormState>();
    return Container(
      child: SafeArea(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  widget.scanNum == '1' ? ListTile(
                    leading: Icon(Icons.warning, color: Colors.blue[200], size: 25,),
                    title: Text('You haven\'t answered Triage for today'),
                  ) : SizedBox(height: 0),
                  widget.manual == 'no' ?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('Route: ${widget.route}', style: TextStyle(fontSize: 18),),),
                  ):  Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
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
                        value: route,
                        elevation: 3,
                        underline: Container(
                          height: 0,
                        ),
                        style: TextStyle(color: Colors.grey[600]),
                        onChanged: (String newValue) {
                          setState(() {
                            route = newValue;
                          });
                        },
                        items: <String>[
                          'Route',
                          'Calamba',
                          'San Pablo',
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
                  Container(
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
                        value: travelMode,
                        elevation: 3,
                        underline: Container(
                          height: 0,
                        ),
                        style: TextStyle(color: Colors.grey[600]),
                        onChanged: (String newValue) {
                          setState(() {
                            travelMode = newValue;
                            print(travelMode);
                          });
                        },
                        items: <String>['Travel Mode', 'Incoming', 'Outgoing']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) => isNumeric(val) ? null : 'number only',
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
                      hintText: "bus Number",
                    ),
                    onChanged: (tNum) {
                      _shutteNumber = tNum;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) => isNumeric(val) ? null : 'number only',
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
                      hintText: "Seat Number",
                    ),
                    onChanged: (sNum) {
                      _seatNumber = sNum;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: travelMode == 'Outgoing' ? false : true,
                    child: TextFormField(
                      validator: travelMode == 'Outgoing'
                          ? null
                          : (val) =>
                              val.isNotEmpty || (isFloat(val) && isNumeric(val))
                                  ? null
                                  : 'number only',
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
                        hintText:
                            "Temparature"
                      ),
                      onChanged: (tNum) {
                        _temperature = tNum;
                      },
                    ),
                  ),
                  FlatButton(
                      color: Colors.blue[200],
                      onPressed: () async {
                        if (widget.manual == 'yes' && route != 'Route') {
                          if (travelMode == 'Incoming') {
                            if (_formKey.currentState.validate() ) {
                                triageCard.setDetails(_shutteNumber, _seatNumber, _temperature, route,travelMode,widget.place);
                                triageCard.resetTranspo();
                                setState(() {
                                  _page = 1;
                                });
                                
                            }
                          } else if (travelMode == 'Outgoing') {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                triageCard.resetTranspo();
                                String result = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').updateShuttleDataOutGoingIn(widget.place,travelMode,_shutteNumber,_seatNumber,route);
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
                                _page = 0;
                                });
                            }
                          } else {
                            Toast.show("error", context,
                                duration: 5, gravity: Toast.BOTTOM);
                          }
                        }
                        else if(widget.manual == 'no'){
                          if (travelMode == 'Incoming') {
                            if (_formKey.currentState.validate() ) {
                                triageCard.setDetails(_shutteNumber, _seatNumber, _temperature, widget.route,travelMode,widget.place);
                                triageCard.resetTranspo();
                                setState(() {
                                  _page = 1;
                                });
                            }
                          } else if (travelMode == 'Outgoing') {
                              if (_formKey.currentState.validate()) {
                                triageCard.resetTranspo();
                                setState(() {
                                  loading = true;
                                });
                                String result = await DatabaseProcess(uid: '${Provider.of<UserModel>(context).uid.toString()}').updateShuttleDataOutGoingIn(widget.place,travelMode,_shutteNumber,_seatNumber,widget.route);
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
                                _page = 0;
                                });
                            }
                          } else {
                            Toast.show("error", context,
                                duration: 5, gravity: Toast.BOTTOM);
                          }
                        }
                        else{
                          Toast.show("Enter a route", context,
                                duration: 5, gravity: Toast.BOTTOM);
                        }
                        
                      },
                      child: Text('Next Page'))
                ],
              ),
            )),
      ),
    );
  }

  Widget body2() {
    return TriageCard();
  }

  Widget specialBody() {
    travelMode = widget.mode;
    return Container(
      child: Column(
        children: <Widget>[
           SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.warning, color: Colors.blue[200], size: 25,),
            title: Text('By pressing the button you will record timeout data for your ${widget.mode} record.'),
          ),
          SizedBox(
            height: 20,
          ),
         
          
          FlatButton(
              color: Colors.blue[200],
              onPressed: () async {
                if (travelMode != 'Travel Mode') {
                  setState(() {
                    loading = true;
                  });
                  String result = await DatabaseProcess(
                          uid: '${Provider.of<UserModel>(context).uid.toString()}')
                      .updateShuttleDataOut(widget.place, travelMode);
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
                  _page = 0;
                  });
                }
                else{
                  Toast.show("Choose travel method", context,
                    duration: 5, gravity: Toast.BOTTOM);
                    //Navigator.pop(context);
                }
              },
              child: Text('Ok'))
        ],
      ),
    );
  }

}
