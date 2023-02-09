// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_application/homepage.dart';
import 'package:wallpaper_application/homepagenew.dart';
import 'package:wallpaper_application/register.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailcontrol = TextEditingController();
  final TextEditingController _passwordcontrol = TextEditingController();
  String? _username;
  int _success = 1;

  void _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailcontrol.text, password: _passwordcontrol.text);
          final User? user = (await _auth.signInWithEmailAndPassword(
            email: _emailcontrol.text, password: _passwordcontrol.text))
        .user;

      if (user != null) {
        setState(() {
          _success = 2;
          _username = user.email;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: ((context) => HomePageNew()),
              ),
              (route) => false);
        });
      } 
    } on FirebaseAuthException catch (e) {
      showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context));
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.yellow,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
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
                      "It's been a while hasn't it?",
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 235, 235, 235),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: TextField(
                          controller: _emailcontrol,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Username or Email ID',
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
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 235, 235, 235),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: TextField(
                        controller: _passwordcontrol,
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
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: (() => {_login()}),
                            child: Text("Log in"),
                            style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.indigo,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 20)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member?",
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
                                        builder: ((context) => Register())))
                              }),
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
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

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: Text('Sign In failed'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Please check your credentials and try agin"),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
