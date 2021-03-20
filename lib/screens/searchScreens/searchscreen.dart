import 'package:contacttracer/screens/searchScreens/searchcanteendata.dart';
import 'package:contacttracer/screens/searchScreens/searchlobbydata.dart';
import 'package:contacttracer/screens/searchScreens/searchroomdata.dart';
import 'package:contacttracer/screens/searchScreens/searchshuttledata.dart';
import 'package:contacttracer/screens/searchScreens/searchtriagedata.dart';
import 'package:flutter/material.dart';

int _currentIndex = 0;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Widget> _list = [
    SearchShuttleData(),
    SearchLobbyData(),
    SearchCanteenData(),
    SearchRoomData(),
    SearchTriageData()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('Search'),
      ),
      body: _list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 13,
        unselectedIconTheme: IconThemeData(size: 19),
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue[200],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus,color: Colors.white,),  
            title: Text('Shuttle', style: TextStyle(color: Colors.white),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.domain, color: Colors.white,),  
            title: Text('Lobby', style: TextStyle(color: Colors.white),),    
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store, color: Colors.white,),  
            title: Text('Canteen', style: TextStyle(color: Colors.white),),    
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store, color: Colors.white,),  
            title: Text('Room', style: TextStyle(color: Colors.white),),    
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note, color: Colors.white,),  
            title: Text('Triage', style: TextStyle(color: Colors.white),),    
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      )
    );
  }
}