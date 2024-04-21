import 'package:flutter/material.dart';
import 'package:test/components/buttonbox.dart';
import 'package:test/components/inputbox.dart';
import 'package:test/services/database/firestore.dart';

class FirstTime extends StatefulWidget {
  const FirstTime({super.key});

  @override
  State<FirstTime> createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  final TextEditingController bankAmountController = TextEditingController();
  final TextEditingController maxSpendingDayController =TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  List<String> categories = [];
  List<Map<String, dynamic>> recurringPayments = [];

  void _showAddRecurringPaymentDialog() {
    TextEditingController amountController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Recurring Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                    hintText: "Enter amount (e.g., 123.45)"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    hintText: "Enter description (e.g., Rent...)"),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                    hintText: "Enter date (e.g., 3 = 3rd of each month)"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (amountController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    dateController.text.isNotEmpty) {
                  _addRecPayment(double.parse(amountController.text),
                      descriptionController.text, dateController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

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
              hintText:'Enter your salary', 
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
            ExpansionTile(
              title: const Text("Select Categories",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              // ignore: sort_child_properties_last
              children: categories
                  .map((category) => ListTile(
                        title: Text(category,
                            style: const TextStyle(color: Colors.white70)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              setState(() => categories.remove(category)),
                        ),
                      ))
                  .toList(),
              trailing: IconButton(
                icon: const Icon(Icons.add, color: Colors.green),
                onPressed: () {
                  TextEditingController newCategoryController =
                      TextEditingController();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Add Category'),
                        content: TextField(
                          controller: newCategoryController,
                          decoration: const InputDecoration(
                              hintText: "Type new category"),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: const Text('Add'),
                            onPressed: () {
                              if (newCategoryController.text.isNotEmpty) {
                                setState(() {
                                  categories.add(newCategoryController.text);
                                });
                                updateOrCreateCategory(categories);
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recurring Payments',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: _showAddRecurringPaymentDialog,
                    icon: const Icon(Icons.add, color: Colors.green)),
              ],
            ),
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

  void updateOrCreateCategory(List<String> categories) {
    FireStoreService().updateOrCreateCategory(categories);
  }

  void saveInfo() {
    if(bankAmountController.text.isEmpty || maxSpendingDayController.text.isEmpty || salaryController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not all field were filled in'))
      );
    }
    double bankAmount = double.parse(bankAmountController.text);
    double maxSpendingDay = double.parse(maxSpendingDayController.text);
    double salary = double.parse(salaryController.text);
    
    FireStoreService().updateOrCreateInfo(salary,maxSpendingDay, bankAmount);
  }

  //ignore: no_leading_underscores_for_local_identifiers
  void _addRecPayment(double amount, String description, String date) {
      
    setState(() {
      recurringPayments
          .add({'amount': amount, 'description': description, 'date': date});
    });
    
    FireStoreService().updateOrCreateRecurringTransaction(recurringPayments);
    // ignore: avoid_print
    print("recPay : $recurringPayments");
  }
}
