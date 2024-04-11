import 'package:flutter/material.dart';
import 'package:test/components/inputbox.dart';
import 'package:test/components/buttonbox.dart';


class Received extends StatelessWidget {
  final TextEditingController amountRController = TextEditingController();
  final TextEditingController dateRController = TextEditingController();
  final TextEditingController timeRController = TextEditingController();
  final TextEditingController descriptionRController = TextEditingController();
  final TextEditingController personRController = TextEditingController();

  Received({super.key});

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
                controller: amountRController,
                hintText: '...',
                obscureText: false,
                obligatory: true,
                keyboardType: 'number',
              ),

              const SizedBox(height: 20),
              const Text('From whom?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              InputBox(
                controller: personRController,
                hintText: 'Name or nickname',
                obscureText: false,
                obligatory: true,
              ),

              const SizedBox(height: 20),
              const Text('Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              InputBox(
                controller: descriptionRController,
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
                          controller: dateRController,
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
                          controller: timeRController,
                          hintText: 'Hour:Minute',
                          obscureText: false,
                          obligatory: true,
                          keyboardType: 'number',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Center(
                child : ButtonBox(
                text: "Add",
                onTap: () {},
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
