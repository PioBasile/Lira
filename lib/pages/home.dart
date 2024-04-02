// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test/components/inputbox.dart';

class Home extends StatelessWidget {
  
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  
  Home({super.key});

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
                  
                  Center(
                    child:
                      DrawerHeader(child: Text("Lira", style: TextStyle(
                        color: Colors.white,
                        fontSize:40 ,
                        fontWeight: FontWeight.bold,
                        ),
                      )
                    ),
                  ),

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
                    title: Text('Profile'),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    leading: Icon(Icons.person_outlined),
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
          
          //input boxes
          body: Center(
            child: SizedBox(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 75),
                  Text('Amount', style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
                  InputBox(
                    controller: amountController,
                    hintText: '...',
                    obscureText: false,
                    obligatory: true,
                  ),


                  SizedBox(height: 40),
                  Text('Description', style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
                  InputBox(
                    controller: descriptionController,
                    hintText: 'Optional but recommended',
                    obscureText: false,
                    obligatory: false,
                  ),

                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date', style: TextStyle(color: Colors.white, fontSize: 20)),
                            InputBox(
                              controller: dateController,
                              hintText: 'Day/Month/Year',
                              obscureText: false,
                              obligatory: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20), 
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Time', style: TextStyle(color: Colors.white, fontSize: 20)),
                            InputBox(
                              controller: timeController,
                              hintText: 'Hour:Minute',
                              obscureText: false,
                              obligatory: true,
                            ),
                          ],
                        ),
                      ),
                      
                      //add like a pourcentage bar to see how much
                      //money you have spent in the day in accordance to
                      //how much u specified u wanted to use

                    ],
                  ),
                ],
              ),
            ),
          ),


          
          

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
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
