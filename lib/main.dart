// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test/pages/register.dart';
import 'package:test/pages/home.dart';
import 'package:test/pages/login.dart';
import 'package:test/pages/addpage.dart';
import 'package:test/pages/calendar.dart';
import 'package:test/pages/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(onTap: () => {}),
      routes: {
        '/home': (context) =>  Home(),
        '/register': (context) => Register(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            }
        ),
        '/addpage': (context) => AddPage(),
        '/login': (context) => Login(
            onTap: () {
              Navigator.pushNamed(context, '/register');
            }
        ),
        '/calendar': (context) => Calendar(), 
        '/profile': (context) => Profile(),
      },
    );
  }
}
