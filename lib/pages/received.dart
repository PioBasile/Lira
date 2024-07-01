import 'package:flutter/material.dart';
import 'package:lira/components/inputbox.dart';
import 'package:lira/components/buttonbox.dart';
import 'package:lira/services/calculations/calculations.dart';
import 'package:lira/services/database/db_manip.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:avoid_keyboard/avoid_keyboard.dart';


class Received extends StatefulWidget {
  const Received({super.key});

  @override
  State<Received> createState() => _ReceivedState();
}

class _ReceivedState extends State<Received> {
  final TextEditingController amountRController = TextEditingController();
  final TextEditingController dateRController = TextEditingController();
  final TextEditingController timeRController = TextEditingController();
  final TextEditingController descriptionRController = TextEditingController();
  final TextEditingController personRController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateRController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    timeRController.text = DateFormat('HH:mm').format(DateTime.now());
  }

  void _addReceivedPayment(BuildContext context) async {
    double amount = double.tryParse(amountRController.text) ?? 0.0;

    String description = descriptionRController.text;

    String person = personRController.text;

    DateTime date = DateFormat('dd/MM/yyyy').parse(dateRController.text);

    TimeOfDay time = TimeOfDay(
        hour: int.parse(timeRController.text.split(':')[0]),
        minute: int.parse(timeRController.text.split(':')[1]));

    DateTime dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    FireStoreService service = FireStoreService();
    await service.createReceivedPayment( amount, description, dateTime, person);
    loadAllData();


    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Received payment successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return AvoidKeyboard(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        body: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding around the content
          child: SingleChildScrollView( // Makes the view scrollable, which helps with smaller devices or large input forms.
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
                  hintText: 'Enter amount',
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
                              style: TextStyle(color: Colors.white, fontSize: 20)),
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
                              style: TextStyle(color: Colors.white, fontSize: 20)),
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
                const SizedBox(height: 30),
                Center(
                    child: ButtonBox(
                  text: "Add",
                  onTap: () => _addReceivedPayment(context),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
