import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:contacttracer/process/authProcess.dart';
import 'package:contacttracer/screens/homescreens/editprofile.dart';
import 'package:contacttracer/screens/homescreens/manualinput.dart';
import 'package:contacttracer/screens/homescreens/qrscanner.dart';
import 'package:contacttracer/screens/searchScreens/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:provider/provider.dart';

AuthProcess _auth = AuthProcess();

bool loading = false;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<UserModel>(context).uid.toString();
    return loading == true? Loading() :Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container( 
                      height: 230,
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80.0),
                          bottomRight: Radius.circular(80.0)),
                        color: Colors.blue[200],
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 12,
                      child: Text('Automatic triage', style: TextStyle(fontSize: 24, color: Colors.white,fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      top: 67,
                      right: 12,
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          await _auth.signOut();
                          loading = false;
                        },
                        child: Text('Logout', style: TextStyle(fontSize: 15, color: Colors.white))
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5, top: 120),
                      child: Opacity(
                        opacity: 0.9,
                        child: Container(
                          child: StreamBuilder(
                            stream: Firestore.instance
                                .collection('userData')
                                .where('uid', isEqualTo: uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) return Loading();
                              return Card(
                                elevation: 6,
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: Text(
                                            '${snapshot.data.documents[0]['firstName']} ${snapshot.data.documents[0]['lastName']}',
                                            style: TextStyle(fontSize: 25,fontFamily: 'Abel',fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(LineariconsFree.pencil,size: 18,), 
                                          onPressed: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => EditProfile()),
                                            );
                                          }
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Text(
                                        'Employee Number: ${snapshot.data.documents[0]['employeeNumber']}',
                                        style: TextStyle(fontSize: 14,fontFamily: 'Abel'),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Text(
                                        'Department: ${snapshot.data.documents[0]['department']}',
                                        style: TextStyle(fontSize: 14,fontFamily: 'Abel'),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Text(
                                        'Plant: ${snapshot.data.documents[0]['plant']}',
                                        style: TextStyle(fontSize: 14,fontFamily: 'Abel'),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Text(
                                        'Manager: ${snapshot.data.documents[0]['manager']}',
                                        style: TextStyle(fontSize: 14,fontFamily: 'Abel'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManualInput()),
                            );
                        },
                        child: Card(
                          
                          elevation: 6,
                          color: Colors.blue[200],
                          child:Container(

                            height: 50,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal:10),
                                      child: Text('Go to Manual mode', style: TextStyle(fontSize: 18, color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Entypo.right_open_mini,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ),
                      ),
                      Center(
                        child: FlatButton(
                          color: Colors.blue[200],
                          onPressed: (){
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen()),
                            );
                            //print(Provider.of<NetConnectionModel>(context).connection);
                          }, 
                          child: Text('Search', style: TextStyle(color: Colors.white),)
                      ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  //color: Colors.blue,
                  height:90,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        //color: Colors.blue[200],
                        height: 50,
                      ),
                      Positioned(
                        top: 0,
                        
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QrScanner()),
                            );
                          },
                          child: CircleAvatar(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[300],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Elusive.qrcode,),
                                Text('Scan Qr', style: TextStyle(fontSize: 10))
                              ],
                            ),
                            radius: 40,
                          ),
                        )
                      )
                    ],
                  ),
                )
              ],
            )
          )
        ], 
      ),
    );
  }
}
