// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallpaper_application/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<String> imageURL = [];


class HomePageNew extends StatefulWidget {
  const HomePageNew({super.key});

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  List data = [];
  bool imageLoadingComplete = false;
  var numberOfItemsInOnePage = 14;
  var pageNumber = 1;
  String uri = 'https://api.unsplash.com/photos/?client_id=DM9hakiNd46KJHlFbiiv8iVqntKzNvrzduWia7ks1LQ&per_page=14';
  String uriBase = 'https://api.unsplash.com/photos/?client_id=DM9hakiNd46KJHlFbiiv8iVqntKzNvrzduWia7ks1LQ&per_page=14';
  String uriPageNumberTemplate = '&page=';
  String uriPageNumber = '';
  

  _getdata() async {
    http.Response response = await http.get(Uri.parse(
        uri));
        //print(uri+uriPageNumber+pageNumber.toString());
    data = json.decode(response.body);
    _assign();
    setState(() {
          imageLoadingComplete = true;
        });
  }

  _assign() {
    for (var i = 0; i < data.length; i++) {
      imageURL.add(data.elementAt(i)['urls']['regular']);
    }
  }

  _tapped(int currentElementIndex) {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) =>
                  ImageFullScreen(index: currentElementIndex))));
    });
  }

  @override
  Widget build(BuildContext context) {
    _getdata();
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: NavigationDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationDrawer(),
                        )),
                    child: Icon(
                      Icons.menu,
                      size: 35,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (() => {}),
                  child: Icon(Icons.settings),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(160, 240, 240, 240),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 192, 192, 192),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 192, 192, 192),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: numberOfItemsInOnePage,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _tapped(index),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: !imageLoadingComplete
                            ? BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/loadingIcon.png')))
                            : BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        imageURL.elementAt(index)))),
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
                      uriPageNumber = uriPageNumberTemplate+pageNumber.toString();
                      uri = (uriBase+uriPageNumber+pageNumber.toString());

                      numberOfItemsInOnePage += 14;
                      pageNumber += 1;
                    },
                  );
                }),
                child: Text("Load More"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            // leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            // leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            // leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            // leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            // leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
    ;
  }
}

class ImageFullScreen extends StatelessWidget {
  int index;
  ImageFullScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(imageURL.elementAt(index)))),
    );
  }
}
