import 'package:contacttracer/screens/offlinemode/offlineCanteen.dart';
import 'package:contacttracer/screens/offlinemode/offlineLobby.dart';
import 'package:contacttracer/screens/offlinemode/offlineRoom.dart';
import 'package:contacttracer/screens/offlinemode/offlineShuttle.dart';
import 'package:flutter/material.dart';



class OfflineModeScreen extends StatefulWidget {
  @override
  _OfflineModeScreenState createState() => _OfflineModeScreenState();
}

class _OfflineModeScreenState extends State<OfflineModeScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[200], title: Text('Offline mode')),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue[200],
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (_) => OfflineShuttle()));
                }, 
                child: Center(child: Text('Shuttle', style: TextStyle(color: Colors.white)))
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue[200],
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (_) => OffllineLobby()));
                }, 
                child: Center(child: Text('Lobby', style: TextStyle(color: Colors.white)))
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue[200],
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (_) => OfflineRoom()));
                }, 
                child: Center(child: Text('Conference Room', style: TextStyle(color: Colors.white)))
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.blue[200],
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (_) => OfflineCanteenInput()));
                }, 
                child: Center(child: Text('Canteen', style: TextStyle(color: Colors.white)))
              ),
            )
          ],
        )
      ),
    );
  }
}
