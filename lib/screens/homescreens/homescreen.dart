import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/screens/homescreens/mainscreen.dart';
import 'package:flutter/material.dart';



bool loading = false;

   
class Homescreen extends StatefulWidget {

  void reset() {
  }

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  
  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Loading()
        : Scaffold(
            // appBar: AppBar(
            //     backgroundColor: Colors.blue[200],
            //     actions: <Widget>[
            //       FlatButton(
            //           onPressed: () async {
            //             setState(() {
            //               loading = true;
            //             });
            //             await _auth.signOut();
            //             loading = false;
            //           },
            //           child: Text(
            //             'Logout',
            //             style: TextStyle(color: Colors.white),
            //           ))
            //     ],
            //     title: Text('Automated Triage')),
            body: MainScreen()
    );
  }
}
