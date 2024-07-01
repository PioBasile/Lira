import 'package:flutter/material.dart';
import 'package:lira/components/buttonbox.dart';
import 'package:lira/components/inputbox.dart';
import 'package:lira/services/database/db_manip.dart';

class FirstTime extends StatefulWidget {
  const FirstTime({super.key});

  @override
  State<FirstTime> createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  final TextEditingController bankAmountController = TextEditingController();
  final TextEditingController maxSpendingDayController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  List<String> categories = [];
  List<Map<String, dynamic>> recurringPayments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text('Welcome to Lira',
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
                'Fill in the information below to get started. You can change these details later in your profile settings.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                )),
            const SizedBox(height: 20),
            InputBox(
              controller: bankAmountController,
              hintText: 'Enter your bank amount',
              obscureText: false,
              obligatory: true,
              keyboardType: "number",
            ),
            const SizedBox(height: 20),
            InputBox(
              controller: salaryController,
              hintText: 'Enter your salary',
              obscureText: false,
              obligatory: true,
              keyboardType: "number",
            ),
            const SizedBox(height: 20),
            InputBox(
              controller: maxSpendingDayController,
              hintText: 'Enter your max spending per day',
              obscureText: false,
              obligatory: true,
              keyboardType: "number",
            ),
            const SizedBox(height: 20),
            const Text(
                'We strongly encourage you to go to the profile page to add recurring payments and categories ',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                )),
            const SizedBox(height: 30),
            ButtonBox(
              text: 'Submit',
              onTap: () {
                saveInfo();
                Navigator.pushNamed(context, '/home');
              },
            ),
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info, color: Color.fromARGB(255, 113, 20, 20)),
                Text(
                  'All your data is safe and secure.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveInfo() {
    if (bankAmountController.text.trim().isEmpty ||
        maxSpendingDayController.text.trim().isEmpty ||
        salaryController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not all fields were filled in')),
      );
      return;
    }

    try {
      double bankAmount = double.parse(bankAmountController.text.trim().replaceAll(' ', ''));
      double maxSpendingDay = double.parse(maxSpendingDayController.text.trim().replaceAll(' ', ''));
      double salary = double.parse(salaryController.text.trim().replaceAll(' ', ''));

      FireStoreService().createInfo(salary, maxSpendingDay, bankAmount);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numbers')),
      );
    }
  }
}
