// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test/pages/signup.dart';
import 'package:test/pages/home.dart';
import 'package:test/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        '/home': (context) =>  Home(),
        '/signup': (context) => Signup(),
        '/login': (context) => Login(),
      },
    );
  }
}
