import 'package:flutter/material.dart';
import 'package:test/components/textbox.dart';

class HowItWorks extends StatelessWidget {
  const HowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 20.0),  // Augmente la hauteur de l'AppBar pour inclure l'espace ajouté
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),  // Ajoute un espace au-dessus de l'AppBar
              child: AppBar(
                title: const Text('How it works', style: TextStyle(color: Colors.white)),
                backgroundColor: const Color.fromARGB(255, 18, 18, 18),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
            ),
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
                      title: 'Privacy and Security',
                      text:'Everything is stored in an online database, so you can access your data from any device. Lira uses Firebase to store your data securely, so you can be sure that your information is safe. We do not share your data with any third parties, and we do not use your data for any other purpose than to help you manage your finances. We cannot see your email or password, so you can be sure that your information is safe and secure.' ,
                      initialFontSize: 18,
                    ),

                    SizedBox(height: 30,),
                    TextBox(
                      title: 'Source Code',
                      text: 'We value your trust so we made the source code of this avaible open and free on GitHub',
                      initialFontSize: 18,
                    ),

                    SizedBox(height: 30,),
                    TextBox(
                      title: 'Credits',
                      text: 'This app is a personal project created by a single student from France.  ',
                      initialFontSize: 18,
                    ),

                    SizedBox(height: 30,),
                    TextBox(
                      title: 'Thank you for using Lira!',
                      text: '',
                      initialFontSize: 18,
                    ),

                    SizedBox(height: 30,),
                  ],
              ),
            )
          ),
        ),
      ),
    );
  }
}