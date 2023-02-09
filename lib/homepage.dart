// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<String> imgurl = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];
  // List<String> imgurl = [];
  bool showimg = false;
  static int index1 = 0;

  getdata() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.unsplash.com/photos/?client_id=DM9hakiNd46KJHlFbiiv8iVqntKzNvrzduWia7ks1LQ&per_page=200'));
    data = json.decode(response.body);
    assign();
    setState(() {
      showimg = true;
    });
  }

  assign() {
    for (var i = 0; i < data.length; i++) {
      imgurl.add(data.elementAt(i)['urls']['regular']);
    }
  }

  tapped(int Index) {
    print(Index);
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => ImageFullScreen(index: Index))));
    });
  }

  var ctr = 10;

  @override
  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                    child: Text(
                      "Wallpapers",
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 181, 208, 255),
                    maxRadius: 35,
                  ),
                )
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: ctr,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => tapped(index),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 150,
                        // width: 150,
                        decoration: !showimg
                            ? BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/loadingIcon.png')))
                            : BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(imgurl.elementAt(index)))),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: TextButton(
                onPressed: (() {
                  setState(
                    () {
                      ctr = ctr + 20;
                    },
                  );
                }),
                child: Text("Load More"),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: "Home",

      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: "Search",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.trending_up),
      //       label: "Trending",
      //     ),
      //   ],
      // ),
    );
  }
}

class ImageFullScreen extends StatelessWidget {
  int index;
  ImageFullScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    print(index);
    return Container(
      decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(imgurl.elementAt(index)))),
    );
  }
}
