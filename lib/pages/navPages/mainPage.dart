import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soilpedia_lk/pages/navPages/camTest.dart';
import 'package:soilpedia_lk/pages/navPages/gallery.dart';
import 'package:soilpedia_lk/pages/homePage.dart';

import '../detailsPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage1(),
    CameraPage(),
    GalleryPage(),
    detailsPage(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.green.shade700,
        unselectedItemColor: Colors.blue,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            label: ("Home"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(label: ("Scan"), icon: Icon(Icons.camera)),
          BottomNavigationBarItem(
              label: ("Import"), icon: Icon(Icons.photo_library_rounded)),
          BottomNavigationBarItem(
              label: ("Details"), icon: Icon(Icons.park_outlined)),
        ],
      ),
    );
  }
}
