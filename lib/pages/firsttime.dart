import 'package:flutter/material.dart';
import 'package:test/components/buttonbox.dart';
import 'package:test/components/inputbox.dart';

class FirstTime extends StatelessWidget{
  FirstTime({super.key});

  final TextEditingController bankAmount = TextEditingController();
  final TextEditingController maxSpendingDay = TextEditingController();
  final TextEditingController categories = TextEditingController();
  final TextEditingController recuringPayments = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Center(
        child: SizedBox(
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text('Welcome to Lira',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  )
              ),

              const SizedBox(height: 20),
              const Text('Enter your bank amount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
              )),
              InputBox(
                controller: bankAmount,
                hintText: 'ex : 123.45',
                obscureText: false,
                obligatory: true,
                keyboardType: 'number',
              ),

              const SizedBox(height: 20),
              const Text('Enter your max spending per day',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              InputBox(
                controller: TextEditingController(),
                hintText: 'ex : 10',
                obscureText: false,
                obligatory: true,
                keyboardType: 'number',
              ),

              const SizedBox(height: 20),
              const Text('Enter your categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              InputBox(
                controller: TextEditingController(),
                hintText: 'ex : food, rent, etc',
                obscureText: false,
                obligatory: true,
                keyboardType: 'text',
              ),

              const SizedBox(height: 20),
              const Text('Enter your recuring payments',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
              )),
              InputBox(
                controller: recuringPayments,
                hintText: 'ex : rent , water, electricity, etc',
                obscureText: false,
                obligatory: true,
                keyboardType: 'text',
              ),
              
              const SizedBox(height: 20),
              ButtonBox(
                text: 'Submit',
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),

              const SizedBox(height: 30),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Color.fromARGB(255, 150, 40, 40), 
                    size: 16, 
                  ),
                  SizedBox(width: 4), 
                  Text(
                    'Please note that your information are encrypted and stored securely.',
                    style: TextStyle(
                      color: Color.fromARGB(255, 114, 103, 103),
                      fontSize: 10,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}