// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Home', style: TextStyle(
              color: Colors.white, // Change the color to blue.
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 18, 18, 18),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 18, 18, 18),
          drawer: Drawer(
              backgroundColor: const Color.fromARGB(255, 64, 64, 64),
              child: const Column(
                children: [
                  
                  DrawerHeader(child: null),

                  ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    onTap: null,
                  ),
                  ListTile(
                    title: Text('Graphs'),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    leading: Icon(Icons.analytics_rounded),
                    onTap: null,
                  ),
                  ListTile(
                    title: Text('Settings'),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    leading: Icon(Icons.settings),
                    onTap: null,
                  ),
                ],
              )
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Month',
          ),
        ],
        unselectedIconTheme: IconThemeData(color: Color.fromARGB(255, 173, 173, 173)),
        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedLabelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(color: Color.fromARGB(255, 173, 173, 173),fontWeight: FontWeight.normal),
      ),
    )
  );
  }
}
