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
      body: const SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 350,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    TextBox(
                      title: 'General Description',
                      text: 'Lira is a budgeting app that helps you keep track of your finances. You can set your salary, the amount you want to spend per day, and the amount you have in your bank account. Lira will help you keep track of your daily spending and show you how much you have left to spend each day.',
                      initialFontSize: 18, 
                      
                    ),
                    
                    SizedBox(height: 30,),
                    TextBox(
                      title: 'Recurring Expenses',
                      text: 'You can also set a recurring expense, such as rent or utilities, and Lira will automatically deduct that amount from your bank account each month. Lira will also show you how much you have left to spend each day after deducting your recurring expenses.',
                      initialFontSize: 18,
                    ),
              
                    SizedBox(height: 30,),
                    TextBox(
                      title: 'Categories and Calendar',
                      text: 'Lira will also show you a graph of your spending over time, so you can see how your spending habits change from month to month. You can also categorize your expenses and view them on a calendar to see how much you spend each day.',
                      initialFontSize: 18,
                    ),

                    SizedBox(height: 30,),
                    TextBox(
                      title: 'How do we stock and manipulate your data?',
                      text:'' ,
                      initialFontSize: 18,
                    )
                  ],
              ),
            )
          ),
        ),
      ),
    );
  }
}