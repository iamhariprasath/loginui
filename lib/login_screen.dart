import 'package:flutter/material.dart';
import 'package:lastlogin/colors.dart';
import 'package:lastlogin/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lastlogin/newacc.dart';

import 'constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

GlobalKey<FormState> formkey = GlobalKey<FormState>();
String? _email;
String?_password;

void signIn(BuildContext context) async {
  if (_email != null && _password != null) {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email!, password: _password!)
        .then((authUser) {
      if(authUser.user!=null);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }).catchError((onError) {
      print(onError);
    });
  } else {
    print("Email and password cannot be null");
  }
}



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () =>FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                  Image.asset(
                  bgimage,
                height: height * 0.40,
                width: width,
                fit: BoxFit.cover,
               ),
               Container(
                height: height * 0.45,
                width:width,
                // color: Colors.blue.withOpacity(0.3),
                decoration:BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.3,0.8],
                    begin:Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                    Colors.transparent,
                    Colors.white
                   ] )
                ) ,
                ),
                
                ],
            
                ),
               
              Align(
                alignment: Alignment.center,
                child: Text(appName,
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700)),
              ),
            Align(
              alignment: Alignment.center,
              child: Text(slogan,style: TextStyle(color: Colors.grey))),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,top: 30),
              child: Container(
                child: Text("  $Loginname  ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primarycolor.withOpacity(0.3),Colors.transparent],
                     ),
                     border: Border(left: BorderSide(color: primarycolor,width: 5))
                ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
              child: TextFormField(
                onSaved: (value){
                  _email = value;
                },
                validator: (email) {
          if (email == null || email.isEmpty) {
            return "Please Enter Email";
          } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
            return "Please Enter a Valid Email";
          }
          return null; 
        },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primarycolor)
                ),
                prefixIcon: Icon(Icons.email,
                color: primarycolor),
                labelStyle: TextStyle(color: primarycolor),
                labelText: "EMAIL ADDRESS" 
              
              ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
              child: TextFormField(
                onSaved: (value){
                  _password = value;
                 },
                validator: (password){
                  if(password==null || password.isEmpty){
                    return"Please Enter the Password";
                  }
                  else if (password.length < 8 || password.length > 10)
                  return "Password length is Incorrect";
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primarycolor)
                ),
                prefixIcon: Icon(Icons.lock_open,
                color: primarycolor),
                labelStyle: TextStyle(color: primarycolor),
                labelText: "PASSWORD" 
              
              ),),
            ),
            
                Align(
            alignment: Alignment.centerRight,
            
            child: TextButton(onPressed:() {}, child: Text("Forget Password ?",style: TextStyle(color: primarycolor)))),
            Center(
            
              child: SizedBox(
                height: height*0.08,
                width: width-30,
                child: TextButton(
                  onPressed:() async {
                    if(formkey.currentState?.validate() ?? false){
                      formkey.currentState?.save();
                      signIn(context);
                     
                      // if(_email == "test@gmail.com" && _password == "root@123"){
                        
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(),),);
                      //   FocusScope.of(context).unfocus();
                      // }
                      // else{
                      //   print("Invalid Login Details");
                      // }
                    }
                  }, child:Text("Login to account",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,fontSize: 22
                  ),
                  ),
                  style: TextButton.styleFrom(backgroundColor: primarycolor,shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )),))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text("Don't have an account?"),
                  TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccount()));}, child: Text("Create Account",style: TextStyle(
                    color:Colors.blue,fontSize: 16
                  ),))
                    ],
                  )
                 
            ]
                ,
            ),
          ),
        ),
      ),
    );
  }
}