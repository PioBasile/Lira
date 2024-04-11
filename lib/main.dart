import 'package:flutter/material.dart';
import 'package:test/pages/register.dart';
import 'package:test/pages/home.dart';
import 'package:test/pages/login.dart';
import 'package:test/pages/payed.dart';
import 'package:test/pages/calendar.dart';
import 'package:test/pages/profile.dart';
import 'package:test/pages/graph.dart';

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
        '/home': (context) =>  const Home(),
        '/register': (context) => Register(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            }
        ),
        '/addpage': (context) => Payed(),
        '/login': (context) => Login(
            onTap: () {
              Navigator.pushNamed(context, '/register');
            }
        ),
        '/calendar': (context) => const Calendar(), 
        '/profile': (context) => const Profile(),
        '/graph': (context) => Graph(),
      },
    );
  }
}
