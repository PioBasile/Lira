import 'package:flutter/material.dart';

class DayPage extends StatelessWidget {
  const DayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      body: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                "Day",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 0),
              SizedBox(height: 25),
            ],
          ),
          ),
    );
  }
}
