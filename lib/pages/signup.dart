// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class Signup extends StatelessWidget {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Signup', style: TextStyle(
            color: Colors.white,
            ),),
          backgroundColor: const Color.fromARGB(255, 18, 18, 18),
          elevation: 0,
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),

      ),
    );
  }
}
