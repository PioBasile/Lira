import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String title;  
  final String text;   
  final double initialFontSize;

  const TextBox({
    super.key,
    required this.title,
    required this.text,
    this.initialFontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, 
            style: TextStyle(
              fontSize: initialFontSize + 4, 
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 3), 
          Divider(
            color: Colors.grey[700], 
            thickness: 2,
          ),
          const SizedBox(height: 3),
          SingleChildScrollView(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: initialFontSize,
                color: Colors.white,
                height: 1.5,  
                backgroundColor: const Color.fromARGB(255, 18, 18, 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
