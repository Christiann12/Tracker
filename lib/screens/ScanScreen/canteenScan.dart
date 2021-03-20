import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:contacttracer/process/databaseProcess.dart';
import 'package:contacttracer/screens/homescreens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toast/toast.dart';
import 'package:string_validator/string_validator.dart';
import 'package:provider/provider.dart';

Homescreen homescreen = Homescreen();

int _page = 0;
List<dynamic> _pages;
String _tableNumber = '';
String _seatNumber = '';
bool loading = false;

class CanteenScan extends StatefulWidget {
  final String place;
  final String mode;
  final String timeIn;
  final String dineMode;
  final String date;
  CanteenScan(
      {Key key,
      @required this.place,
      @required this.mode,
      @required this.timeIn,
      @required this.dineMode,
      @required this.date})
      : super(key: key);
  @override
  _CanteenScanState createState() => _CanteenScanState();
}

class _CanteenScanState extends State<CanteenScan> {
  Color button1 = Colors.blue[200];
  Color button2 = Colors.grey[300];
  String _mode = 'in';
  QRViewController controller;
  String dineMode = 'Dine Mode';

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    _pages = [
      widget.mode == 'In' ? body1() : body2(),
    ];

    return loading == true
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Canteen'),
              backgroundColor: Colors.blue[200],
            ),
            body: _pages[_page]);
  }

  Container body2() {
    return Container(
      child: Column(
        children: <Widget>[
         SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.warning,
              color: Colors.blue[200],
              size: 25,
            ),
            title: Text(
                'By pressing the button you will record your time out data created on ${widget.timeIn} and on ${widget.date}'),
          ),
          FlatButton(
              color: Colors.blue[200],
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                String result = await DatabaseProcess(
                        uid: '${Provider.of<UserModel>(context).uid.toString()}')
                    .updateCanteenDataOut(widget.place);
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
              },
              child: Text('Ok'))
        ],
      ),
    );
  }

  Container body1() {
    final _formKey = GlobalKey<FormState>();
    return Container(
      child: SafeArea(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
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
                        value: dineMode,
                        elevation: 3,
                        underline: Container(
                          height: 0,
                        ),
                        style: TextStyle(color: Colors.grey[600]),
                        onChanged: (String newValue) {
                          setState(() {
                            dineMode = newValue;
                            print(dineMode);
                          });
                        },
                        items: <String>['Dine Mode', 'dine in', 'dine out']
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
                  Visibility(
                    visible: dineMode == 'dine out' ? false : true,
                    child: TextFormField(
                      validator: dineMode == 'dine out'
                          ? null
                          : (val) => isNumeric(val) ? null : 'number only',
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
                        hintText: "Table Number",
                      ),
                      onChanged: (sNum) {
                        _tableNumber = sNum;
                        //print(_seatNumber);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: dineMode == 'dine out' ? false : true,
                    child: TextFormField(
                      validator: dineMode == 'dine out'
                          ? null
                          : (val) => isNumeric(val) ? null : 'number only',
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
                        print(_seatNumber);
                      },
                    ),
                  ),
                  FlatButton(
                      color: Colors.blue[200],
                      onPressed: () async {
                        print(dineMode);
                        if (dineMode == 'dine in') {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await DatabaseProcess(
                                    uid: '${Provider.of<UserModel>(context).uid.toString()}')
                                .updateCanteenDataIn(
                                    widget.place,
                                    _mode,
                                    _tableNumber,
                                    _seatNumber,
                                    context,
                                    dineMode);

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
                        }
                        if (dineMode == 'dine out') {
                          _seatNumber = '';
                          _tableNumber = '';
                          print('object');
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await DatabaseProcess(
                                  uid: '${Provider.of<UserModel>(context).uid.toString()}')
                              .updateCanteenDataIn(widget.place, _mode,
                                  _tableNumber, _seatNumber, context, dineMode);

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
                      },
                      child: Text('submit'))
                ],
              ),
            )),
      ),
    );
  }
}
