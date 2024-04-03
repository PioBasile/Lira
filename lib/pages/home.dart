

import 'package:flutter/material.dart';
import 'package:test/pages/addpage.dart';
import 'package:test/pages/daypage.dart';


class Home extends StatefulWidget {
    
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _pages = [
    AddPage(),
    const DayPage(),
  ];

  int _pageindex = 0;

  void _changePageIndex(int index) {
    setState(() {
      _pageindex = index;
    });
  }

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

          body: _pages[_pageindex],

          backgroundColor: const Color.fromARGB(255, 18, 18, 18),
          drawer: const Drawer(
              backgroundColor: Color.fromARGB(255, 54, 53, 53),
              child: Column(
                children: [
                  
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        SizedBox(height: 50),
                        DrawerHeader(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('lib/images/LIRA Logo - Transparent Background No Slogans- cropped.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: null,
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        title: Text('Home'),
                        leading: Icon(Icons.home),
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        onTap: null,
                      ),

                      SizedBox(height: 10),
                      ListTile(
                        title: Text('Calendar'),
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        leading: Icon(Icons.calendar_view_month_rounded),
                        onTap: null,
                      ),

                      SizedBox(height: 10),
                      ListTile(
                        title: Text('Graphs'),
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        leading: Icon(Icons.analytics_rounded),
                        onTap: null,
                      ),
                      
                      SizedBox(height: 10),
                      ListTile(
                        title: Text('Profile'),
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        leading: Icon(Icons.person_outlined),
                        onTap: null,
                      ),

                      SizedBox(height: 10),
                      ListTile(
                        title: Text('Settings'),
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        leading: Icon(Icons.settings),
                        onTap: null,
                      ),
                    ],
                )
              ]
            )
          ),
        
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageindex,
        onTap: _changePageIndex,
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Day',
          ),
        ],
        unselectedIconTheme: const IconThemeData(color: Color.fromARGB(255, 173, 173, 173)),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedLabelStyle: const TextStyle(color:  Colors.white,fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 173, 173, 173),),
      ),
    )
  );
  }
}
