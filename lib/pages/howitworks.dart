import 'package:flutter/material.dart';
import 'package:test/components/textbox.dart';

class HowItWorks extends StatelessWidget {
  const HowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        title: const Text(
          'How it works',
          style: TextStyle(
            color: Colors.white, 
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: SizedBox(
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, 
              children: [
                TextBox(
                  text: 'WHERE IS MYYYY TEXTTT',
                  initialFontSize: 20,
                ),
              ],
          )
        ),
      ),
    );
  }
}