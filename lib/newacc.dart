import 'package:flutter/material.dart';
import 'package:lastlogin/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController mailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  registration(BuildContext context) async {
    String email = mailcontroller.text;
    String password = passwordcontroller.text;
    String name = namecontroller.text;

    if (password.isNotEmpty && name.isNotEmpty && email.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
            String? userId = userCredential.user?.uid;
  print('Registered User ID: $userId');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registered Successfully", style: TextStyle(fontSize: 20.0))));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen(),),);  // Assuming Home is your home screen
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: const Color.fromARGB(255, 64, 185, 255),
              content: Text("Password Provided is too Weak", style: TextStyle(fontSize: 18.0))));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: const Color.fromARGB(255, 64, 185, 255),
              content: Text("Account Already exists", style: TextStyle(fontSize: 18.0))));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please fill in all fields", style: TextStyle(fontSize: 18.0))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  // Name Field
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      controller: namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                          hintStyle: TextStyle(color: Color(0xFF0091EA), fontSize: 18.0)),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // Email Field
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      controller: mailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(color: Color(0xFF0091EA), fontSize: 18.0)),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // Password Field
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      controller: passwordcontroller,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(color: Color(0xFF0091EA), fontSize: 18.0)),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // SignUp Button
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState?.validate() ?? false) {
                        registration(context);
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: Color(0xFF0091EA),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w500),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            // LogIn Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(color: Color(0xFF8c8e98), fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "LogIn",
                    style: TextStyle(color: Color(0xFF0091EA), fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}