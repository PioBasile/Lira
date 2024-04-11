import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:test/components/buttonbox.dart';
import 'package:test/components/inputbox.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Payed extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  Payed({super.key});

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
              const SizedBox(height: 20),
              const Text('Amount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              
              InputBox(
                controller: amountController,
                hintText: '...',
                obscureText: false,
                obligatory: true,
                keyboardType: 'number',
              ),
              const SizedBox(height: 20),
              const Text('Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              InputBox(
                controller: descriptionController,
                hintText: 'Optional but recommended',
                obscureText: false,
                obligatory: false,
                keyboardType: 'text',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Date',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        InputBox(
                          controller: dateController,
                          hintText: 'Day/Month/Year',
                          obscureText: false,
                          obligatory: true,
                          keyboardType: 'number',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Time',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        InputBox(
                          controller: timeController,
                          hintText: 'Hour:Minute',
                          obscureText: false,
                          obligatory: false,
                          keyboardType: 'number',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              InputBox(
                controller: categoryController,
                hintText: 'Select category',
                obscureText: false,
                obligatory: true,
              ),

              const SizedBox(height: 20),
              
              Center(
                child : ButtonBox(
                text: "Add",
                onTap: () {},
                )
              ),

              const SizedBox(height: 20),
              const Padding(
                padding:  EdgeInsets.only(left: 13.0),
                child:  Text('Daily Progress',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              LinearPercentIndicator(
                width: 350.0,
                percent: 1.0,
                lineHeight: 30,
                center:
                    const Text("100%", style: TextStyle(color: Colors.white)),
                backgroundColor: const Color.fromARGB(255, 29, 88, 56),
                progressColor: Colors.red[900],
                barRadius: const Radius.circular(15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
