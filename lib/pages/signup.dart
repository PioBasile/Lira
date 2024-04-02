// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Signup Page'),
          backgroundColor: const Color.fromARGB(255, 75, 75, 75),
          elevation: 0,
        ),
      ),
    );
  }
}
