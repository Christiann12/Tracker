import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

bool loading = true;

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();
  TextEditingController _controller7 = TextEditingController();
  TextEditingController _controller8 = TextEditingController();

  Future delay2sec() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    delay2sec();   
  }

  @override
  void dispose() {
    loading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<UserModel>(context).uid.toString();
    return loading == true ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blue[200],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
                child: StreamBuilder(
                stream: Firestore.instance
                    .collection('userData')
                    .where('uid', isEqualTo: uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return SizedBox(
                      height: 0,
                    );

                  _controller1.text =
                      '${snapshot.data.documents[0]['firstName']}';
                  _controller2.text =
                      '${snapshot.data.documents[0]['lastName']}';
                  _controller3.text =
                      '${snapshot.data.documents[0]['employeeNumber']}';
                  _controller4.text =
                      '${snapshot.data.documents[0]['municipality']}';
                  _controller5.text =
                      '${snapshot.data.documents[0]['barangay']}';
                  _controller6.text =
                      '${snapshot.data.documents[0]['department']}';
                  _controller7.text =
                      '${snapshot.data.documents[0]['plant']}';
                  _controller8.text =
                      '${snapshot.data.documents[0]['manager']}';

                  return new ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: Text('First Name: ')),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                validator: (val) => val.isEmpty ? 'Required Field' : null,
                                controller: _controller1,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue[200])),
                                  //hintText: "Seat Number",
                                ),
                                onChanged: (sNum) {
                                  //_seatNumber = sNum;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: Text('Last Name: ')),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                validator: (val) => val.isEmpty ? 'Required Field' : null,
                                controller: _controller2,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue[200])),
                                  //hintText: "Seat Number",
                                ),
                                onChanged: (sNum) {
                                  //_seatNumber = sNum;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: Text('Employee Number: ')),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                maxLength: 6,
                                validator: (val) => val.isEmpty ? 'Required Field' : null,
                                controller: _controller3,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue[200])),
                                  //hintText: "Seat Number",
                                ),
                                onChanged: (sNum) {
                                  //_seatNumber = sNum;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: Text('Municipality: ')),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                validator: (val) => val.isEmpty ? 'Required Field' : null,
                                controller: _controller4,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue[200])),
                                  //hintText: "Seat Number",
                                ),
                                onChanged: (sNum) {
                                  //_seatNumber = sNum;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: Text('Barangay: ')),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                validator: (val) => val.isEmpty ? 'Required Field' : null,
                                controller: _controller5,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue[200])),
                                  //hintText: "Seat Number",
                                ),
                                onChanged: (sNum) {
                                  //_seatNumber = sNum;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: Text('Department: ')),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                validator: (val) => val.isEmpty ? 'Required Field' : null,
                                controller: _controller6,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue[200])),
                                  //hintText: "Seat Number",
                                ),
                                onChanged: (sNum) {
                                  //_seatNumber = sNum;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: Text('Plant: ')),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                validator: (val) => val.isEmpty ? 'Required Field' : null,
                                controller: _controller7,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue[200])),
                                  //hintText: "Seat Number",
                                ),
                                onChanged: (sNum) {
                                  //_seatNumber = sNum;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: Text('Manager: ')),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                validator: (val) => val.isEmpty ? 'Required Field' : null,
                                controller: _controller8,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue[200]),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue[200])),
                                  //hintText: "Seat Number",
                                ),
                                onChanged: (sNum) {
                                  //_seatNumber = sNum;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      color: Colors.blue[200],
                      onPressed: () async{
                        setState(() {
                          loading = true;
                        });
                        await Firestore.instance.collection('userData').document(uid).updateData({
                          'employeeNumber' : _controller3.text,
                          'firstName' : _controller1.text,
                          'lastName'  : _controller2.text,
                          'barangay' : _controller5.text,
                          'municipality' : _controller4.text,
                          'department' : _controller6.text,
                          'plant' : _controller7.text,
                          'manager' : _controller8.text,
                        });
                        Navigator.pop(context);
                        Toast.show("Updated profile", context,
                                      duration: 5, gravity: Toast.BOTTOM);
                        loading = false;
                      }, 
                      child: Text('Save',style: TextStyle(color: Colors.white))
                    ),
                  ),
                   Container(
                    child: FlatButton(
                      color: Colors.grey[600],
                      onPressed: (){
                        Navigator.pop(context);
                        Toast.show("Discarded changes", context,
                                      duration: 5, gravity: Toast.BOTTOM);
                      }, 
                      child: Text('Discard',style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
