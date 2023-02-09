// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:wallpaper_application/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailcontrol = TextEditingController();
  final TextEditingController _unamecontrol = TextEditingController();
  final TextEditingController _passwordcontrol1 = TextEditingController();
  final TextEditingController _passwordcontrol2 = TextEditingController();
  late bool _success;
  late String? _username;

  void _register() async {
    if (_passwordcontrol1.text == _passwordcontrol2.text) {
      final User? user = (await _auth.createUserWithEmailAndPassword(
              email: _emailcontrol.text, password: _passwordcontrol1.text))
          .user;

      if (user != null) {
        setState(() {
          _success = true;
          _username = user.email;
        });
      } else {
        setState(() {
          _success = false;
          print("Sign up Failed");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Color.fromARGB(255, 199, 199, 199),
            ],
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New Registration",
                      style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Please enter information in the fields below",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Quicksand',
                          color: Colors.black54,
                          letterSpacing: 2.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 235, 235, 235),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: TextField(
                          controller: _emailcontrol,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Email Address',
                            suffixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 235, 235, 235),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: TextField(
                          controller: _unamecontrol,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Username',
                            suffixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 235, 235, 235),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: TextField(
                          controller: _passwordcontrol1,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Password',
                            suffixIcon: Icon(
                              Icons.password,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 235, 235, 235),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: TextField(
                          controller: _passwordcontrol2,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Confirm Password',
                            suffixIcon: Icon(
                              Icons.password,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: (() => {_register()}),
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.indigo,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 20)),
                            child: Text("Sign Up"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already a member?",
                          style: TextStyle(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          onPressed: (() => {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Login())))
                              }),
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
