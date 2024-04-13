import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:test/components/buttonbox.dart';
import 'package:test/components/inputbox.dart';
import 'package:test/services/database/firestore.dart';

class Payed extends StatefulWidget {
  const Payed({super.key});

  @override
  State<Payed> createState() => _PayedState();
}

class _PayedState extends State<Payed> {
  final TextEditingController amountController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController timeController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController categoryController = TextEditingController();

  List<Map<String, dynamic>> categories = [
    {'name': 'Home', 'isChecked': false},
    {'name': 'Supermarket', 'isChecked': false},
    {'name': 'Health', 'isChecked': false},
    {'name': 'Education', 'isChecked': false},
    {'name': 'Entertainment', 'isChecked': false},
    {'name': 'Transport', 'isChecked': false},
    {'name': 'Clothing', 'isChecked': false},
    {'name': 'Restaurant', 'isChecked': false},
  ];

  void _addPayment(BuildContext context) async {
    double amount = double.tryParse(amountController.text) ?? 0.0;

    String description = descriptionController.text;

    List<String> categories = [categoryController.text];

    DateTime date = DateFormat('dd/MM/yyyy').parse(dateController.text);

    TimeOfDay time = TimeOfDay(
        hour: int.parse(timeController.text.split(':')[0]),
        minute: int.parse(timeController.text.split(':')[1]));

    DateTime dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    FireStoreService service = FireStoreService();
    await service.updateOrCreateTransaction(
        amount, description, dateTime, categories, true);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment added successfully')));
  }

  @override
  void initState() {
    super.initState();
    // Initialise les contrôleurs avec la date et l'heure actuelles
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    timeController.text = DateFormat('HH:mm').format(DateTime.now());
  }

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    timeController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }

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
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              InputBox(
                  controller: amountController,
                  hintText: 'Enter amount',
                  obscureText: false,
                  obligatory: true,
                  keyboardType: "text"),
              const SizedBox(height: 20),
              const Text('Description',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              InputBox(
                  controller: descriptionController,
                  hintText: 'Optional but recommended',
                  obscureText: false,
                  obligatory: false,
                  keyboardType: "text"),
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
              ExpansionTile(
              title: const Text('Select Categories', style: TextStyle(color: Colors.white, fontSize: 20)),
              // ignore: sort_child_properties_last
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200, // Limit height for scrollable area
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: categories.map((category) {
                        return CheckboxListTile(
                          title: Text(category['name'], style: const TextStyle(color: Colors.white)),
                          checkColor: Colors.black,
                          activeColor: Colors.white,
                          value: category['isChecked'],
                          onChanged: (bool? value) {
                            setState(() {
                              category['isChecked'] = value!;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                ],
              backgroundColor: const Color.fromARGB(255, 18, 18, 18),
              iconColor: Colors.white,
              textColor: Colors.white,
            ),
            const SizedBox(height: 20),
    
              const SizedBox(height: 20),
              Center(
                child:
                    ButtonBox(text: "Add", onTap: () => _addPayment(context)),
              ),
              const SizedBox(height: 20),
              const Padding(
                  padding: EdgeInsets.only(left: 13.0),
                  child: Text('Daily Progress',
                      style: TextStyle(color: Colors.white, fontSize: 20))),
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
          )
        ),
      )
    );
  }
}
