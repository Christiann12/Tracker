import 'package:contacttracer/Widgets/loadingWidget.dart';
import 'package:contacttracer/process/authProcess.dart';
import 'package:flutter/material.dart';

TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
TextEditingController controller3 = TextEditingController();
TextEditingController controller4 = TextEditingController();
TextEditingController controller5 = TextEditingController();
TextEditingController controller6 = TextEditingController();
TextEditingController controller7 = TextEditingController();
TextEditingController controller8 = TextEditingController();
TextEditingController controller9 = TextEditingController();
TextEditingController controller10 = TextEditingController();
TextEditingController controller11 = TextEditingController();
AuthProcess _auth = AuthProcess();

class RegisterUi extends StatefulWidget {
  @override
   RegisterUiState createState() =>  RegisterUiState();
}

class  RegisterUiState extends State <RegisterUi> {

  String employeeNo = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String barangay = '';
  String municipality = '';
  String department = '';
  String plant = '';
  String manager = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading == true? Loading():Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('Register'),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                      ),
                      children: <TextSpan>[
                        TextSpan(text:'Registration: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Make sure to complete the form and double check the informations entered.')
                      ]
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter your employee number' : null,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  controller: controller1,
                  decoration: InputDecoration(
                    counterText: '',
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[200]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[200]),
                    ),
                    border:
                        OutlineInputBorder(borderSide: BorderSide(color: Colors.blue[200])),
                    hintText: "Employee Number",
                  ),

                  onChanged: (val){
                    setState(() {
                      employeeNo = val;
                    });
                  },
                ),

                SizedBox(height: 20,),
              
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter your First name' : null,
                  controller: controller2,
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
                    hintText: "First Name",
                  ),

                  onChanged: (val){
                    setState(() {
                      firstName = val;
                    });
                  },
                ),

                SizedBox(height: 20,),
                
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter your Last name' : null,
                  controller: controller3,
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
                    hintText: "Last Name",
                  ),

                  onChanged: (val){
                    setState(() {
                      lastName = val;
                    });
                  },
                ),

                SizedBox(height: 20,),

                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter your Barangay' : null,
                  controller: controller4,
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
                    hintText: "Barangay",
                  ),

                  onChanged: (val){
                    setState(() {
                      barangay = val;
                    });
                  },
                ),

                SizedBox(height: 20,),

                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter your municipality' : null,
                  controller: controller5,
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
                    hintText: "Municipality",
                  ),

                  onChanged: (val){
                    setState(() {
                      municipality = val;
                    });
                  },
                ),

                SizedBox(height: 20,),

                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter your Department' : null,
                  controller: controller6,
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
                    hintText: "Department",
                  ),

                  onChanged: (val){
                    setState(() {
                      department = val;
                    });
                  },
                ),
                
                SizedBox(height: 20,),

                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter your Plant' : null,
                  controller: controller7,
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
                    hintText: "Plant",
                  ),

                  onChanged: (val){
                    setState(() {
                      plant = val;
                    });
                  },
                ),
     
                SizedBox(height: 20,),

                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter your Manager/Supervisor' : null,
                  controller: controller8,
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
                    hintText: "Manager/Supervisor",
                  ),

                  onChanged: (val){
                    setState(() {
                      manager = val;
                    });
                  },
                ),
                
                SizedBox(height: 20,),

                TextFormField( 
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  controller: controller9,

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
                  validator: (val) => val.length < 6 ? 'Enter a password with 6 characters' : null,
                    controller: controller10,
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

                TextFormField(
                  validator: (val) => val.isEmpty || val != password  ? 'Password do not match' : null,
                    controller: controller11,
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
                    hintText: "Retype Password",
                  ),

                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      
                    });
                  },
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 50),
                  child: FlatButton(
                    color: Colors.blue[200],
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        String finalEmail = '';
                      for(int i = 0; i <= email.length-1; i++){
                        if(email[i] == ' '){
                          continue;
                        }
                        else{
                          finalEmail = '$finalEmail${email[i]}';
                        }
                      }
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.registerEmailAndPassword(finalEmail, password, employeeNo, firstName , lastName, barangay,municipality,department,plant,manager,context);
                      
                        if(result == null){
                          
                          setState(() {
                            loading = false;
                          });
                        }
                        else{
                          Navigator.pop(context);
                          loading = false;
                        }
                      }
                    },
                    child: Center(child: Text('Register',style: TextStyle(color: Colors.white),)),
                  ),
                ),

              ],
            ),
          ),
        ],
      )
    );
  }
}