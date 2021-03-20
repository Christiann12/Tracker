import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/process/authProcess.dart';
import 'package:contacttracer/screens/offlinemode/offlinemodescreen.dart';
import 'package:contacttracer/screens/registerUI.dart';
import 'package:flutter/material.dart';

AuthProcess _auth = AuthProcess();

class LoginUi extends StatefulWidget {
  @override
   LoginUiState createState() =>  LoginUiState();
}

class  LoginUiState extends State <LoginUi> {

  String email = '';
  String password = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  //  @override
  // void initState() {
  //   OfflineCanteenInput offlineCanteenInput = OfflineCanteenInput();
  //     offlineCanteenInput.doSomeUpdate();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return loading == true? Loading() :Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[

              SizedBox(height: 30,),
              
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,

                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[200]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[200]),
                  ),
                  border:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[200])),
                  hintText: "Email",
                ),

                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),

              SizedBox(height: 20,),

              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter a password' : null,

                 decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[200]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[200]),
                  ),
                  border:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[200])),
                  hintText: "Password",
                ),

                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),

              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 50),
                child: FlatButton(
                  color: Colors.blue[200],
                  onPressed: () async{
                    if(_formKey.currentState.validate()) {
                      String finalEmail = '';
                      for(int i = 0; i <= email.length-1; i++){
                        if(email[i] == ' '){
                          continue;
                        }
                        else{
                          finalEmail = '$finalEmail${email[i]}';
                        }
                      }
                      //print(finalEmail);
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInEmailAndPassword(finalEmail, password,context);
                      if(result == null){

                        setState(() {
                          loading = false;
                        });
                      }
                    }
                  },
                  child: Center(child: Text('Login',style: TextStyle(color: Colors.white),)),
                ),
              ),
              
              SizedBox(height: 20,),

              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (_) => RegisterUi()));
                },
                child: Text('Sign up here',style: TextStyle(decoration: TextDecoration.underline,),)
              ),

               SizedBox(height: 20,),

              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (_) => OfflineModeScreen()));
                },
                child: Text('Continue to offline mode',style: TextStyle(decoration: TextDecoration.underline,),)
              ),
            ],
          ),
        )
      )
    );
  }
}