import 'package:flutter/material.dart';
import 'package:wallpaper_application/login.dart';
import 'package:wallpaper_application/register.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/loginbg.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.665,
              ),
              Text(
                "Hey There!",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 55,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  // color: Color.fromARGB(224, 255, 169, 219),
                ),
              ),
              Text(
                "Let's get started",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: TextButton(
                        onPressed: (() => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Login())))
                            }),
                        child: Text(
                          "Log in",
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'Opensans'),
                        ),
                        style: TextButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Color.fromARGB(255, 255, 209, 224),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 20)),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: TextButton(
                        onPressed: (() => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Register())))
                            }),
                        child: Text("Sign Up",
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Opensans')),
                        style: TextButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Color.fromARGB(255, 255, 209, 224),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 20)),
                      ),
                    ),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //             child: TextButton(
              //               onPressed: (() => {Navigator.push(context, MaterialPageRoute(builder: ((context) => Login())))}),
              //               child: Text("Log in"),
              //               style: TextButton.styleFrom(
              //                 primary: Colors.black,
              //                 backgroundColor: Color.fromARGB(255, 255, 209, 224),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(20)
              //                 ),
              //                 padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20)
              //               ),
              //             ),
              //           ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //             child: TextButton(
              //               onPressed: (() => {Navigator.push(context, MaterialPageRoute(builder: ((context) => Register())))}),
              //               child: Text("Sign Up"),
              //               style: TextButton.styleFrom(
              //                 primary: Colors.black,
              //                 backgroundColor: Color.fromARGB(255, 255, 209, 224),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(20)
              //                 ),
              //                 padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20)
              //               ),
              //             ),
              //           ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
