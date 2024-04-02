// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:test/components/inputbox.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
                        title: Text('Month'),
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
          
          //input boxes
          body: Center(
            child: SizedBox(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
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
                    ],
                  ),

                  SizedBox(height: 100),
                  Text(
                    'Daily Progress', 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 20
                    )
                  ),
                  LinearPercentIndicator(
                        width: 350.0,
                        percent: 1.0,
                        lineHeight: 30,
                        center: Text("100%", style: TextStyle(color: Colors.white)),
                        backgroundColor: Color.fromARGB(255, 29, 88, 56),
                        progressColor: Colors.red[900],
                        barRadius: Radius.circular(15),
                  )
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
            label: 'Day',
          ),
        ],
        unselectedIconTheme: IconThemeData(color: Color.fromARGB(255, 173, 173, 173)),
        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedLabelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(color: Color.fromARGB(255, 173, 173, 173),),
      ),
    )
  );
  }
}
