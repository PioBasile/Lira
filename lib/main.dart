// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test/pages/register.dart';
import 'package:test/pages/home.dart';
import 'package:test/pages/login.dart';
import 'package:test/pages/addpage.dart';

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
        '/register': (context) => Register(),
        '/addpage': (context) => AddPage(),
        '/login': (context) => Login(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            }
        ),
            
      },
    );
  }
}
