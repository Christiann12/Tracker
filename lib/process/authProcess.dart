import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:contacttracer/models/netConnectionModel.dart';
import 'package:contacttracer/models/userModel.dart';
import 'package:contacttracer/process/databaseProcess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AuthProcess{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userInfo(FirebaseUser user){
    return user != null ? UserModel(user.uid) : null;
  }

  Stream<UserModel> get user{
    return _auth.onAuthStateChanged.map(_userInfo);
  }

  Stream<NetConnectionModel> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged.map(_userConnection);
  }

   NetConnectionModel _userConnection(ConnectivityResult result){
    return result == ConnectivityResult.none ? null : NetConnectionModel(result);
  }

  Future registerEmailAndPassword(String email, String password, String employeeNo, String firstName, String lastName,String barangay,String municipality ,String department,String plant ,String manager, BuildContext context) async{
    try{
      String status = '';
      await Firestore.instance.collection('userData').getDocuments().then((documents){
        for (var i = 0; i < documents.documents.length; i++) {
            if(documents.documents[i]['employeeNumber'] == employeeNo){
              status = 'exists';
            }
        }
      });

      if(status != 'exists'){
        
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // ignore: await_only_futures
      await DatabaseProcess(uid: user.uid).updateUserData(employeeNo,firstName,lastName,email, barangay,municipality,department,plant,manager);
      
      return _userInfo(user);
      }
      else{
        Toast.show('Employee number exists', context,duration:3,gravity:Toast.BOTTOM);
        return null;
      }

    }
    catch(e){
      Toast.show(e.message, context,duration:3,gravity:Toast.BOTTOM);
      return null;
    }
  }
  
  Future signInEmailAndPassword(String email, String password, BuildContext context) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userInfo(user);
    }
    catch(e){
       Toast.show(e.message, context,duration:3,gravity:Toast.BOTTOM);
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return 'error-${e.toString()}';
    }
  }

}