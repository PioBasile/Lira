import 'package:flutter/material.dart';
import 'package:test/pages/categorypage.dart';
import 'package:test/pages/infopage.dart';

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _pageindex = 0;

  void _changePageIndex(int index) {
    setState(() {
      _pageindex = index;
    });
  }

  final List _pages = [
    Info(),
    const Category(),
  ];

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(
          color: Colors.white, // Change the color to blue.
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: _pages[_pageindex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageindex,
        onTap: _changePageIndex,
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info_rounded),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded),
            label: 'Category',
          ),
        ],
        unselectedIconTheme: const IconThemeData(color:  Color.fromARGB(255, 134, 132, 132),),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 134, 132, 132),
      ), 
    );
  }
}