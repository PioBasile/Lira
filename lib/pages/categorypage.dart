import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      body: Center(
          child: SizedBox(
            child: Column(
              children: [
                SizedBox(height: 0),
                Text(
                  "Category",
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
          ),
    );
  }
}